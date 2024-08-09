if not lib then return end

local Items = require 'modules.items.shared' --[[@as table<string, OxClientItem>]]

local function sendDisplayMetadata(data)
    SendNUIMessage({
		action = 'displayMetadata',
		data = data
	})
end

--- use array of single key value pairs to dictate order
---@param metadata string | table<string, string> | table<string, string>[]
---@param value? string
local function displayMetadata(metadata, value)
	local data = {}

	if type(metadata) == 'string' then
        if not value then return end

        data = { { metadata = metadata, value = value } }
	elseif table.type(metadata) == 'array' then
		for i = 1, #metadata do
			for k, v in pairs(metadata[i]) do
				data[i] = {
					metadata = k,
					value = v,
				}
			end
		end
	else
		for k, v in pairs(metadata) do
			data[#data + 1] = {
				metadata = k,
				value = v,
			}
		end
	end

    if client.uiLoaded then
        return sendDisplayMetadata(data)
    end

    CreateThread(function()
        repeat Wait(100) until client.uiLoaded

        sendDisplayMetadata(data)
    end)
end

exports('displayMetadata', displayMetadata)

---@param _ table?
---@param name string?
---@return table?
local function getItem(_, name)
    if not name then return Items end

	if type(name) ~= 'string' then return end

    name = name:lower()

    if name:sub(0, 7) == 'weapon_' then
        name = name:upper()
    end

    return Items[name]
end

setmetatable(Items --[[@as table]], {
	__call = getItem
})

---@cast Items +fun(itemName: string): OxClientItem
---@cast Items +fun(): table<string, OxClientItem>

local function Item(name, cb)
	local item = Items[name]
	if item then
		if not item.client?.export and not item.client?.event then
			item.effect = cb
		end
	end
end

function checkItemsv(items)
  local name = nil
  for k,v in ipairs(items) do
    local checkItem = exports.ox_inventory:Search('count',v)
    if checkItem >= 1 then 
        name = v
        break
    end
  end
  return name
end

function checkItems_with_value(items,v)
  local name = nil
  for kk,vv in ipairs(items) do
    local checkItem = exports.ox_inventory:Search('count',vv)
    if checkItem >= v then 
        name = vv
        break
    end
  end
  return name
end
function multicheckItems(items)
    for k,v in ipairs(items) do
        local checkItem = exports.ox_inventory:Search('count',v)
        if checkItem < 1 then 
            return false
        end
    end
	return true
end


function CheckItem(items,v,metadata,multi)
    local SearchName = nil
    local SearchValue = v or 1  
    local ReturnData = {}
    for k,item in ipairs(items) do
        ReturnData[item] = 0
        local Items = exports.ox_inventory:GetPlayerItems()
        for _, v2 in pairs(Items) do
            if v2.metadata then
                if v2.metadata.container then
                    local ItemsX = lib.callback.await('CF_General:Item:ContainerItemList', false, v2.slot)
                    for i, v in ipairs(ItemsX) do
                        table.insert(Items,v)
                    end
                end
            end
        end
        for _,v in pairs(Items) do
            if v.name == item then
                if not v.metadata then v.metadata = {} end
                if not metadata or lib.table.contains(v.metadata, {type=metadata}) then
                    ReturnData[item] += v.count
                end
            end
        end
        if multi then
            if ReturnData[item] < SearchValue then
                return false
            end
        end
    end
    if multi then
        return true  
    else
        for _,item in ipairs(items) do
            if ReturnData[item] >= SearchValue then
                return item
            end
        end
    end
    return SearchName
end


local function SetWeapon(pedid,weapon_name)
	GiveWeaponToPed(pedid, GetHashKey(weapon_name), 1000, 0, false)
    SetCurrentPedWeapon(pedid, GetHashKey(weapon_name), true)
    SetPedCurrentWeaponVisible(pedid, true, false, false, false)
end
function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict( dict )
        Citizen.Wait(5)
    end
end
function IncurCooldown(ms)
    Citizen.CreateThread(function()
        Cooldown = true Wait(ms) Cooldown = false
    end)
end

function ToggleEmote(Dict,Anim,Move,Dur)
    local Ped = PlayerPedId(-1)
    while not HasAnimDictLoaded(Dict) do RequestAnimDict(Dict) Wait(100) end
    if IsPedInAnyVehicle(Ped) then Move = 51 end
    TaskPlayAnim(Ped, Dict, Anim, 3.0, 3.0, Dur, Move, 0, false, false, false)
    local Pause = Dur-500 if Pause < 500 then Pause = 500 end
    IncurCooldown(Pause)
    Wait(Pause) -- Lets wait for the emote to play for a bit then do the callback.
end

local ox_inventory = exports[shared.resource]
local xSound = exports['xsound']
-----------------------------------------------------------------------------------------------
-- Clientside item use functions
-----------------------------------------------------------------------------------------------
---------------------
-- 技術 測試用 Item
---------------------
Item('template_food', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_core:useTemplateItem', data)
		end
	end)
end)
Item('template_drink', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_core:useTemplateItem', data)
		end
	end)
end)
Item('template_useonly', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_core:useTemplateItem', data)
		end
	end)
end)
Item('devitems', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			local metadata = data.metadata
			if metadata.itemtype == 'skinData' then
				TriggerEvent('CF_character:oyuncukiyafetyukle', metadata.skinData)
				TriggerEvent('CF_character:tattoyukle', metadata.tattoData)
			end
			if metadata.itemtype == 'skinData2' then
				TriggerEvent('CF_character:oyuncukiyafetyukle', metadata.skinData)
				TriggerEvent('CF_character:tattoyukle', metadata.tattoData)
				TriggerServerEvent('CF_character:skinsave',metadata.skinData)
			end
		end
	end)
end)
Item('whalepic_effectcard', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			local metadata = data.metadata
			TriggerServerEvent('CF_core:addvalue', 'effects', metadata.effectname)
		end
	end)
end)
Item('whalepic_abilitycard', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			local metadata = data.metadata
			TriggerServerEvent('CF_core:addlevel', 'ability', metadata.abilityname, 1)
		end
	end)
end)
Item('whalepic_specialcard', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			local metadata = data.metadata
			TriggerServerEvent('CF_core:addlevel', 'special', metadata.specialname, 1)
		end
	end)
end)

---------------------
-- 悸動 (JDZ1)Item
---------------------

Item('jdz1_parchment', function(data, slot)
	ox_inventory:useItem(data, function(data)
		ExecuteCommand('showPic treasuremap02')
		lib.notify({duration = 10000,title = '道具描述',description = '背面的文字寫著：『玲瓏拔下龍麟妝點樹枝，而骨恕的生命根源，成為了玲瓏的角，死後兩者皆雙雙溶在生命之泉中，受眷顧的有情人在擺渡口，才有辦法看見。』',type = 'inform'})
	end)
end)

Item('jdz1_parchmentmap', function(data, slot)
	ox_inventory:useItem(data, function(data)
		ExecuteCommand('showPic treasuremap01')
		lib.notify({duration = 10000,title = '道具描述',description = '背面的文字寫著：『這片土地生長著不少相依為命的雙生古樹，不少人選在樹下埋藏他們的定情物，象徵愛意永恆。』',type = 'inform'})
	end)
end)

Item('jdz1_msg', function(data, slot)
	ox_inventory:useItem(data, function(data)
		lib.notify({duration = 10000,title = '道具描述',description = '使用後獲得「神秘的料理食譜」',type = 'inform'})
        TriggerServerEvent('CF_General:removeItem', 'jdz1_msg', 1)
		TriggerServerEvent('CF_General:giveItem', 'jdz1_srecipet', 1)  
	end)
end)

Item('jdz1_tool', function(data, slot)
	ox_inventory:useItem(data, function(data)
        TriggerServerEvent('CF_General:removeItem', 'jdz1_tool', 1)
		TriggerServerEvent('CF_General:giveItem', 't1-1', 1)    
		TriggerServerEvent('CF_General:giveItem', 't1-4', 1)   
		TriggerServerEvent('CF_General:giveItem', 't1-5', 1)   
		TriggerServerEvent('CF_General:giveItem', 'jdz1_spatula', 1)   
		TriggerServerEvent('CF_General:giveItem', 't166-1', 1)   
	end)
end)


local jdz1_card = {'jdz1_card1','jdz1_card2','jdz1_card3','jdz1_card4','jdz1_card5','jdz1_card6','jdz1_card7'}
local jdz1_medpksound = {'jdz1_kiss','jdz1_kiss2'}
Item('jdz1_medpk', function(data, slot)
	ox_inventory:useItem(data, function(data)
    	ExecuteCommand('heal me')
    	ExecuteCommand('showSound '..jdz1_medpksound[math.random(#jdz1_medpksound)])
    	TriggerServerEvent('CF_General:giveItem',jdz1_card[math.random(#jdz1_card)],1)
	end)
end)


Item('jdz1_recipet', function(data, slot)
	ox_inventory:useItem(data, function(data)
		ExecuteCommand('showPic jdz1_recipet')
		ExecuteCommand('giverecipe me jdz1_rosecookie')
		Citizen.Wait(200)
		ExecuteCommand('giverecipe me jdz1_choco')
		Citizen.Wait(200)
		ExecuteCommand('giverecipe me jdz1_cake')
		Citizen.Wait(200)
		ExecuteCommand('giverecipe me jdz1_belg')
		Citizen.Wait(200)
		ExecuteCommand('giverecipe me jdz1_cigar')
	end)
end)


Item('jdz1_srecipet', function(data, slot)
	ox_inventory:useItem(data, function(data)
		ExecuteCommand('showPic jdz1_srecipet')
		ExecuteCommand('giverecipe me jdz1_star')
	end)
end)

Item('jdz1_ticket', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:JDZ1:ticket')
		end
	end)
end)

Item('jdz1_ring', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_Teleport:Teleport:Trigger',vector3(2594.32, 4872.16, 34.48),1000)
			Citizen.Wait(2000)
			lib.notify({duration = 10000,title = '系統訊息',description = '恭喜配對成功',type = 'inform'})
		end
	end)
end)
Item('jdz1_card', function(data, slot)
	ox_inventory:useItem(data, function(data)
    	TriggerServerEvent('CF_General:giveItem',jdz1_card[math.random(#jdz1_card)],1)
	end)
end)

Item('jdz1_card1', function(data, slot) ox_inventory:useItem(data, function(data)	ExecuteCommand('showPic jdz1_card1') end) end)
Item('jdz1_card2', function(data, slot) ox_inventory:useItem(data, function(data)	ExecuteCommand('showPic jdz1_card2') end) end)
Item('jdz1_card3', function(data, slot) ox_inventory:useItem(data, function(data)	ExecuteCommand('showPic jdz1_card3') end) end)
Item('jdz1_card4', function(data, slot) ox_inventory:useItem(data, function(data)	ExecuteCommand('showPic jdz1_card4') end) end)
Item('jdz1_card5', function(data, slot) ox_inventory:useItem(data, function(data)	ExecuteCommand('showPic jdz1_card5') end) end)
Item('jdz1_card6', function(data, slot) ox_inventory:useItem(data, function(data)	ExecuteCommand('showPic jdz1_card6') end) end)
Item('jdz1_card7', function(data, slot) ox_inventory:useItem(data, function(data)	ExecuteCommand('showPic jdz1_card7') end) end)

Item('jdz10011-10', function(data, slot)
	ox_inventory:useItem(data, function(data)
    	TriggerEvent('CF_Collection:Fishing:Bait','jdz10011-10')
	end)
end)
 

---------------------
-- 殘烈 	(CL)(G1) Item
---------------------
Item('g1_1miao', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
            --TriggerServerEvent('esx_religion_initial:setJob', 'unemployed', 1) 
			exports['okokNotify']:Alert("疫苗", "注射完成", 5000, 'info')        
            TriggerEvent('CF_General:RecoverZem')
		end
	end)
end)
Item('g1_3931_can1', function(data, slot)
    ox_inventory:useItem(data, function(data)
        if data then
            TriggerEvent('CF_General:g1_3931_can1')
        end
    end)
end)
Item('g1_1788_foodcan4', function(data, slot)
    local ItemAuthorized = checkItemsv({'g1_opener'})
    if ItemAuthorized  ~= nil then
        ox_inventory:useItem(data, function(data)
        end)
    else
      lib.notify({type = 'error', description = '你沒有可以開啟他的工具'})
    end
end)
---------------------
-- 遺念 (YNS1)Item
---------------------
Item('yns1-notepad', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data.metadata.note then
			TriggerEvent('CF_YNS1_notepad:ReadItem', data.metadata.note)
		else
			ExecuteCommand('YNS1_wnotepad '.. data.slot)
		end
	end)
end)
Item('yns1-look2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		ExecuteCommand('showPic yns1_look2')
	end)
end)
Item('yns1_rules', function(data, slot)
	ox_inventory:useItem(data, function(data)
		ExecuteCommand('showPic rules')
	end)
end)
Item('yns1-glassescloth', function(data, slot)
	ox_inventory:useItem(data, function(data)
		lib.notify({duration = 5000,title = '動作描述',description = '眼鏡擦拭乾淨。',type = 'inform'})
	end)
end)
Item('yns1-phototransfer', function(data, slot)
	ox_inventory:useItem(data, function(data)
		TriggerEvent('CF_Props:PhotoTransfer:Printer')
	end)
end)
Item('yns1-photo', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			if data.metadata then
				if data.metadata.imageview then
					TriggerEvent('CF_MenuViewer:open',data.metadata.imageview)
				end
			end
		end
	end)
end)
Item('yns1-hulahoop', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('hula3')
        	lib.notify({duration = 10000,title = '道具狀況',description = '呼拉圈突然變超大，變得跟救生圈一樣大。',type = 'inform'})
		end
	end)
end)
Item('yns1-cft0001-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
        TriggerEvent('CF_MenuViewer:open:Story',{'CFT0001-1-1','CFT0001-1-2','CFT0001-1-3','CFT0001-1-4','CFT0001-1-5'},book)
	end)
end)
Item('yns1-cft0001-5', function(data, slot)
	ox_inventory:useItem(data, function(data)
        TriggerEvent('CF_MenuViewer:open:Story',{'CFT0001-5-1','CFT0001-5-2','CFT0001-5-3','CFT0001-5-4','CFT0001-5-5','CFT0001-5-6','CFT0001-5-7','CFT0001-5-8','CFT0001-5-9','CFT0001-5-10','CFT0001-5-11','CFT0001-5-12','CFT0001-5-13','CFT0001-5-14','CFT0001-5-15','CFT0001-5-16','CFT0001-5-17'},book)
	end)
end)
Item('yns1-cft0001-6', function(data, slot)
	ox_inventory:useItem(data, function(data)
        TriggerEvent('CF_MenuViewer:open:Story',{'CFT0001-6-1','CFT0001-6-2','CFT0001-6-3','CFT0001-6-4','CFT0001-6-5','CFT0001-6-6','CFT0001-6-7','CFT0001-6-8','CFT0001-6-9','CFT0001-6-10','CFT0001-6-11','CFT0001-6-12','CFT0001-6-13','CFT0001-6-14','CFT0001-6-15','CFT0001-6-16','CFT0001-6-17','CFT0001-6-18','CFT0001-6-19','CFT0001-6-20','CFT0001-6-21','CFT0001-6-22','CFT0001-6-23','CFT0001-6-24','CFT0001-6-25','CFT0001-6-26','CFT0001-6-27'},book)
	end)
end)
Item('yns1-cs0004-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
        lib.notify({duration = 10000,title = '心理感受',description = '吃完熱騰騰的泡麵後,你覺得心情好多了。',type = 'inform'})
	end)
end)
Item('yns1-cs0005-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
        lib.notify({duration = 10000,title = '道具提示 - 生理感受',description = '使吸菸者感受到愉悅感，有放鬆的效果。',type = 'inform'})
		if data then
			ExecuteCommand('e smoke3')
		end
	end)
end)
Item('yns1-cs0005-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		ExecuteCommand('showPic yns1-CS0005-2 none 0')
	end)
end)
Item('yns1-cs0005-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		ExecuteCommand('showPic yns1-CS0005-3 none 0')
	end)
end)
Item('yns1-cs0009-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		ExecuteCommand('showPic yns1-CS0009-1 none 1')
		xSound:PlayUrl('yns1-cs0009-1','yns1-CS0009-1',0.2,false)
        lib.notify({duration = 10000,title = '道具提示 - 心理感受',description = '你感覺在你眼前出現了現在最想見到的人，然後漸漸在眼前消失，你會有強烈地想要留下他的衝動。',type = 'inform'})
        lib.notify({duration = 10000,title = '道具提示 - 嗅覺感受',description = '你聞到花瓣淡淡的香氣。',type = 'inform'})
	end)
end)
Item('yns1-cs0009-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		ExecuteCommand('showPic yns1-CS0009-2 none 1')
        lib.notify({duration = 10000,title = '道具提示',description = '你將紙船放到水裡，紙船緩緩漂走',type = 'inform'})
	end)
end)
Item('yns1-cs0009-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		ExecuteCommand('showPic yns1-CS0009-3 none 1')
	end)
end)
Item('yns1-cs0008-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
        TriggerEvent('CF_General:Heal:Heal3',-0.1)
        lib.notify({duration = 10000,title = '道具提示 - 生理感受',description = '趕到嗜睡及嘔吐感...',type = 'inform'})
	end)
end)
Item('yns1-cs0008-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
        ExecuteCommand('e champagnespray2')
	end)
end)
Item('yns1-cs0008-5', function(data, slot)
	ox_inventory:useItem(data, function(data)
        ExecuteCommand('showPic yns1-cs0008-5')
	end)
end)

---------------------
-- 房蝕 (FSZ1)Item
---------------------
Item('fs_dirtynote', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				if data.metadata then
					if data.metadata.imageview then
						TriggerEvent('CF_MenuViewer:open',data.metadata.imageview)
					end
				end
			end)
		end
	end)
end)
Item('fs_needle', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:FSZ1:needle')
		end
	end)
end)
Item('fs_brokendiary', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				if data.metadata then
					if data.metadata.imageview then
						TriggerEvent('CF_MenuViewer:open',data.metadata.imageview)
					end
				end
			end)
		end
	end)
end)
Item('fs_diary1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','FSZ1_diary1')
			end)
		end
	end)
end)
Item('fs_diary2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','FSZ1_diary2')
			end)
		end
	end)
end)
Item('fs_blood1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','fs_blood1')
			end)
		end
	end)
end)
Item('fs_blood2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','fs_blood2')
			end)
		end
	end)
end)
Item('fs_ig1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','fs_ig1')
			end)
		end
	end)
end)
Item('fs_ig2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','fs_ig2')
			end)
		end
	end)
end)
Item('fs_ig3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','fs_ig3')
			end)
		end
	end)
end)
Item('fs_loveletter', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','test_catr')
			end)
		end
	end)
end)
Item('fs_deathnote', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','fs_deathnoteX')
			end)
		end
	end)
end)
Item('fs_notepage', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				if data.metadata then
					if data.metadata.imageview then
						TriggerEvent('CF_MenuViewer:open',data.metadata.imageview)
					end
				end
			end)
		end
	end)
end)
Item('fs_note7', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','fs_note7')
			end)
		end
	end)
end)
Item('fs_note8', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','fs_note8')
			end)
		end
	end)
end)
Item('fs_note9', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','fs_note9')
			end)
		end
	end)
end)
Item('fs_note10', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','fs_note10')
			end)
		end
	end)
end)
Item('fs_movie1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				if data.metadata then
					if data.metadata.imageview then
						TriggerEvent('CF_MenuViewer:open',data.metadata.imageview)
					end
				end
			end)
		end
	end)
end)
Item('fs_medicenrecord', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				if data.metadata then
					if data.metadata.imageview then
						TriggerEvent('CF_MenuViewer:open',data.metadata.imageview)
					end
				end
			end)
		end
	end)
end)
Item('fs_medicenrecord2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				if data.metadata then
					if data.metadata.imageview then
						TriggerEvent('CF_MenuViewer:open',data.metadata.imageview)
					end
				end
			end)
		end
	end)
end)


----------------------------------------------------------------
-- 基礎B(Basic) Item
----------------------------------------------------------------
Item('phone', function(data, slot)
	local success, result = pcall(function()
		return exports.npwd:isPhoneVisible()
	end)

	if success then
		exports.npwd:setPhoneVisible(not result)
	end
end)
Item('bpclothing', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerServerEvent('CF_core:useCloth', data, slot)
		end
	end)
end)
Item('notepad', function(data, slot)
	ox_inventory:useItem(data, function(data)
		ExecuteCommand('wnotepad '.. data.slot)
	end)
end)
Item('notepage', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data.metadata.note then
			TriggerEvent('CF_notepad:ReadItem', data.metadata.note, data.slot)
		end
	end)
end)
Item('wheelchair', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
        	ExecuteCommand('wheelchair')
		end
	end)
end)
Item('umbrella', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
        	ExecuteCommand('umbrella')
		end
	end)
end)
----------------------------------------------------------------
-- 動物A(Animal) Item
----------------------------------------------------------------
Item('animal-flute', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			local metadata = data.metadata
			TriggerEvent('CF_RideAnimal:Iten:TriggerMenu',metadata.type)
		end
	end)
end)
Item('animal-flute_deer', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_RideAnimal:Iten:TriggerMenu','deer')
		end
	end)
end)
Item('animal-flute_horse', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_RideAnimal:Iten:TriggerMenu','horse')
		end
	end)
end)
Item('animal-flute_boar', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_RideAnimal:Iten:TriggerMenu','boar')
		end
	end)
end)
Item('animal-flute_lion', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_RideAnimal:Iten:TriggerMenu','mtlion')
		end
	end)
end)
Item('animal-flute_cow', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_RideAnimal:Iten:TriggerMenu','cow')
		end
	end)
end)
----------------------------------------------------------------
-- 道具P(Props) Item
----------------------------------------------------------------
Item('p_cone', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('cone')
		end
	end)
end)
Item('p_barrier', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('P_barrier2')
		end
	end)
end)
Item('p_barrier2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('P_barrier')
		end
	end)
end)

----------------------------------------------------------------
-- 原料O(Orignal) Item
----------------------------------------------------------------
Item('o33-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_3240_curry')
			end)
		end
	end)
end)
Item('o63-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx:showNotification', '嘴裡充滿鹹味，請盡快飲水。')
		end
	end)
end)
----------------------------------------------------------------
-- 採集C(Collection) Item
----------------------------------------------------------------
Item('c6-1', function(data, slot)
    local ItemAuthorized = checkItemsv({'g1_3240_sawcleanner','g1_2529_cleanner','g1_9999_cleanner','g1_0591_cleanner'})
    local ItemAuthorized2 = checkItems_with_value({'rain_water'},2)
    if ItemAuthorized  ~= nil and ItemAuthorized2 ~= nil then
        lib.notify({title = '濾水系統',description = '正在進行濾水',type = 'inform'})
        if lib.progressBar({
                    duration = math.random(15 * 1000,30*1000) ,
                    label = '進行濾水',useWhileDead = false,canCancel = true,disable = {car = true,},
                    anim = {scenario = "PROP_HUMAN_BUM_BIN",},
                }) then 
            TriggerServerEvent('wf_logs:addone', 'collection_cleaning_watering_success')
            TriggerServerEvent('CF_General:giveItem', 'water', 1)  
            TriggerServerEvent('CF_General:removeItem', 'rain_water', 2)  
            lib.notify({title = '濾水系統',description = '濾水成功',type = 'success'})
            if math.random(1,100) > (80+math.random(0,20)) then 
                TriggerServerEvent('CF_General:removeItem',ItemAuthorized ,1) 
                lib.notify({title = '濾水系統',description = '濾水相關道具損毀',type = 'success'})
            end
        else 
            TriggerServerEvent('wf_logs:addone', 'collection_cleaning_watering_fail')
            lib.notify({title = '濾水系統',description = '濾水中斷',type = 'error'})
        end     
    else 
        ox_inventory:useItem(data, function(data)
            if data then
                ExecuteCommand('helpme_giveitem bottle 1')
            end
        end)
    end
end)
Item('c7-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				ExecuteCommand('helpme_giveitem bottle 1')
			end)
		end
	end)
end)
Item('c43-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e bouquet')
		end
	end)
end)
Item('c84-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
        	TriggerEvent('CF_General:stones')
		end
	end)
end)
Item('c94-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx_religion_initial:heal3',0.1)
		end
	end)
end)
Item('c103-1', function(data, slot)
    local ItemAuthorized = checkItemsv({'g1_3240_sawcleanner','g1_2529_cleanner','g1_9999_cleanner','g1_0591_cleanner'})
    local ItemAuthorized2 = checkItems_with_value({'g1_dirty_water'},4)
    if ItemAuthorized  ~= nil and ItemAuthorized2 ~= nil then
        lib.notify({title = '濾水系統',description = '正在進行濾水',type = 'inform'})
        if lib.progressBar({
                    duration = math.random(15 * 1000,30*1000) ,
                    label = '進行濾水',useWhileDead = false,canCancel = true,disable = {car = true,},
                    anim = {scenario = "PROP_HUMAN_BUM_BIN",},
                }) then 
            TriggerServerEvent('wf_logs:addone', 'collection_cleaning_watering_success')
            TriggerServerEvent('CF_General:giveItem', 'water', 1)  
            TriggerServerEvent('CF_General:removeItem', 'g1_dirty_water', 4)  
            lib.notify({title = '濾水系統',description = '濾水成功',type = 'success'})
            if math.random(1,100) > (80+math.random(0,20)) then 
                TriggerServerEvent('CF_General:removeItem',ItemAuthorized ,1) 
                lib.notify({title = '濾水系統',description = '濾水相關道具損毀',type = 'success'})
            end
        else 
            TriggerServerEvent('wf_logs:addone', 'collection_cleaning_watering_fail')
            lib.notify({title = '濾水系統',description = '濾水中斷',type = 'error'})
        end     
    else 
        ox_inventory:useItem(data, function(data)
            if data then
                ExecuteCommand('helpme_giveitem bottle 1')
            end
        end)
    end
end)
Item('c123-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('esx_religion_initial:screen_dragon2')
			end)
		end
	end)
end)
----------------------------------------------------------------
-- 食品F(Food) Item
----------------------------------------------------------------
Item('f3-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				xSound:PlayUrl('wolf_rgbcream', './sounds/wolf_rgbcream.ogg', 1.0, false)
				SetRunSprintMultiplierForPlayer(PlayerId(-1),1.34)
				Citizen.Wait(10*60*1000)
				SetRunSprintMultiplierForPlayer(PlayerId(-1),1.00)

			end)
		end
	end)
end)
Item('f3-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				xSound:PlayUrl('gua_rgbcream', './sounds/gua_rgbcream.ogg', 1.0, false)
				SetRunSprintMultiplierForPlayer(PlayerId(-1),1.34)
				Citizen.Wait(10*60*1000)
				SetRunSprintMultiplierForPlayer(PlayerId(-1),1.00)
			end)
		end
	end)
end)
Item('f8-2', function(data, slot)
	local maxHealth = 200
	local health = GetEntityHealth(PlayerData.ped)
	ox_inventory:useItem(data, function(data)
		if data then
			SetEntityHealth(PlayerData.ped, math.min(maxHealth, math.floor(health - maxHealth / 50)))
			xSound:PlayUrl('tao_soup', './sounds/tao_soup.ogg', 0.25, false)
			TriggerEvent('esx:showNotification', '感覺有鋒利的東西扎進牙駐那個坑邊搓邊往下扎')
		end
	end)
end)
Item('f9-2', function(data, slot)
	local maxHealth = 200
	local health = GetEntityHealth(PlayerData.ped)
	ox_inventory:useItem(data, function(data)
		if data then
			SetEntityHealth(PlayerData.ped, math.min(maxHealth, math.floor(health - maxHealth / 50)))
			xSound:PlayUrl('tao_riceballs', './sounds/tao_riceballs.ogg', 0.25, false)
			TriggerEvent('esx:showNotification', '太陽穴抽痛，疼到暈厥無法思考牙齒被啃的感受')
		end
	end)
end)
Item('f23-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				xSound:PlayUrl('d_cheez', './sounds/pio_lion.mp3', 0.45, false)
			end)
		end
	end)
end)
Item('f23-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				xSound:PlayUrl('d_cheez', './sounds/pio_wtf.mp3', 0.75, false)
			end)
		end
	end)
end)
Item('f50-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_MenuViewer:open','r7_guan')
			xSound:PlayUrl('kai_foodb', './sounds/r7_guan.mp3', 0.3, false)
		end
	end)
end)
Item('f82-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e chicken')
		end
	end)
end)
Item('f83-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e thumbsup')
		end
	end)
end)
Item('f91-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				xSound:PlayUrl('maru_tea3345678', './sounds/maru_tea3345678.ogg', 0.45, false)
			end)
		end
	end)
end)
Item('f93-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then	
			xSound:PlayUrl('hagua_alpes', './sounds/hagua_alpes.mp3', 0.5, false)
		end
	end)
end)
Item('f94-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('hagua_purewhite', './sounds/hagua_purewhite.mp3', 0.5, false)
		end
	end)
end)
Item('f107-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('rain_happy', './sounds/rain_happy.ogg', 0.5, false)
		end
	end)
end)
Item('f110-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
            TriggerServerEvent('CF_General:giveItem', 'hagua_dirty_lunch_box', 2) 
		end
	end)
end)
Item('f113-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx_religion_initial:red_screen20')
		end
	end)
end)
Item('f137-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				xSound:PlayUrl('d_cheez', './sounds/d_cheez.mp3', 0.75, false)
			end)
		end
	end)
end)
Item('f194-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx:showNotification', '好吃到想跟棠翎炒飯...我是說學炒飯...')
			xSound:PlayUrl('hlin_firice', './sounds/hlin_firice.mp3', 0.5, false)
		end
	end)
end)
Item('f208-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('esx:showNotification', '寒冷彷彿被凝視')
				local doragon_herti = 0
				while doragon_herti < 60 do
		            SetTimecycleModifier("New_sewers")    
		            SetTimecycleModifierStrength(3.0)   
		            Citizen.Wait(100)  
		            SetTimecycleModifier("Drug_deadman_blend")    
		            SetTimecycleModifierStrength(7.0)   
		            Citizen.Wait(100)  
		            SetTimecycleModifier("New_sewers")    
		            SetTimecycleModifierStrength(10.0)   
		            Citizen.Wait(100)  
		            SetTimecycleModifier("Drug_deadman_blend")    
		            SetTimecycleModifierStrength(3.0)   
		            Citizen.Wait(100)  
		            SetTimecycleModifier("Drug_deadman_blend")    
		            SetTimecycleModifierStrength(7.0)   
		            Citizen.Wait(100)  
		            SetTimecycleModifier("Drug_deadman_blend")    
		            SetTimecycleModifierStrength(10.0)   
		            Citizen.Wait(100) 
		            SetTimecycleModifier("Drug_deadman_blend")    
		            SetTimecycleModifierStrength(35.0)   
		            Citizen.Wait(100)  
		            SetTimecycleModifier("Drug_deadman_blend")    
		            SetTimecycleModifierStrength(75.0)   
		            Citizen.Wait(100)  
		            SetTimecycleModifier("New_sewers")    
		            SetTimecycleModifierStrength(325.0)   
		            Citizen.Wait(100) 
		            SetTimecycleModifier("Drug_deadman_blend")    
		            SetTimecycleModifierStrength(35.0)   
		            Citizen.Wait(100)
		            doragon_herti = doragon_herti + 1
		            print(doragon_herti)
				end
				ClearTimecycleModifier()
			end)
		end
	end)
end)
Item('f209-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_core:doragon_spring')
		end
	end)
end)
Item('f210-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				xSound:onPlayStart('doragon_eyes', function()
					SetPedMaxTimeUnderwater(PlayerId(-1), 1500.0)
				end)
				xSound:onPlayEnd('doragon_eyes', function()
					SetPedMaxTimeUnderwater(PlayerId(-1), 80.0)
				end)
				xSound:PlayUrl('doragon_eyes', './sounds/doragon_eyes.mp3', 1.0, false)
			end)
		end
	end)
end)
Item('f232-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('arbe_damn', './sounds/arbe_damn.mp3', 0.25, false)
		end
	end)
end)
Item('f243-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','maru_fastline2')
				Wait(5*1000)
				TriggerEvent('wf_menuViewer:picFadeout',2*1000)
			end)
		end
	end)
end)
Item('f246-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_core:gua_fastline')
		end
	end)
end)
Item('f247-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('ruru_rincookie', './sounds/ruru_rincookie.mp3', 0.5, false)
		end
	end)
end)
Item('f248-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('ruru_ningcookie', './sounds/ruru_ningcookie.mp3', 0.5, false)
		end
	end)
end)
Item('f249-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('ruru_nicookie', './sounds/ruru_nicookie.mp3', 0.5, false)
		end
	end)
end)
Item('f272-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:FullOpenPic','maru_mancoffee.jpg',10)
				Wait(1000)
				TriggerEvent('wf_menuViewer:picFadeout', 2*1000)
			end)
		end
	end)
end)
Item('f277-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('dolagon_now', './sounds/dolagon_now.mp3', 0.25, false)
		end
	end)
end)
Item('f287-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx:showNotification', '心神舒爽!!!!!!')
			xSound:PlayUrl('maru_corntea', './sounds/maru_corntea.mp3', 0.25, false)
		end
	end)
end)
Item('f302-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx:showNotification', '你更愛棠棠了。')
			xSound:PlayUrl('hlin_taow', './sounds/hlin_taow.mp3', 0.2, false)
		end
	end)
end)
Item('f303-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx:showNotification', '你覺得歆情特好,有種愛的衝動。')
			xSound:PlayUrl('hlin_taow', './sounds/hlin_taow.mp3', 0.2, false)
		end
	end)
end)
Item('f321-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx:showNotification', '一切還是一如往常,但你好想親口棠棠。')
			xSound:PlayUrl('hlin_taow', './sounds/hlin_taow.mp3', 0.2, false)
		end
	end)
end)
Item('f375-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx_religion_initial:staminaupper')
		end
	end)
end)
Item('f382-1', function(data, slot)
	local maxHealth = 200
	local health = GetEntityHealth(PlayerData.ped)
	ox_inventory:useItem(data, function(data)
		if data then
			SetEntityHealth(PlayerData.ped, math.min(maxHealth, math.floor(health - maxHealth / 50)))
			xSound:PlayUrl('tao_jiji', './sounds/tao_jiji.ogg', 0.25, false)
			TriggerEvent('esx:showNotification', '口乾舌燥')
		end
	end)
end)
Item('f390-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				xSound:PlayUrl('pio_ha', './sounds/pio_ha.mp3', 0.55, false)
				TriggerEvent('CF_MenuViewer:open','double-hachi')
				TriggerEvent('wf_menuViewer:picFadeout', 700)
			end)
		end
	end)
end)
Item('f418-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx:showNotification', '濃郁的杏仁味中，充斥著少女的香味~~')
		end
	end)
end)
Item('f421-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerServerEvent('CF_core:hagua_galettes')
		end
	end)
end)
Item('f431-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx:showNotification', '幸運餅乾給你勇氣')
			TriggerServerEvent('CF_core:gua_fortunecookiea')
		end
	end)
end)
Item('f432-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx:showNotification', '你的手不受控制的舉起來了。')
			TriggerEvent('Radiant_Animations:handsup', true)
			Wait(20*1000)
			TriggerEvent('esx:showNotification', '感覺到不受控制的手漸漸放緩。')
			TriggerEvent('Radiant_Animations:handsup', false)
		end
	end)
end)
Item('f435-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerServerEvent('CF_core:gua_oceansundae')
		end
	end)
end)
Item('f436-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx:showNotification', '補充維他命B群。')
			TriggerServerEvent('CF_core:fruittart')
		end
	end)
end)
Item('f437-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx:showNotification', '緩解痠痛，通體舒暢!')
			TriggerEvent('CF_core:qqcandy')
		end
	end)
end)
Item('f438-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx:showNotification', '緩解脹氣促進腸胃蠕動。')
			TriggerServerEvent('CF_core:fart')
		end
	end)
end)
Item('f450-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx:showNotification', '吃了琥珀糖')
		end
	end)
end)
Item('f451-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('shakecandy', './sounds/shakecandy.mp3', 0.25, false)
			TriggerEvent('esx:showNotification', '倒出了琥珀糖!')
		end
	end)
end)
Item('f457-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx:showNotification', '覺得吃起來真的很硬，但是充滿能量。')
		end
	end)
end)
Item('f458-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx:showNotification', '覺得吃起來真的很硬，但是充滿能量。')
		end
	end)
end)
Item('f459-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx:showNotification', '覺得吃起來真的很硬，但是充滿能量。')
		end
	end)
end)
Item('f467-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				xSound:PlayUrl('fallinlove', './sounds/fallinlove.ogg', 0.25, false)
				TriggerEvent('esx:showNotification', '有戀愛的感覺。')
	            SetTimecycleModifier("PPFilter")
	            Wait(30*1000)
	            ClearTimecycleModifier()
			end)
		end
	end)
end)
Item('f471-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('gua_s2', './sounds/gua_s2.ogg', 1.0, false)
			TriggerEvent('esx:showNotification', '感覺到快樂!! 非常快樂!! 。')
		end
	end)
end)
Item('f473-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('esx:showNotification', '覺得眼前的一切都可愛到不行')
				xSound:PlayUrl('gua_s1', './sounds/gua_s1.ogg', 0.25, false)
				TriggerEvent('wf_menuViewer:FullOpenPic', 'gua_fish.png', 1000)
				Wait(21*1000)
				TriggerEvent('wf_menuViewer:picFadeout',2*1000)
			end)
		end
	end)
end)
Item('f597-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				xSound:PlayUrl('beluga_wtf', './sounds/beluga_wtf.ogg', 0.3, false)
				TriggerEvent('esx:showNotification', '你感覺到緊繃的大腦身心靈都放鬆了')
	            SetTimecycleModifier("PPFilter")
	            Wait(53*1000)
	            ClearTimecycleModifier()
			end)
		end
	end)
end)
Item('f598-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx:showNotification', '覺得眼前的一切都可愛到不行')
			xSound:PlayUrl('gua_s1', './sounds/gua_s1.ogg', 0.25, false)
			TriggerEvent('wf_menuViewer:FullOpenPic','gua_s1.png',1000)
			Wait(21*1000)
			TriggerEvent('wf_menuViewer:picFadeout',2*1000)
		end
	end)
end)
Item('f672-2', function(data, slot)
    local ItemAuthorized = checkItemsv({'g1_opener'})
    if ItemAuthorized  ~= nil then
        ox_inventory:useItem(data, function(data)
        end)
    else
      lib.notify({type = 'error', description = '你沒有可以開啟他的工具'})
    end
end)
Item('f673-1', function(data, slot)
    local ItemAuthorized = checkItemsv({'g1_opener'})
    if ItemAuthorized  ~= nil then
        ox_inventory:useItem(data, function(data)
        end)
    else
      lib.notify({type = 'error', description = '你沒有可以開啟他的工具'})
    end
end)
Item('f674-1', function(data, slot)
    local ItemAuthorized = checkItemsv({'g1_opener'})
    if ItemAuthorized  ~= nil then
        ox_inventory:useItem(data, function(data)
        end)
    else
      lib.notify({type = 'error', description = '你沒有可以開啟他的工具'})
    end
end)
Item('f676-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('g1_5748_letmedoitforyou', './sounds/g1_5748_letmedoitforyou.ogg', 0.55, false)
		end
	end)
end)
Item('f692-1', function(data, slot)
    local ItemAuthorized = checkItemsv({'g1_opener'})
    if ItemAuthorized  ~= nil then
        ox_inventory:useItem(data, function(data)
        end)
    else
      lib.notify({type = 'error', description = '你沒有可以開啟他的工具'})
    end
end)
Item('f693-1', function(data, slot)
    local ItemAuthorized = checkItemsv({'g1_opener'})
    if ItemAuthorized  ~= nil then
        ox_inventory:useItem(data, function(data)
        end)
    else
      lib.notify({type = 'error', description = '你沒有可以開啟他的工具'})
    end
end)
Item('f694-1', function(data, slot)
    local ItemAuthorized = checkItemsv({'g1_opener'})
    if ItemAuthorized  ~= nil then
        ox_inventory:useItem(data, function(data)
        end)
    else
      lib.notify({type = 'error', description = '你沒有可以開啟他的工具'})
    end
end)
Item('f695-1', function(data, slot)
    local ItemAuthorized = checkItemsv({'g1_opener'})
    if ItemAuthorized  ~= nil then
        ox_inventory:useItem(data, function(data)
        end)
    else
      lib.notify({type = 'error', description = '你沒有可以開啟他的工具'})
    end
end)
Item('f696-1', function(data, slot)
    local ItemAuthorized = checkItemsv({'g1_opener'})
    if ItemAuthorized  ~= nil then
        ox_inventory:useItem(data, function(data)
        end)
    else
      lib.notify({type = 'error', description = '你沒有可以開啟他的工具'})
    end
end)
Item('f697-1', function(data, slot)
    local ItemAuthorized = checkItemsv({'g1_opener'})
    if ItemAuthorized  ~= nil then
        ox_inventory:useItem(data, function(data)
        end)
    else
      lib.notify({type = 'error', description = '你沒有可以開啟他的工具'})
    end
end)
Item('f698-1', function(data, slot)
    local ItemAuthorized = checkItemsv({'g1_opener'})
    if ItemAuthorized  ~= nil then
        ox_inventory:useItem(data, function(data)
        end)
    else
      lib.notify({type = 'error', description = '你沒有可以開啟他的工具'})
    end
end)
Item('f699-1', function(data, slot)
    local ItemAuthorized = checkItemsv({'g1_opener'})
    if ItemAuthorized  ~= nil then
        ox_inventory:useItem(data, function(data)
        end)
    else
      lib.notify({type = 'error', description = '你沒有可以開啟他的工具'})
    end
end)
Item('f700-1', function(data, slot)
    local ItemAuthorized = checkItemsv({'g1_opener'})
    if ItemAuthorized  ~= nil then
        ox_inventory:useItem(data, function(data)
        end)
    else
      lib.notify({type = 'error', description = '你沒有可以開啟他的工具'})
    end
end)
Item('f701-1', function(data, slot)
    local ItemAuthorized = checkItemsv({'g1_opener'})
    if ItemAuthorized  ~= nil then
        ox_inventory:useItem(data, function(data)
        end)
    else
      lib.notify({type = 'error', description = '你沒有可以開啟他的工具'})
    end
end)
Item('f702-1', function(data, slot)
    local ItemAuthorized = checkItemsv({'g1_opener'})
    if ItemAuthorized  ~= nil then
        ox_inventory:useItem(data, function(data)
        end)
    else
      lib.notify({type = 'error', description = '你沒有可以開啟他的工具'})
    end
end)
Item('f703-1', function(data, slot)
    local ItemAuthorized = checkItemsv({'g1_opener'})
    if ItemAuthorized  ~= nil then
        ox_inventory:useItem(data, function(data)
        end)
    else
      lib.notify({type = 'error', description = '你沒有可以開啟他的工具'})
    end
end)
Item('f704-1', function(data, slot)
    local ItemAuthorized = checkItemsv({'g1_opener'})
    if ItemAuthorized  ~= nil then
        ox_inventory:useItem(data, function(data)
        end)
    else
      lib.notify({type = 'error', description = '你沒有可以開啟他的工具'})
    end
end)
Item('f705-1', function(data, slot)
    local ItemAuthorized = checkItemsv({'g1_opener'})
    if ItemAuthorized  ~= nil then
        ox_inventory:useItem(data, function(data)
        end)
    else
      lib.notify({type = 'error', description = '你沒有可以開啟他的工具'})
    end
end)
Item('f706-1', function(data, slot)
    local ItemAuthorized = checkItemsv({'g1_opener'})
    if ItemAuthorized  ~= nil then
        ox_inventory:useItem(data, function(data)
        end)
    else
      lib.notify({type = 'error', description = '你沒有可以開啟他的工具'})
    end
end)
Item('f733-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('g1_5748_wafer', './sounds/g1_5748_wafer.ogg', 0.55, false)
		end
	end)
end)
Item('f739-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('g1_1788_bread1', './sounds/g1_1788_bread1.mp3', 0.55, false)
		end
	end)
end)
Item('f777-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				ExecuteCommand('helpme_giveitem g1_3240_cup 1')
			end)
		end
	end)
end)
Item('f779-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				ExecuteCommand('helpme_giveitem g1_3240_viso 1')
			end)
		end
	end)
end)
Item('f784-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				ExecuteCommand('helpme_giveitem g1_3240_cup 1')
			end)
		end
	end)
end)
Item('f785-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				ExecuteCommand('helpme_giveitem g1_3240_cup 1')
			end)
		end
	end)
end)
Item('f786-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				ExecuteCommand('helpme_giveitem g1_3240_cup 1')
			end)
		end
	end)
end)
Item('f787-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				ExecuteCommand('helpme_giveitem g1_3240_cup 1')
			end)
		end
	end)
end)
Item('f792-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				ExecuteCommand('helpme_giveitem g1_3240_cup 1')
			end)
		end
	end)
end)
Item('f793-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				ExecuteCommand('helpme_giveitem g1_3240_cup 1')
			end)
		end
	end)
end)
Item('f888-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('helpme_giveitem g1_1397_littlefood 10')
		end
	end)
end)
Item('f890-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('helpme_giveitem g1_1397_currysauce 10')
		end
	end)
end)
Item('f895-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx_religion_initial:heal3',0.3)
		end
	end)
end)
Item('f940-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				xSound:PlayUrl('gua_fishpie', './sounds/gua_fishpie.ogg', 0.65, false)
			end)
		end
	end)
end)
Item('f942-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				xSound:PlayUrl('gua_redcream', './sounds/gua_redcream.ogg', 0.65, false)
			end)
		end
	end)
end)

Item('f951-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				local random_fate = {"s270-1","s270-3","s270-4","s270-5","s270-6","s270-7","s270-8","s270-9","s270-10","s270-11","s270-12","s270-13","s270-14","s270-15","s270-18"}
                TriggerServerEvent('CF_General:giveItem',random_fate[math.random(#random_fate)],1)
			end)
		end
	end)
end)


Item('f1004-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('smile_sea', './sounds/smile_sea.mp3', 0.55, false)
		end
	end)
end)
Item('f1011-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e jdj')
		end
	end)
end)


----------------------------------------------------------------
-- 藥品M(Medicine) Item
----------------------------------------------------------------
Item('m1-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx:showNotification', '把藥包拆開')
		end
	end)
end)
Item('m2-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			SetEntityHealth(PlayerData.ped, 200.0)
		end
	end)
end)
Item('m8-1', function(data, slot)
	if true then
		ox_inventory:useItem(data, function(data)
			if data then
        		ExecuteCommand('stopEffect me')
			end
		end)
	end
end)
Item('m14-1', function(data, slot)
	local maxHealth = 200
	local health = GetEntityHealth(PlayerData.ped)
	if true then
		ox_inventory:useItem(data, function(data)
			if data then
				SetEntityHealth(PlayerData.ped, math.min(maxHealth, math.floor(health + maxHealth / 2)))
				TriggerEvent('esx:showNotification', '感覺好多了')
			end
		end)
	end
end)
Item('m20-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx_religion_initial:heal3',0.3)
		end
	end)
end)
Item('m29-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('esx:showNotification', '感覺到緊繃的大腦身心靈都放鬆了。')
				Wait(5*1000)
				xSound:PlayUrl('beluga_wtf', './sounds/beluga_wtf.ogg', 0.3, false)
				TriggerEvent('esx:showNotification', '感覺到異常想睡。')
	            SetTimecycleModifier("PPFilter")
	            Wait(53*1000)
	            ClearTimecycleModifier()
			end)
		end
	end)
end)
Item('m38-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('malu_whaletear', './sounds/malu_whaletear.ogg', 0.25, false)
			TriggerEvent('esx:showNotification', '感覺飄飄然。')
		end
	end)
end)
Item('m46-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e smoke3')
			end
	end)
end)
Item('m47-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
            if math.random(1,100) >=58 then
				exports['okokNotify']:Alert("疫苗", "注射完成", 5000, 'info')
            	TriggerEvent('CF_General:RecoverZem')
            else
				exports['okokNotify']:Alert("疫苗", "注射完成(沒有生效)", 5000, 'info')
            end
		end
	end)
end)
----------------------------------------------------------------
-- 工具T(Tool) Item
----------------------------------------------------------------
Item('t1-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		TriggerEvent('CF_Collection:Tool:Trigger','fishing')
	end)
end)
Item('t1-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_General:hacha_dig')
			end)
		end
	end)
end)
Item('t1-4', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_General:teasure_dig')
			end)
		end
	end)
end)
Item('t2-1', function(data, slot)
		ox_inventory:useItem(data, function(data)
			if data then
				SetPedArmour(GetPlayerPed(-1), 100)
			end
		end)
end)
Item('t2-2', function(data, slot)
		ox_inventory:useItem(data, function(data)
			if data then
				SetPedArmour(GetPlayerPed(-1), 50)
			end
		end)
end)
Item('t4-1', function(data, slot)
	local maxHealth = 200
	local health = GetEntityHealth(PlayerData.ped)
	if true then
		ox_inventory:useItem(data, function(data)
			if data then
				SetEntityHealth(PlayerData.ped, math.min(maxHealth, math.floor(health + maxHealth / 10)))
				TriggerEvent('esx:showNotification', '感覺好多了')
			end
		end)
	end
end)
Item('t4-2', function(data, slot)
	local maxHealth = 200
	local health = GetEntityHealth(PlayerData.ped)
	if true then
		ox_inventory:useItem(data, function(data)
			if data then
				SetEntityHealth(PlayerData.ped, math.min(maxHealth, math.floor(health + maxHealth / 10)))
				TriggerEvent('esx:showNotification', '感覺好多了')
			end
		end)
	end
end)
Item('t4-4', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx_religion_initial:heal3',0.3)
		end
	end)
end)
Item('t5-2', function(data, slot)
	if true then
		ox_inventory:useItem(data, function(data)
			if data then
				ExecuteCommand('basketball')
			end
		end)
	end
end)
Item('t5-3', function(data, slot)
	if true then
		ox_inventory:useItem(data, function(data)
			if data then
				ExecuteCommand('football')
			end
		end)
	end
end)
Item('t13-1', function(data, slot)
	if true then
		ox_inventory:useItem(data, function(data)
			if data then
				TriggerEvent('esx_mechanicjob:onFixkit')
			end
		end)
	end
end)
Item('t20-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		TriggerEvent('CF_Props:TeleScope:Active',{0})
	end)
end)
Item('t20-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		TriggerEvent('CF_Props:TeleScope:Active',{0,1,2,3})
	end)
end)
Item('t22-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		ExecuteCommand('notes')
	end)
end)
Item('t24-1', function(data, slot)
	if true then
		ox_inventory:useItem(data, function(data)
			if data then
        		TriggerEvent('CF_Props:Driving:Toggle',1)  
			end
		end)
	end
end)
Item('t24-2', function(data, slot)
	if true then
		ox_inventory:useItem(data, function(data)
			if data then
        		TriggerEvent('CF_Props:Driving:Toggle',2)  
			end
		end)
	end
end)
Item('t26-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			-- ExecuteCommand('radio')
		end
	end)
end)
Item('t30-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_MusicBox:useBoombox')
			TriggerServerEvent('CF_General:removeItem','t30-1',1) 
		end
	end)
end)
Item('t40-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('nitro:start')
		end
	end)
end)
client.parachute = false
Item('t43-1', function(data, slot)
	if not client.parachute then
		ox_inventory:useItem(data, function(data)
			if data then
				local chute = `GADGET_PARACHUTE`
				SetPlayerParachuteTintIndex(PlayerData.id, -1)
				GiveWeaponToPed(cache.ped, chute, 0, true, false)
				SetPedGadget(cache.ped, chute, true)
				lib.requestModel(1269906701)
				client.parachute = CreateParachuteBagObject(cache.ped, true, true)
				if slot.metadata.type then
					SetPlayerParachuteTintIndex(PlayerData.id, slot.metadata.type)
				end
			end
		end)
	end
end)
Item('t45-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx_religion_initial:screen_dragon')
		end
	end)
end)
Item('t52-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_General:fishfree')
			end)
		end
	end)
end)
Item('t54-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			local craftingData = data.metadata.crafting
			if craftingData then
				--TriggerServerEvent('CF_core:addvalue', 'craft', metadata.crafting)
				TriggerServerEvent('CF_General:cf_core:Field:Add', 'craft' , craftingData)	
			else
		    	lib.notify({title = '道具內容',description = '沒有內容，非常白。',type = 'info'})
			end
		end
	end)
end)
Item('t54-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_core:startSynMenu')
		end
	end)
end)
Item('t58-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e smoke3')
		end
	end)
end)
Item('t58-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e smoke3')
		end
	end)
end)
Item('t58-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e smoke3')
		end
	end)
end)
Item('t60-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx:showNotification', '收起家傳廚刀組')
		end
	end)
end)
Item('t60-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx:showNotification', '打開家傳廚刀組')
		end
	end)
end)
Item('t61-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx_policejob:starthandcuff',data.name)
		end
	end)
end)
Item('t64-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('we_blindfold:open')
		end
    end)
end)
Item('t68-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
        	TriggerEvent('CF_General:bottle')
		end
	end)
end)
Item('t74-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
        	TriggerEvent('CF_General:NEWS:Toggle')
		end
	end)
end)


Item('t77-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('gcPhone:OpenPhone')
		end
    end)
end)
Item('t78-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			local metadata = data.metadata
			TriggerServerEvent('jsfour-idcard:open', metadata.student_id, metadata.url)
		end
	end)
end)
Item('t81-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
		    Citizen.CreateThread(function()
		        if lib.progressCircle({
		            label = '擦拭中...',
		            duration = 8000,
		            position = 'bottom',
				    anim = {
				        dict = 'mp_safehouseshower@male@',
				        clip = 'male_shower_idle_b'
				    },
		            useWhileDead = false,
		            canCancel = true,
		            }) then 
				    ClearPedBloodDamage(cache.ped)
				    ClearPedWetness(cache.ped)
                	TriggerServerEvent('CF_General:removeItem','t81-1',1) 
                	TriggerServerEvent('CF_General:giveItem','t81-3',1) 

		    		lib.notify({title = '擦拭系統',description = '清理完成',type = 'info'})
		        else
		    		lib.notify({title = '擦拭系統',description = '擦拭取消',type = 'error'})
		        end
		    end)
		end
	end)
end)
Item('t81-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
		    Citizen.CreateThread(function()
		        if lib.progressCircle({
		            label = '擦拭中...',
		            duration = 15000,
		            position = 'bottom',
				    anim = {
				        dict = 'mp_safehouseshower@male@',
				        clip = 'male_shower_idle_b'
				    },
		            useWhileDead = false,
		            canCancel = true,
		            }) then 
				    ClearPedBloodDamage(cache.ped)
				    ClearPedWetness(cache.ped)
				    ClearPedEnvDirt(cache.ped)
				    ResetPedVisibleDamage(cache.ped)
                	TriggerServerEvent('CF_General:removeItem','t81-2',1) 
                	TriggerServerEvent('CF_General:giveItem','t81-3',1) 
		    		lib.notify({title = '擦拭系統',description = '清理完成',type = 'info'})
		        else
		    		lib.notify({title = '擦拭系統',description = '擦拭取消',type = 'error'})
		        end
		    end)
		end
	end)
end)
Item('t81-4', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
		    Citizen.CreateThread(function()
		        if lib.progressCircle({
		            label = '使用中...',
		            duration = 8000,
		            position = 'bottom',
				    anim = {
				        dict = 'mp_safehouseshower@male@',
				        clip = 'male_shower_idle_b'
				    },
		            useWhileDead = false,
		            canCancel = true,
		            }) then 

					ApplyPedDamagePack(GetPlayerPed(-1),"HOSPITAL_5", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"HOSPITAL_6", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"HOSPITAL_7", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"HOSPITAL_8", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"HOSPITAL_9", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"SCR_Dumpster", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"BigHitByVehicle", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"SCR_Finale_Michael_Face", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"SCR_Franklin_finb", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"SCR_Finale_Michael", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"SCR_Franklin_finb2", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"Explosion_Med", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"SCR_Torture", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"SCR_TracySplash", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"Skin_Melee_0", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"Useful_Bits", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"Explosion_Large", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"Dirt_Dry", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"Dirt_Grass", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"Dirt_Mud", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"Burnt_Ped_Left_Arm", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"Burnt_Ped_Right_Arm", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"Burnt_Ped_Limbs", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"Burnt_Ped_Head_Torso", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"Burnt_Ped_0", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"Car_Crash_Light", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"Car_Crash_Heavy", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"Fall_Low", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"Fall", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"HitByVehicle", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"BigRunOverByVehicle", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"RunOverByVehicle", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"Splashback_Face_0", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"Splashback_Face_1", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"Splashback_Torso_0", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"Splashback_Torso_1", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"SCR_Cougar", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"SCR_DogAttack", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"SCR_Shark", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"TD_KNIFE_FRONT", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"TD_KNIFE_FRONT_VA", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"TD_KNIFE_FRONT_VB", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"TD_KNIFE_REAR", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"TD_KNIFE_REAR_VA", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"TD_KNIFE_REAR_VB", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"TD_KNIFE_STEALTH", 100, 100)
					ApplyPedDamagePack(GetPlayerPed(-1),"TD_MELEE_FRONT", 100, 100)

		    		lib.notify({title = '擦拭系統',description = '使用完成',type = 'info'})
		        else
		    		lib.notify({title = '擦拭系統',description = '使用取消',type = 'error'})
		        end
		    end)
		end
	end)
end)

Item('t82-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_Target:GYM:Item_Menu')
		end
	end)
end)
Item('t85-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e bouquet')
		end
	end)
end)
Item('t85-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e bouquet')
		end
	end)
end)
Item('t85-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e bouquet')
		end
	end)
end)
Item('t85-4', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e bouquet')
		end
	end)
end)
Item('t85-5', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e bouquet')
		end
	end)
end)
Item('t85-6', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e bouquet')
		end
	end)
end)
Item('t85-7', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e bouquet')
		end
	end)
end)
Item('t85-8', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e bouquet')
		end
	end)
end)
local g1_1742_knife1 = false
Item('t90-1', function(data, slot)
  ox_inventory:useItem(data, function(data)
    if data then
      Citizen.CreateThread(function()
        if weapon_flag1 then
          TriggerEvent('ox_inventory:clearWeapons')
        else
          SetWeapon(GetPlayerPed(-1),'weapon_switchblade')
        end
        weapon_flag1 = not weapon_flag1
      end)
    end
  end)
end)
local g1_1742_knife2 = false
Item('t90-2', function(data, slot)
  ox_inventory:useItem(data, function(data)
    if data then
      Citizen.CreateThread(function()
        if weapon_flag1 then
          TriggerEvent('ox_inventory:clearWeapons')
        else
          SetWeapon(GetPlayerPed(-1),'weapon_switchblade')
        end
        weapon_flag1 = not weapon_flag1
      end)
    end
  end)
end)
Item('t91-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				xSound:PlayUrl('g1_0604_tape', './sounds/g1_0604_radio.ogg', 0.75, false)
			end)
		end
	end)
end)
g1_airpod_flag = false
Item('t91-2', function(data, slot)
    local ItemAuthorized = checkItemsv({'g1_0604_better'})
    if ItemAuthorized  ~= nil then
        g1_airpod_flag  = not g1_airpod_flag 
        if g1_airpod_flag then
            xSound:PlayUrl('g1_1684_airpod', './sounds/g1_1684_airpod.ogg', 0.65, true)
            if math.random(1,100) > 90 then 
                TriggerServerEvent('CF_General:removeItem','g1_0604_better',1) 
                TriggerServerEvent('CF_General:giveItem','g1_0604_better2',1) 
            end
        else
            xSound:Destroy('g1_1684_airpod')
        end
    end
end)
Item('t92-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
    			TriggerEvent('dice_poker:Menu')
			end)
		end
	end)
end)
Item('t108-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e smoke3')
			end
	end)
end)
Item('t110-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e book')
			end
	end)
end)
Item('t111-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e book')
			end
	end)
end)
Item('t112-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e book')
			end
	end)
end)
Item('t113-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e book')
			end
	end)
end)
Item('t114-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e book')
			end
	end)
end)
local g1_0733_knife = false
Item('t129-1', function(data, slot)
  ox_inventory:useItem(data, function(data)
    if data then
      Citizen.CreateThread(function()
        if weapon_flag1 then
          TriggerEvent('ox_inventory:clearWeapons')
        else
          SetWeapon(GetPlayerPed(-1),'WEAPON_KNIFE')
        end
        weapon_flag1 = not weapon_flag1
      end)
    end
  end)
end)
local g1_3756_knife = false
Item('t131-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
		    Citizen.CreateThread(function()
		      if g1_3756_knife then
		        TriggerEvent('ox_inventory:clearWeapons')
		      else
		      	xSound:PlayUrl('g1_3756_knife', './sounds/g1_3756_knife.wav', 0.55, false)
		        SetWeapon(GetPlayerPed(-1),'WEAPON_BDSJ')
		      end
		      g1_3756_knife = not g1_3756_knife
		    end)
		end
	end)
end)
local g1_2871_knife = false
Item('t132-1', function(data, slot)
  ox_inventory:useItem(data, function(data)
    if data then
      Citizen.CreateThread(function()
        if weapon_flag1 then
          TriggerEvent('ox_inventory:clearWeapons')
        else
          SetWeapon(GetPlayerPed(-1),'WEAPON_KNIFE')
        end
        weapon_flag1 = not weapon_flag1
      end)
    end
  end)
end)
local g1_3618_ring = {
	id = 0,
	color = 0,
	flag = false}
Item('t133-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			if not g1_3618_ring.flag then
				g1_3618_ring.id = GetPedDrawableVariation(cache.ped, 2)
				g1_3618_ring.color = GetPedTextureVariation(cache.ped, 2)
				SetPedComponentVariation(cache.ped, 2, 178, 0, 0)
			else
				SetPedComponentVariation(cache.ped, 2, g1_3618_ring.id, g1_3618_ring.color, 0)
			end
			ToggleEmote("clothingtie","check_out_a", 51,2000)
			g1_3618_ring.flag = not g1_3618_ring.flag
		end
	end)
end)
Item('t134-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e smoke3')
			end
	end)
end)
local g1_4753_mask = {
	id = 0,
	color = 0,
	flag = false}
Item('t136-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			if not g1_4753_mask.flag then
				g1_4753_mask.id = GetPedDrawableVariation(cache.ped, 1)
				g1_4753_mask.color = GetPedTextureVariation(cache.ped, 1)
				SetPedComponentVariation(cache.ped, 1, 244, 0, 0)
			else
				SetPedComponentVariation(cache.ped, 1, g1_4753_mask.id, g1_4753_mask.color, 0)
			end
			ToggleEmote("mp_masks@standard_car@ds@","put_on_mask", 51,800)
			g1_4753_mask.flag = not g1_4753_mask.flag
		end
	end)
end)
Item('t140-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx_religion_initial:heal3',0.1)
		end
	end)
end)
Item('t142-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e smoke3')
			end
	end)
end)
Item('t145-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_6268_paper')
			end)
		end
	end)
end)
Item('t146-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
        	ExecuteCommand('Nation_effect')
		end
	end)
end)
Item('t151-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e smoke3')
			end
	end)
end)
Item('t154-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
		    ClearPedBloodDamage(PlayerPedId())
		    ClearPedWetness(PlayerPedId())
		    ClearPedEnvDirt(PlayerPedId())
		    ResetPedVisibleDamage(PlayerPedId())
		end
	end)
end)
Item('t160-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_3240_pot')
			end)
		end
	end)
end)
Item('t166-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_1001_pot')
			end)
		end
	end)
end)
Item('t168-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_3240_longmao')
			end)
		end
	end)
	local ItemAuthorized = checkItemsv({'g1_0604_better'})
	if ItemAuthorized  ~= nil then
		xSound:PlayUrl('g1_3240_longmao', './sounds/g1_3240_longmao.ogg', 0.55, false)
		if math.random(1,100) > 80 then 
			TriggerServerEvent('CF_General:removeItem','g1_0604_better',1) 
			TriggerServerEvent('CF_General:giveItem','g1_0604_better2',1) 
		end
	end
end)
Item('t173-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e danceglowstick')
			end
	end)
end)
Item('t175-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('g1_7566_ringring', './sounds/g1_7566_ringring.ogg', 0.45, false)
		end
	end)
end)
Item('t179-1', function(data, slot)
	local metadata = slot.metadata
	ox_inventory:useItem(data, function(data)
		xSound:PlayUrl('bon_obituary', './sounds/bon_obituary.ogg', 0.80, false)
		if metadata.wolfimage then
			TriggerEvent('CF_MenuViewer:open', metadata.wolfimage..'.png', 200)
		end
	end)
end)
Item('t182-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','salmon_peace')
			end)
		end
	end)
end)
Item('t183-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','hagua_wolf')
			end)
		end
	end)
end)
Item('t193-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('dora_zoe', './sounds/dora_zoe.mp3', 0.35, false)
		end
	end)
end)
Item('t197-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx_policejob:starthandcuff',data.name)
		end
	end)
end)
Item('t200-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','moka_credit_card')
			end)
		end
	end)
end)
Item('t201-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','moka_cheque')
			end)
		end
	end)
end)
Item('t202-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('ella_talk', './sounds/ella_talk.ogg', 0.55, false)
			TriggerEvent('CF_MenuViewer:open','ella_talk')
		end
	end)
end)
Item('t203-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','d_tod1')
			end)
		end
	end)
end)
local selection_list = {'笑筊','聖筊','陰筊','笑筊','聖筊','陰筊','笑筊','聖筊','陰筊','笑筊','聖筊','陰筊','笑筊','聖筊','陰筊','笑筊','聖筊','陰筊','立筊 '}
Item('t204-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				loadAnimDict("anim@mp_player_intcelebrationmale@wank")
				TaskPlayAnim(GetPlayerPed(-1), "anim@mp_player_intcelebrationmale@wank", "wank", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
				Citizen.Wait(1500)
				ClearPedTasks(GetPlayerPed(-1))
				ExecuteCommand('me '..selection_list[math.random(#selection_list)])
			end)
		end
	end)
end)
local lotterybox = {'吉','凶','慘','哭','悲','樂','大吉','大凶','中吉','問自己','哈哈'}
Item('t205-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				loadAnimDict("anim@mp_player_intcelebrationmale@wank")
				TaskPlayAnim(GetPlayerPed(-1), "anim@mp_player_intcelebrationmale@wank", "wank", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
				Citizen.Wait(1500)
				ClearPedTasks(GetPlayerPed(-1))
				ExecuteCommand('me '..lotterybox[math.random(#lotterybox)])
			end)
		end
	end)
end)
Item('t207-1', function(data, slot)
	local maxHealth = 200
	local health = GetEntityHealth(PlayerData.ped)
	ox_inventory:useItem(data, function(data)
		if data then
			SetEntityHealth(PlayerData.ped, math.min(maxHealth, math.floor(health - maxHealth / 10)))
			ExecuteCommand('helpme_giveitem pollution_syringe 1')
		end
	end)
end)

----------------------------------------------------------------
-- 特殊S(Special) Item
----------------------------------------------------------------
Item('s8-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','lulu_cardyen')
			end)
		end
	end)
end)
Item('s8-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','lulu_card5')
			end)
		end
	end)
end)
Item('s8-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','lulu_carddeer')
			end)
		end
	end)
end)
Item('s8-4', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','lulu_carddream')
			end)
		end
	end)
end)
Item('s8-5', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','lulu_cardhappy')
			end)
		end
	end)
end)
Item('s8-6', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','lulu_card04')
			end)
		end
	end)
end)
Item('s8-7', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','lulu_cardrin')
			end)
		end
	end)
end)
Item('s8-8', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','lulu_cardni')
			end)
		end
	end)
end)
Item('s8-9', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','lulu_cardshiny')
			end)
		end
	end)
end)
Item('s8-11', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','lulu_cardbrown')
			end)
		end
	end)
end)
Item('s10-8', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','whitecity_lovenote5')
			end)
		end
	end)
end)
Item('s10-9', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','whitecity_lovenote4')
			end)
		end
	end)
end)
Item('s10-10', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','whitecity_lovenote3')
			end)
		end
	end)
end)
Item('s10-11', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','whitecity_lovenote2')
			end)
		end
	end)
end)
Item('s10-12', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','whitecity_lovenote1')
			end)
		end
	end)
end)
Item('s11-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','bear_letter5')
			end)
		end
	end)
end)
Item('s11-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','bear_letter4')
			end)
		end
	end)
end)
Item('s11-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','bear_letter3')
			end)
		end
	end)
end)
Item('s11-4', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','bear_letter2')
			end)
		end
	end)
end)
Item('s11-5', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','bear_letter1')
			end)
		end
	end)
end)
Item('s12-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','lee_cooktang')
			end)
		end
	end)
end)
Item('s12-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','lee_cookshi')
			end)
		end
	end)
end)
Item('s12-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','lee_cookni')
			end)
		end
	end)
end)
Item('s13-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','wulong_note1')
			end)
		end
	end)
end)
Item('s13-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','wulong_note2')
			end)
		end
	end)
end)
Item('s13-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','wulong_note3')
			end)
		end
	end)
end)
Item('s13-4', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','wulong_note4')
			end)
		end
	end)
end)
Item('s13-5', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','wulong_note5')
			end)
		end
	end)
end)
Item('s13-6', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','wulong_note6')
			end)
		end
	end)
end)
Item('s13-7', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','wulong_note7')
			end)
		end
	end)
end)
Item('s13-8', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','wulong_note8')
			end)
		end
	end)
end)
Item('s13-9', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','wulong_note9')
			end)
		end
	end)
end)
Item('s15-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('yimo_message')
		end
	end)
end)
Item('s16-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
    		local boomAuthorized = checkItemsv({'electric_bug'})
            if boomAuthorized ~= nil then
    			exports['okokNotify']:Alert("寶石系統", "背包裡面的發光蟲，開始發出大量能量，匯集到黯淡的寶石身上。", 6000, 'info')  
                Citizen.CreateThread(function()
                	ExecuteCommand('pe_cat')
                    Citizen.Wait(6000)
                	ExecuteCommand('pe_cat')
                	ExecuteCommand('cat_boom')
    				exports['okokNotify']:Alert("寶石系統", "寶石恢復光芒。", 5000, 'info') 
                  	TriggerServerEvent('CF_General:removeItem','electric_bug',1) 
                  	TriggerServerEvent('CF_General:giveItem','techgem',1) 
                    TriggerServerEvent('wf_logs:addone', 'techgem2') 
                                
                end)
            end
		end
	end)
end)
Item('s16-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
            local maxHealth = 200
            SetEntityHealth(PlayerData.ped, 200)
            ExecuteCommand('pe_cat')
            Citizen.Wait(2000)
            TriggerServerEvent('wf_logs:addone', 'techgem') 
            ExecuteCommand('pe_cat')
		end
	end)
end)
Item('s17-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_MenuViewer:open','bon_book33')
		end
	end)
end)
Item('s22-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx:showNotification', '感覺甚麼都好了。')
		end
	end)
end)
Item('s24-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
            local maxHealth = 200
            SetEntityHealth(PlayerData.ped, 200)
		end
	end)
end)
Item('s24-6', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
            local maxHealth = 200
            SetEntityHealth(PlayerData.ped, 200)
		end
	end)
end)
Item('s24-9', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
            local maxHealth = 200
            SetEntityHealth(PlayerData.ped, 200)
		end
	end)
end)
Item('s24-12', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
            local maxHealth = 200
            SetEntityHealth(PlayerData.ped, 200)
		end
	end)
end)
Item('s39-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_MenuViewer:open','dragon_map2')
		end
	end)
end)
Item('s53-1', function(data, slot)
	if true then
		ox_inventory:useItem(data, function(data)
			if data then
 				TriggerEvent('esx_basicneeds:onEat')
                Wait(1000)
  				TriggerEvent('esx_crazy_lake:boom')
			end
		end)
	end
end)
Item('s120-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
                -- TriggerEvent('esx_eden_clotheshop:GPD')
                TriggerServerEvent('bp_character:wardrobeopen')
			end)
		end
	end)
end)
Item('s121-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				exports['okokNotify']:Alert("月亮塔羅牌", "洗牌中......", 5000, 'info')
			end)
		end
	end)
end)
Item('s122-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerServerEvent('CF_core:addRlevel', 'special', 1)
		end
	end)
end)
Item('s122-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerServerEvent('CF_core:addRlevel', 'ability', 1)
		end
	end)
end)
Item('s122-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerServerEvent('CF_core:addRlevel', 'passive', 1)
		end
	end)
end)
Item('s122-4', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerServerEvent('CF_core:addRvalue', 'effects')
		end
	end)
end)
Item('s122-7', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			local metadata = data.metadata
			TriggerServerEvent('CF_core:addlevel', 'passive', metadata.passivename, 1)
		end
	end)
end)
Item('s124-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx_religion_initial:teleport_menuuu')
		end
	end)
end)
Item('s125-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','d_card2')
			end)
		end
	end)
end)
Item('s125-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','d_card1')
			end)
		end
	end)
end)
Item('s127-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				xSound:PlayUrl('g1_0604_tape', './sounds/sox_dog.mp3', 0.55, false)
				-- xSound:PlayUrl('d_cheez', 'https://api.whalepic.me/sox_dog.mp3', 1.0, false)
			end)
		end
	end)
end)
Item('s129-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','doll_family')
			end)
		end
	end)
end)
Item('s130-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','bon_deer')
			end)
		end
	end)
end)
Item('s131-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_core:startItemEffect','fire2_hand')
		end
	end)
end)
Item('s131-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_core:startItemEffect','fire2_hand')
		end
	end)
end)
Item('s132-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_MenuViewer:open','longpong_birth')
			xSound:PlayUrl('kai_foodb', './sounds/longpong_birth.mp3', 0.4, false)
		end
	end)
end)
Item('s137-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_MenuViewer:open','baby_meow_pro')
			xSound:PlayUrl('baby_meow_pro', './sounds/baby_meow_pro.ogg', 0.6, false)
		end
	end)
end)
Item('s138-2', function(data, slot)
	local maxHealth = 200
	local health = GetEntityHealth(PlayerData.ped)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('esx:showNotification', '感覺到身體機能正在恢復。')
				SetEntityHealth(PlayerData.ped, maxHealth)
				ExecuteCommand('selfheal')
				Wait(30*60*1000)
				TriggerEvent('esx:showNotification', '感覺身體機能正在下降。')
				SetEntityHealth(PlayerData.ped, math.max(health, 100))
			end)
		end
	end)
end)
Item('s138-5', function(data, slot)
	local maxHealth = 200
	local health = GetEntityHealth(PlayerData.ped)
	ox_inventory:useItem(data, function(data)
		if data then
			SetEntityHealth(PlayerData.ped, math.min(maxHealth, math.floor(health + maxHealth / 10)))
		end
	end)
end)
Item('s139-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','bon_1st_school_hunk')
			end)
		end
	end)
end)
Item('s147-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','news0307')
			end)
		end
	end)
end)
Item('s147-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_MenuViewer:open','0302news')
		end
	end)
end)
Item('s147-4', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_MenuViewer:open','0205news')
		end
	end)
end)
Item('s148-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				xSound:PlayUrl('ruru_dollhappy', './sounds/ruru_dollhappy.mp3', 0.75, false)
			end)
		end
	end)
end)
Item('s148-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				xSound:PlayUrl('ruru_doll04', './sounds/ruru_doll04.mp3', 0.75, false)
			end)
		end
	end)
end)
Item('s148-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				xSound:PlayUrl('ruru_doll5', './sounds/ruru_doll5.mp3', 0.75, false)
			end)
		end
	end)
end)
Item('s148-4', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				xSound:PlayUrl('ruru_dollyen', './sounds/ruru_dollyen.mp3', 0.55, false)
			end)
		end
	end)
end)
Item('s148-5', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				xSound:PlayUrl('ruru_dolldeer', './sounds/ruru_dolldeer.mp3', 0.75, false)
			end)
		end
	end)
end)
Item('s148-6', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				xSound:PlayUrl('ruru_dolldream', './sounds/ruru_dolldream.mp3', 0.55, false)
			end)
		end
	end)
end)
Item('s148-7', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				xSound:PlayUrl('ruru_dollrin', './sounds/ruru_dollrin.mp3', 0.55, false)
			end)
		end
	end)
end)
Item('s148-8', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				xSound:PlayUrl('ruru_dollni', './sounds/ruru_dollni.mp3', 0.55, false)
			end)
		end
	end)
end)
Item('s148-9', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				xSound:PlayUrl('ruru_dollshiny', './sounds/ruru_dollshiny.mp3', 0.55, false)
			end)
		end
	end)
end)
Item('s151-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','hagua_invite')
			end)
		end
	end)
end)
Item('s156-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_MenuViewer:open','baby_meow')
			xSound:PlayUrl('kai_foodb', './sounds/baby_meow.ogg', 0.5, false)
		end
	end)
end)
Item('s157-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_MenuViewer:open','pon_uotbook_')
		end
	end)
end)
Item('s158-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('esx:showNotification', '因為鑽石的反射，眼前感受到一片明亮')
				Wait(2000)
				TriggerEvent('wf_menuViewer:FullOpenPic','maru_mancoffee.jpg',10)
				Wait(10000)
				TriggerEvent('wf_menuViewer:picFadeout', 2*1000)
			end)
		end
	end)
end)
Item('s159-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','blue_x2')
			end)
		end
	end)
end)
Item('s159-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','blue_x1')
			end)
		end
	end)
end)
Item('s160-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','d_eldia')
			end)
		end
	end)
end)
Item('s161-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e teddy')
		end
	end)
end)
Item('s162-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','liz_lucky')
			end)
		end
	end)
end)
Item('s162-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','liz_flower')
			end)
		end
	end)
end)
Item('s165-2', function(data, slot)
		local maxHealth = 200
		local health = GetEntityHealth(PlayerData.ped)
		ox_inventory:useItem(data, function(data)
			if data then
				SetEntityHealth(PlayerData.ped, math.min(maxHealth, math.floor(health + maxHealth / 10)))
			end
		end)
end)
Item('s166-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			--TriggerEvent('CF_General:change_ludy_neck')
            print('123')
		end
	end)
end)
Item('s167-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx_religion_initial:yueyue_123')
		end
	end)
end)
Item('s169-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e teddy')
		end
	end)
end)
Item('s172-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerServerEvent('CF_core:startmusic')
		end
	end)
end)
Item('s173-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e teddy')
		end
	end)
end)
Item('s176-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_core:toggle:invisible', true)
				Citizen.Wait(10*60*1000)
				TriggerEvent('CF_core:toggle:invisible', false)
				ExecuteCommand('CF_core:startbring')
			end)
		end
	end)
end)
Item('s179-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_core:startItemEffect','lightning_hand')
		end
	end)
end)
Item('s181-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('hair')
		end
	end)
end)
Item('s182-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx:showNotification', '戴上了靈魂的眼鏡。')
            ExecuteCommand('CF_core:startGlass')
		end
	end)
end)
Item('s184-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			local number = math.random(1,78) 
    		ExecuteCommand('me ' .. '抽出第^3'.. number ..'^7張')
		end
	end)
end)
Item('s187-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx_religion_initial:yueyue_111')
		end
	end)
end)
Item('s190-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_MenuViewer:open','ga_seqw12')
		end
	end)
end)
Item('s210-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
            TriggerEvent('esx_status:getStatus', 'hunger', function(h)
          		TriggerEvent('esx_status:remove', 'hunger', h.val/3.0)
            end)
			ESX.ShowNotification('散發香氣的香包，願攜帶的人能受到精靈的祝福。')
			TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_GARDENER_PLANT", 0, true)
			Wait(10*1000)
			ClearPedTasks(PlayerPedId())
			TriggerServerEvent('CenturionFarmerJob:removeItem',"smile_bao",1)
         
            ESX.TriggerServerCallback('stadus_skills:getSkills', function(data,data1)
            	TriggerServerEvent('stadus_skills:setStrength', GetPlayerServerId(PlayerId(-1)), 99.9)
            	TriggerServerEvent('stadus_skills:setStamina', GetPlayerServerId(PlayerId(-1)), 99.9)
            	SetRunSprintMultiplierForPlayer(PlayerId(-1),1.34)
                Citizen.Wait(60*1000)
                TriggerServerEvent('stadus_skills:setStrength', GetPlayerServerId(PlayerId(-1)), data1/1.2)
                TriggerServerEvent('stadus_skills:setStamina', GetPlayerServerId(PlayerId(-1)), data/1.2)
            	SetRunSprintMultiplierForPlayer(PlayerId(-1),1.00)
                Citizen.Wait(10*1000)
            	TriggerServerEvent("stadus_skills:updatePlayerInfo", GetPlayerServerId(PlayerId(-1)))
            end, GetPlayerServerId(PlayerId(-1)))
		end
	end)
end)
Item('s210-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
            TriggerEvent('esx_status:getStatus', 'hunger', function(h)
          		TriggerEvent('esx_status:remove', 'hunger', h.val/3.0)
            end)
			ESX.ShowNotification('感覺受到精靈的祝福，精神都變好了。')
			TriggerServerEvent('CenturionFarmerJob:removeItem',"a36_bug1",1)
         
            ESX.TriggerServerCallback('stadus_skills:getSkills', function(data,data1)
            	TriggerServerEvent('stadus_skills:setStrength', GetPlayerServerId(PlayerId(-1)), 99.9)
            	TriggerServerEvent('stadus_skills:setStamina', GetPlayerServerId(PlayerId(-1)), 99.9)
            	SetRunSprintMultiplierForPlayer(PlayerId(-1),1.34)
                Citizen.Wait(60*1000)
                TriggerServerEvent('stadus_skills:setStrength', GetPlayerServerId(PlayerId(-1)), data1/1.2)
                TriggerServerEvent('stadus_skills:setStamina', GetPlayerServerId(PlayerId(-1)), data/1.2)
            	SetRunSprintMultiplierForPlayer(PlayerId(-1),1.00)
                Citizen.Wait(10*1000)
            	TriggerServerEvent("stadus_skills:updatePlayerInfo", GetPlayerServerId(PlayerId(-1)))
            end, GetPlayerServerId(PlayerId(-1)))
		end
	end)
end)
Item('s250-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('GOLFF')
		end
	end)
end)
Item('s250-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('GOLFF')
		end
	end)
end)
Item('s250-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('GOLFF')
		end
	end)
end)
Item('s250-4', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('GOLFF')
		end
	end)
end)
Item('s258-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx_religion_initial:heal3',0.3)
		end
	end)
end)
Item('s258-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:huimei1')
		end
	end)
end)
Item('s258-4', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:huimei2')
		end
	end)
end)
Item('s258-5', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:huimei3')
		end
	end)
end)
Item('s258-6', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:huimei4')
		end
	end)
end)
Item('s258-7', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:huimei5')
		end
	end)
end)
Item('s258-8', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:huimei6')
		end
	end)
end)
Item('s258-9', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:huimei7')
		end
	end)
end)
Item('s258-10', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:huimei8')
		end
	end)
end)
Item('s258-11', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:huimei9')
		end
	end)
end)
Item('s259-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_0604_pic1')
			end)
		end
	end)
end)
Item('s259-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_0604_pic2')
			end)
		end
	end)
end)
local g1_1864_mask = {
	id = 0,
	color = 0,
	flag = false
}
Item('s260-7', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			if not g1_1864_mask.flag then
				g1_1864_mask.id = GetPedDrawableVariation(cache.ped, 1)
				g1_1864_mask.color = GetPedTextureVariation(cache.ped, 1)
				SetPedComponentVariation(cache.ped, 1, 270, 3, 0)
			else
				SetPedComponentVariation(cache.ped, 1, g1_1864_mask.id, g1_1864_mask.color, 0)
			end
			ToggleEmote("mp_masks@standard_car@ds@","put_on_mask", 51,800)
			g1_1864_mask.flag = not g1_1864_mask.flag
		end
	end)
end)
Item('s262-1', function(data, slot)
	local ItemAuthorized = checkItemsv({'g1_0604_radio'}and{'g1_0604_better'})
	if ItemAuthorized  ~= nil then
		xSound:PlayUrl('g1_0604_tape', './sounds/g1_0604_tape2.ogg', 0.79, false)
		if math.random(1,100) > 80 then 
			TriggerServerEvent('CF_General:removeItem','g1_0604_better',1) 
			TriggerServerEvent('CF_General:giveItem','g1_0604_better2',1) 
		end
	end
end)
Item('s262-2', function(data, slot)
	local ItemAuthorized = checkItemsv({'g1_0604_radio'}and{'g1_0604_better'})
	if ItemAuthorized  ~= nil then
		xSound:PlayUrl('g1_0604_tape', './sounds/g1_0604_tape.ogg', 0.99, false)
		if math.random(1,100) > 80 then 
			TriggerServerEvent('CF_General:removeItem','g1_0604_better',1) 
			TriggerServerEvent('CF_General:giveItem','g1_0604_better2',1) 
		end
	end
end)
Item('s263-5', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_0825_utian')
			end)
		end
	end)
end)
Item('s263-9', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_3240_utian')
			end)
		end
	end)
end)
Item('s265-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_eden_12140112')
			end)
		end
	end)
end)
Item('s265-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_eden_12130403')
			end)
		end
	end)
end)
Item('s265-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_eden_12131116')
			end)
		end
	end)
end)
Item('s265-4', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_eden_12140505')
			end)
		end
	end)
end)
Item('s265-5', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_eden_12141007')
			end)
		end
	end)
end)
Item('s265-6', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_eden_12141112')
			end)
		end
	end)
end)
Item('s265-7', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_eden_12141210')
			end)
		end
	end)
end)
Item('s265-8', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_eden_d1')
			end)
		end
	end)
end)
Item('s265-9', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_eden_d2')
			end)
		end
	end)
end)
Item('s265-10', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_eden_d3')
			end)
		end
	end)
end)
Item('s265-11', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_eden_d4')
			end)
		end
	end)
end)
Item('s265-12', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_eden_d5')
			end)
		end
	end)
end)
Item('s265-13', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_eden_d6')
			end)
		end
	end)
end)
Item('s265-14', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_eden_d7')
			end)
		end
	end)
end)
Item('s265-15', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_eden_d8')
			end)
		end
	end)
end)
Item('s268-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport1')
		end
	end)
end)
Item('s268-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport2')
		end
	end)
end)
Item('s268-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport3')
		end
	end)
end)
Item('s268-4', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport4')
		end
	end)
end)
Item('s268-5', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport5 ')
		end
	end)
end)
Item('s268-6', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport6')
		end
	end)
end)
Item('s268-7', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport7')
		end
	end)
end)
Item('s268-8', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport8')
		end
	end)
end)
Item('s268-9', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport9')
		end
	end)
end)
Item('s268-10', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport10')
		end
	end)
end)
Item('s268-11', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport11')
		end
	end)
end)
Item('s268-12', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport12')
		end
	end)
end)
Item('s268-13', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport13')
		end
	end)
end)
Item('s268-14', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport14')
		end
	end)
end)
Item('s268-15', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport15')
		end
	end)
end)
Item('s268-16', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport16')
		end
	end)
end)
Item('s268-17', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport17')
		end
	end)
end)
Item('s268-18', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport18')
		end
	end)
end)
Item('s268-19', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport19')
		end
	end)
end)
Item('s268-20', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport20')
		end
	end)
end)
Item('s268-21', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport21')
		end
	end)
end)
Item('s268-22', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport22')
		end
	end)
end)
Item('s268-23', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport23')
		end
	end)
end)
Item('s268-24', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport24')
		end
	end)
end)
Item('s268-25', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport25')
		end
	end)
end)
Item('s268-26', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport26')
		end
	end)
end)
Item('s268-27', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport27')
		end
	end)
end)
Item('s268-28', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport28')
		end
	end)
end)
Item('s268-29', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport29')
		end
	end)
end)
Item('s268-30', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport30')
		end
	end)
end)
Item('s268-31', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport31')
		end
	end)
end)
Item('s268-32', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport32')
		end
	end)
end)
Item('s268-33', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport33')
		end
	end)
end)
Item('s268-34', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport34')
		end
	end)
end)
Item('s268-35', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport35')
		end
	end)
end)
Item('s268-36', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport36')
		end
	end)
end)
Item('s268-37', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport37')
		end
	end)
end)
Item('s268-38', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport38')
		end
	end)
end)
Item('s268-39', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport39')
		end
	end)
end)
Item('s268-40', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport40')
		end
	end)
end)
Item('s268-41', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport41')
		end
	end)
end)
Item('s268-42', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport42')
		end
	end)
end)
Item('s268-43', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport43')
		end
	end)
end)
Item('s268-44', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport44')
		end
	end)
end)
Item('s268-45', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport45')
		end
	end)
end)
Item('s268-46', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport46')
		end
	end)
end)
Item('s268-47', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport47')
		end
	end)
end)
Item('s268-48', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport48')
		end
	end)
end)
Item('s268-49', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport49')
		end
	end)
end)
Item('s268-50', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport50')
		end
	end)
end)
Item('s268-51', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport51')
		end
	end)
end)
Item('s268-52', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport52')
		end
	end)
end)
Item('s268-53', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport53')
		end
	end)
end)
Item('s268-54', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport54')
		end
	end)
end)
Item('s268-55', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport55')
		end
	end)
end)
Item('s268-56', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport56')
		end
	end)
end)
Item('s268-57', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport57')
		end
	end)
end)
Item('s268-58', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport58')
		end
	end)
end)
Item('s268-59', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:teleport59')
		end
	end)
end)
Item('s270-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','gua_fate_1')
				TriggerEvent('CF_General:FZS1_Cookie') 
			end)
		end
	end)
end)
Item('s270-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','gua_fate_2')
				TriggerEvent('CF_General:FZS1_Cookie') 
			end)
		end
	end)
end)
Item('s270-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','gua_fate_3')
				TriggerEvent('CF_General:FZS1_Cookie') 
			end)
		end
	end)
end)
Item('s270-4', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','gua_fate_4')
				TriggerEvent('CF_General:FZS1_Cookie') 
			end)
		end
	end)
end)
Item('s270-5', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','gua_fate_5')
				TriggerEvent('CF_General:FZS1_Cookie') 
			end)
		end
	end)
end)
Item('s270-6', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','gua_fate_6')
				TriggerEvent('CF_General:FZS1_Cookie') 
			end)
		end
	end)
end)
Item('s270-7', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','gua_fate_7')
				TriggerEvent('CF_General:FZS1_Cookie') 
			end)
		end
	end)
end)
Item('s270-8', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','gua_fate_8')
				TriggerEvent('CF_General:FZS1_Cookie') 
			end)
		end
	end)
end)
Item('s270-9', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','gua_fate_9')
				TriggerEvent('CF_General:FZS1_Cookie') 
			end)
		end
	end)
end)
Item('s270-10', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','gua_fate_10')
				TriggerEvent('CF_General:FZS1_Cookie') 
			end)
		end
	end)
end)
Item('s270-11', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('gua_fate_11', 'gua_fate_11', 0.55, false)
			TriggerEvent('CF_MenuViewer:open','gua_fate_11')
			TriggerEvent('CF_General:FZS1_Cookie') 
		end
	end)
end)
Item('s270-12', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','gua_fate_12')
				TriggerEvent('CF_General:FZS1_Cookie') 
			end)
		end
	end)
end)
Item('s270-13', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('gua_fate_13', 'gua_fate_13', 0.55, false)
			TriggerEvent('CF_MenuViewer:open','gua_fate_13')
			TriggerEvent('CF_General:FZS1_Cookie') 
		end
	end)
end)
Item('s270-14', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('gua_fate_14', 'gua_fate_14', 0.55, false)
			TriggerEvent('CF_MenuViewer:open','gua_fate_14')
			TriggerEvent('CF_General:FZS1_Cookie') 
		end
	end)
end)
Item('s270-15', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','gua_fate_15')
				TriggerEvent('CF_General:FZS1_Cookie') 
			end)
		end
	end)
end)
Item('s270-16', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('gua_fate_16', 'gua_fate_16', 0.55, false)
			TriggerEvent('CF_MenuViewer:open','gua_fate_16')
			TriggerEvent('CF_General:FZS1_Cookie') 
		end
	end)
end)
Item('s270-17', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','gua_fate_17')
				TriggerEvent('CF_General:FZS1_Cookie') 
			end)
		end
	end)
end)
Item('s270-18', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','gua_fate_18')
				TriggerEvent('CF_General:FZS1_Cookie') 
			end)
		end
	end)
end)
Item('s270-19', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','gua_fate_19')
				TriggerEvent('CF_General:FZS1_Cookie') 
			end)
		end
	end)
end)
Item('s271-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','b1_end')
			end)
		end
	end)
end)
Item('s271-4', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','b3_end')
			end)
		end
	end)
end)
Item('s272-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_19')
			end)
		end
	end)
end)
Item('s272-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_19boom')
			end)
		end
	end)
end)
Item('s272-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_19cn')
			end)
		end
	end)
end)
Item('s272-4', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_19train')
			end)
		end
	end)
end)
Item('s272-5', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_19us')
			end)
		end
	end)
end)
Item('s272-6', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_19zem')
			end)
		end
	end)
end)
Item('s273-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_aurora')
			end)
		end
	end)
end)
Item('s275-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			SetEntityHealth(PlayerData.ped, 200.0)
		end
	end)
end)
Item('s287-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('g1_1788_toy', './sounds/g1_1788_toy.mp3', 0.55, false)
		end
	end)
end)
Item('s288-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_8184_photo')
			end)
		end
	end)
end)
Item('s290-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_5938_letter')
			end)
		end
	end)
end)
Item('s290-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_2529_leaflet')
			end)
		end
	end)
end)
Item('s290-5', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('me 雙手緊握邪靈教吊飾')
			ExecuteCommand('e namaste')
			end
	end)
end)
Item('s290-6', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('me 潑灑聖水')
			ExecuteCommand('e champagnespray')
        	ExecuteCommand('clearbear')     
		end
	end)
end)
local g1_3468_ring = {
	id = 0,
	color = 0,
	flag = false}
Item('s298-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			if not g1_3468_ring.flag then
				g1_3468_ring.id = GetPedDrawableVariation(cache.ped, 2)
				g1_3468_ring.color = GetPedTextureVariation(cache.ped, 2)
				SetPedComponentVariation(cache.ped, 2, 154, 0, 0)
			else
				SetPedComponentVariation(cache.ped, 2, g1_3468_ring.id, g1_3468_ring.color, 0)
			end
			ToggleEmote("clothingtie","check_out_a", 51,2000)
			g1_3468_ring.flag = not g1_3468_ring.flag
		end
	end)
end)
Item('s302-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e book')
			ExecuteCommand('pe_cat2 0.3')
			end
	end)
end)
Item('s302-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('pe_cat2 0.3')
			end
	end)
end)
Item('s302-4', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('pe_cat2 0.2')
			end
	end)
end)
Item('s302-5', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('g1_5637_doll', './sounds/g1_5637_doll.ogg', 0.55, false)
		end
	end)
end)
Item('s304-2', function(data, slot)
    ox_inventory:useItem(data, function(data)
        if data then
            TriggerEvent('CF_General:g1_1788_can1')
        end
    end)
end)
Item('s304-4', function(data, slot)
    ox_inventory:useItem(data, function(data)
        if data then
            TriggerEvent('CF_General:g1_5845_can1')
        end
    end)
end)
Item('s305-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_0604_letter1')
			end)
		end
	end)
end)
Item('s305-4', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_0604_letter2')
			end)
		end
	end)
end)
Item('s305-5', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_0604_letter3')
			end)
		end
	end)
end)
Item('s308-3', function(data, slot)
    ox_inventory:useItem(data, function(data)
        if data then
            xSound:PlayUrl('g1_5637_octopus', './sounds/g1_5637_octopus.ogg', 0.55, false)
        end
    end)
end)
Item('s314-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
        	TriggerServerEvent('esx_religion_initial:setJob', 'infected', 0)
		end
	end)
end)
Item('s314-4', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_eden_3')
			end)
		end
	end)
end)
Item('s314-5', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_eden_4')
			end)
		end
	end)
end)
Item('s314-6', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_eden_5')
			end)
		end
	end)
end)
Item('s314-7', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_eden_6')
			end)
		end
	end)
end)
Item('s320-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_3240_friendly')
			end)
		end
	end)
end)
Item('s321-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_3240_uda')
			end)
		end
	end)
end)
Item('s321-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_3240_sawcleanner')
			end)
		end
	end)
end)
Item('s321-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:g1_3240_saw1')
		end
	end)
end)
Item('s321-5', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('g1_3240_saw3', './sounds/g1_3240_saw3.ogg', 0.65, false)
			TriggerServerEvent('CF_General:giveItem','water',2) 
			TriggerServerEvent('CF_General:giveItem','g1_3240_saw1',1) 
			TriggerServerEvent('CF_General:giveItem','g1_3240_sawcleanner',1)
			if math.random(1,100) > 80 then				
				TriggerServerEvent('CF_General:removeItem','g1_3240_sawcleanner',1)
			end 
		end
	end)
end)
Item('s328-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('g1_5637_2222', './sounds/g1_5637_2222.mp3', 0.45, false)
		end
	end)
end)
Item('s329-1', function(data, slot)

    local ItemAuthorized = checkItemsv({'water','rain_water','g1_dirty_water'})
	local relicAuthorized = multicheckItems({'g1_2529_charm','g1_2529_hammer'})
    if ItemAuthorized and relicAuthorized then
        ox_inventory:useItem(data, function(data)
            if data then
                if lib.progressBar({
                    duration = math.random(3 * 1000,5*1000),
                    label = '符咒淨化',useWhileDead = false,canCancel = true,disable = {car = true,},anim = {scenario = "PROP_HUMAN_BUM_BIN",},
                }) then 
                    lib.notify({title = '符咒淨化',description = '操作成功',type = 'success'})
                    TriggerServerEvent('CF_General:giveItem','g1_5637_4444',1)
                    TriggerServerEvent('CF_General:removeItem',ItemAuthorized,1)
                    TriggerServerEvent('wf_logs:addone', 'collection_water_relic_pure_sucess'..ItemAuthorized)
                else 
                    lib.notify({title = '符咒淨化',description = '操作取消',type = 'error'})
                    TriggerServerEvent('wf_logs:addone', 'collection_water_relic_pure_fail'..ItemAuthorized)
                end
            end
        end)
    elseif relicAuthorized == false and ItemAuthorized then
		lib.notify({title = '符咒淨化',description = '離奇湮滅',type = 'error'})
		ExecuteCommand('me 符咒突然碎裂')
        TriggerServerEvent('wf_logs:addone', 'collection_water_relic_pure_fail2')
        TriggerServerEvent('CF_General:removeItem','g1_5637_3333',1)
		ExecuteCommand('WEc:SNPFX_NEW core ent_dst_inflatable 0.0 0.0 0.02 0 0 0 0')
    end
end)
Item('s334-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e umbrella')
		end
	end)
end)
Item('s335-5', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
            if math.random(1,100) >=50 then
				exports['okokNotify']:Alert("疫苗", "注射完成", 5000, 'info')
            	TriggerEvent('CF_General:RecoverZem')
            else
				exports['okokNotify']:Alert("疫苗", "注射完成(沒有生效)", 5000, 'info')
            end
		end
	end)
end)
Item('s335-6', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
            if math.random(1,100) >=30 then
				exports['okokNotify']:Alert("疫苗", "注射完成", 5000, 'info')
            	TriggerEvent('CF_General:RecoverZem')
            else
				exports['okokNotify']:Alert("疫苗", "注射完成(沒有生效)", 5000, 'info')
            end
		end
	end)
end)
Item('s335-7', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			exports['okokNotify']:Alert("疫苗", "注射完成", 5000, 'info')
            TriggerEvent('CF_General:RecoverZem')
		end
	end)
end)
Item('s336-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_0001_label')
			end)
		end
	end)
end)
Item('s338-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_2529_pic')
			end)
		end
	end)
end)
Item('s339-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','g1_6268_card')
			end)
		end
	end)
end)
Item('s341-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('r4_3870_shrimp', './sounds/r4_3870_shrimp.ogg', 0.15, false)
			TriggerEvent('CF_MenuViewer:open','r4_3870_shrimp')
		end
	end)
end)
Item('s342-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('headmaster_pirate', './sounds/headmaster_pirate.mp3', 0.5, false)
		end
	end)
end)
Item('s344-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('sugar_dragon', './sounds/sugar_dragon.ogg', 0.75, false)
			TriggerEvent('CF_MenuViewer:open','sugar_dragon')
		end
	end)
end)
Item('s346-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','daan_pic')
			end)
		end
	end)
end)
local arbe_weapon = false
Item('s347-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
    			if arbe_weapon then
                	arbe_weapon = false  
                    TriggerEvent('ox_inventory:clearWeapons')
                else
                    arbe_weapon = true
                    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey('WEAPON_KNIFE'), 1000, 0, false)
                    SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey('WEAPON_KNIFE'), true)
                    SetPedCurrentWeaponVisible(GetPlayerPed(-1), true, false, false, false)
                end
			end)
		end
	end)
end)
Item('s347-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','arbe_military')
			end)
		end
	end)
end)
Item('s352-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				xSound:PlayUrl('gua_spidery', './sounds/gua_spidery.ogg', 0.65, false)
			end)
		end
	end)
end)
Item('s352-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				xSound:PlayUrl('gua_spiderb', './sounds/gua_spiderb.ogg', 0.65, false)
			end)
		end
	end)
end)
Item('s353-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','uzay_87')
			end)
		end
	end)
end)
Item('s353-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','uzay_guard')
			end)
		end
	end)
end)
Item('s353-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','uzay_hunter')
			end)
		end
	end)
end)
Item('s353-4', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','uzay_predictor')
			end)
		end
	end)
end)
Item('s353-5', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','uzay_process')
			end)
		end
	end)
end)
Item('s353-6', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','uzay_villagers')
			end)
		end
	end)
end)
Item('s353-7', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','uzay_wizard')
			end)
		end
	end)
end)
Item('s353-8', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','uzay_wolf')
			end)
		end
	end)
end)
Item('s353-9', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','uzay_rules')
			end)
		end
	end)
end)
Item('s355-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','schooldays_owo')
			end)
		end
	end)
end)
Item('s355-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','schooldays_p1p2')
			end)
		end
	end)
end)
Item('s355-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','schooldays_p3p4')
			end)
		end
	end)
end)
Item('s358-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','liz_fcardb')
			end)
		end
	end)
end)
Item('s361-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('me 按下遙控器按鈕')
			Citizen.CreateThread(function()
				TriggerServerEvent('CF_core:startSocksU')
			end)
		end
	end)
end)
Item('s363-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','schooldays2_p1p2')
			end)
		end
	end)
end)
Item('s363-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','schooldays2_powo')
			end)
		end
	end)
end)
Item('s364-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_core:startInputText')
			end)
		end
	end)
end)
Item('s364-4', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('bear_sunbear', './sounds/bear_sunbear.mp3', 0.35, false)
		end
	end)
end)
Item('s365-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('me 抱住康柏抱枕')
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','bon_sleep')
			end)
		end
	end)
end)
Item('s366-4', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			exports['okokNotify']:Alert("演繹提示", "一般人吃了不會有任何效果和副作用，但若是受到心理暗示或精神打擊而精神錯亂者，服用後會進入沉睡，並沉睡10-15分鐘，甦醒後會恢復正常，且遺忘精神暗示內容(精神異常期間記憶將保存)。 沉睡指令：/selfkill", 100000, 'warning')
		end
	end)
end)
Item('s366-6', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('me 用力戳娃娃')
		end
	end)
end)
Item('s367-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('me 抱住管理者抱枕')
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','bon_guan')
			end)
		end
	end)
end)
Item('s368-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e celebrate')
			ExecuteCommand('CF_core:startbring')
			end
	end)
end)
Item('s369-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('gua_konfu', './sounds/gua_konfu.ogg', 0.35, false)
			Wait(5*1000)
			ExecuteCommand('e karate')
			end
	end)
end)
Item('s371-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_MenuViewer:open','moka_poker')
			end)
		end
	end)
end)
Item('s391-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('kai_foodb', './sounds/kai_foodb.mp3', 0.5, false)
		end
	end)
end)
Item('s391-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('kai_fooda', './sounds/kai_fooda.mp3', 0.5, false)
		end
	end)
end)
Item('s391-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('kai_food', './sounds/kai_food.mp3', 0.25, false)
			TriggerEvent('esx:showNotification', '雖然很飽，但是口乾舌燥，腦中出現了特殊的旋律。')
		end
	end)
end)


----------------------------------------------------------------
-- 武器W(Weapon) Item
----------------------------------------------------------------

----------------------------------------------------------------
-- 未分類U(Unsort) Item
----------------------------------------------------------------

Item('golfbagx', function(data, slot)
	if true then
		ox_inventory:useItem(data, function(data)
			if data then
				ExecuteCommand('GOLF')
			end
		end)
	end
end)

Item('bandage', function(data, slot)
	local maxHealth = GetEntityMaxHealth(cache.ped)
	local health = GetEntityHealth(cache.ped)
	ox_inventory:useItem(data, function(data)
		if data then
			SetEntityHealth(cache.ped, math.min(maxHealth, math.floor(health + maxHealth / 16)))
			lib.notify({ description = 'You feel better already' })
		end
	end)
end)
Item('armour', function(data, slot)
	if GetPedArmour(cache.ped) < 100 then
		ox_inventory:useItem(data, function(data)
			if data then
				SetPlayerMaxArmour(PlayerData.id, 100)
				SetPedArmour(cache.ped, 100)
			end
		end)
	end
end)
client.parachute = false
Item('parachute', function(data, slot)
	if not client.parachute then
		ox_inventory:useItem(data, function(data)
			if data then
				local chute = `GADGET_PARACHUTE`
				SetPlayerParachuteTintIndex(PlayerData.id, -1)
				GiveWeaponToPed(cache.ped, chute, 0, true, false)
				SetPedGadget(cache.ped, chute, true)
				lib.requestModel(1269906701)
				client.parachute = {CreateParachuteBagObject(cache.ped, true, true), slot?.metadata?.type or -1}
				if slot.metadata.type then
					SetPlayerParachuteTintIndex(PlayerData.id, slot.metadata.type)
				end
			end
		end)
	end
end)
Item('clothing', function(data, slot)
	local metadata = slot.metadata

	if not metadata.drawable then return print('Clothing is missing drawable in metadata') end
	if not metadata.texture then return print('Clothing is missing texture in metadata') end

	if metadata.prop then
		if not SetPedPreloadPropData(cache.ped, metadata.prop, metadata.drawable, metadata.texture) then
			return print('Clothing has invalid prop for this ped')
		end
	elseif metadata.component then
		if not IsPedComponentVariationValid(cache.ped, metadata.component, metadata.drawable, metadata.texture) then
			return print('Clothing has invalid component for this ped')
		end
	else
		return print('Clothing is missing prop/component id in metadata')
	end

	ox_inventory:useItem(data, function(data)
		if data then
			metadata = data.metadata

			if metadata.prop then
				local prop = GetPedPropIndex(cache.ped, metadata.prop)
				local texture = GetPedPropTextureIndex(cache.ped, metadata.prop)

				if metadata.drawable == prop and metadata.texture == texture then
					return ClearPedProp(cache.ped, metadata.prop)
				end

				-- { prop = 0, drawable = 2, texture = 1 } = grey beanie
				SetPedPropIndex(cache.ped, metadata.prop, metadata.drawable, metadata.texture, false);
			elseif metadata.component then
				local drawable = GetPedDrawableVariation(cache.ped, metadata.component)
				local texture = GetPedTextureVariation(cache.ped, metadata.component)

				if metadata.drawable == drawable and metadata.texture == texture then
					return -- item matches (setup defaults so we can strip?)
				end

				-- { component = 4, drawable = 4, texture = 1 } = jeans w/ belt
				SetPedComponentVariation(cache.ped, metadata.component, metadata.drawable, metadata.texture, 0);
			end
		end
	end)
end)
Item('plongee2', function(data, slot)
	if true then
		ox_inventory:useItem(data, function(data)
			if data then
        		TriggerEvent('esx_tenues:settenueplongee2')  
			end
		end)
	end
end)
Item('gua_blood', function(data, slot)
	local maxHealth = 200
	local health = GetEntityHealth(PlayerData.ped)
	ox_inventory:useItem(data, function(data)
		if data then
			SetEntityHealth(PlayerData.ped, math.min(maxHealth, math.floor(health - maxHealth / 6)))
		end
	end)
end)
Item('green_melon', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('Green_Melon', './sounds/Green_Melon.mp3', 0.2, false)
		end
	end)
end)
Item('red_melon', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('Red_Melon', './sounds/Red_Melon.mp3', 0.2, false)
		end
	end)
end)
Item('yellow_melon', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('Yellow_Melon', './sounds/Yellow_Melon.mp3', 0.2, false)
		end
	end)
end)
Item('bon_book3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_MenuViewer:open','bon_book33')
		end
	end)
end)
Item('news0210', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_MenuViewer:open','0210news')
		end
	end)
end)
Item('hao_pic', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_MenuViewer:open','hao_pic')
		end
	end)
end)


----------------------------------------------------------------
-- Ending 整理分隔線
----------------------------------------------------------------


-----------------------------------------------------------------------------------------------

exports('Items', function(item) return getItem(nil, item) end)
exports('ItemList', function(item) return getItem(nil, item) end)

return Items
