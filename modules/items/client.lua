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
local function SetWeapon(pedid,weapon_name)
	GiveWeaponToPed(pedid, GetHashKey(weapon_name), 1000, 0, false)
    SetCurrentPedWeapon(pedid, GetHashKey(weapon_name), true)
    SetPedCurrentWeaponVisible(pedid, true, false, false, false)
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
Item('notepad', function(data, slot)
	ox_inventory:useItem(data, function(data)
		ExecuteCommand('wnotepad')
	end)
end)
Item('notepage', function(data, slot)
	ox_inventory:useItem(data, function(data)
		ExecuteCommand('notepadItem')
	end)
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
				client.parachute = CreateParachuteBagObject(cache.ped, true, true)
				if slot.metadata.type then
					SetPlayerParachuteTintIndex(PlayerData.id, slot.metadata.type)
				end
			end
		end)
	end
end)

Item('phone', function(data, slot)
	local success, result = pcall(function()
		return exports.npwd:isPhoneVisible()
	end)

	if success then
		exports.npwd:setPhoneVisible(not result)
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

Item('g1_1miao', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
            --TriggerServerEvent('esx_religion_initial:setJob', 'unemployed', 1) 
			exports['okokNotify']:Alert("疫苗", "注射完成", 5000, 'info')        
            TriggerEvent('CF_General:RecoverZem')
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


Item('c84-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
        	TriggerEvent('CF_General:stones')
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
Item('t146-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
        	ExecuteCommand('Nation_effect')
		end
	end)
end)

Item('bpclothing', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerServerEvent('CF_core:useCloth', data, slot)
		end
	end)
end)

Item('t1-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		TriggerEvent('fishing:fishstart')
	end)
end)

Item('t20-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		TriggerEvent('jumelles:Active')
	end)
end)
Item('t20-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		TriggerEvent('lob_z3:Active')
	end)
end)

Item('t22-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		ExecuteCommand('notes')
	end)
end)

Item('t179-1', function(data, slot)
	local metadata = slot.metadata
	ox_inventory:useItem(data, function(data)
		xSound:PlayUrl('bon_obituary', './sounds/bon_obituary.ogg', 0.80, false)
		if metadata.wolfimage then
			TriggerEvent('wf_menuViewer:open', metadata.wolfimage..'.png', 200)
		end
	end)
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

Item('m8-1', function(data, slot)
	if true then
		ox_inventory:useItem(data, function(data)
			if data then
        		ExecuteCommand('stopEffect me')
			end
		end)
	end
end)
Item('t24-1', function(data, slot)
	if true then
		ox_inventory:useItem(data, function(data)
			if data then
        		TriggerEvent('esx_tenues:settenueplongee1')  
			end
		end)
	end
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

Item('t13-1', function(data, slot)
	if true then
		ox_inventory:useItem(data, function(data)
			if data then
				TriggerEvent('esx_mechanicjob:onFixkit')
			end
		end)
	end
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

Item('gua_blood', function(data, slot)
	local maxHealth = 200
	local health = GetEntityHealth(PlayerData.ped)
	ox_inventory:useItem(data, function(data)
		if data then
			SetEntityHealth(PlayerData.ped, math.min(maxHealth, math.floor(health - maxHealth / 6)))
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
Item('f107-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('rain_happy', './sounds/rain_happy.ogg', 0.5, false)
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


Item('s314-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
        	TriggerServerEvent('esx_religion_initial:setJob', 'infected', 0)
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
Item('s165-2', function(data, slot)
		local maxHealth = 200
		local health = GetEntityHealth(PlayerData.ped)
		ox_inventory:useItem(data, function(data)
			if data then
				SetEntityHealth(PlayerData.ped, math.min(maxHealth, math.floor(health + maxHealth / 10)))
			end
		end)
end)
Item('armour', function(data, slot)
		ox_inventory:useItem(data, function(data)
			if data then
				SetPlayerMaxArmour(PlayerData.id, 100)
				SetPedArmour(PlayerData.ped, 100)
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

Item('s166-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			--TriggerEvent('CF_General:change_ludy_neck')
            print('123')
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

-- Item('s210-1', function(data, slot)
-- 	ox_inventory:useItem(data, function(data)
-- 		if data then
--             TriggerEvent('esx_status:getStatus', 'hunger', function(h)
--           		TriggerEvent('esx_status:remove', 'hunger', h.val/3.0)
--             end)
-- 			ESX.ShowNotification('散發香氣的香包，願攜帶的人能受到精靈的祝福。')
-- 			TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_GARDENER_PLANT", 0, true)
-- 			Wait(10*1000)
-- 			ClearPedTasks(PlayerPedId())
-- 			TriggerServerEvent('CenturionFarmerJob:removeItem',"smile_bao",1)
            
--             ESX.TriggerServerCallback('stadus_skills:getSkills', function(data,data1)
--             	TriggerServerEvent('stadus_skills:setStrength', GetPlayerServerId(PlayerId(-1)), 99.9)
--             	TriggerServerEvent('stadus_skills:setStamina', GetPlayerServerId(PlayerId(-1)), 99.9)
--             	SetRunSprintMultiplierForPlayer(PlayerId(-1),1.34)
--                 Citizen.Wait(60*1000)
--                 TriggerServerEvent('stadus_skills:setStrength', GetPlayerServerId(PlayerId(-1)), data1/1.2)
--                 TriggerServerEvent('stadus_skills:setStamina', GetPlayerServerId(PlayerId(-1)), data/1.2)
--             	SetRunSprintMultiplierForPlayer(PlayerId(-1),1.00)
--                 Citizen.Wait(10*1000)
--             	TriggerServerEvent("stadus_skills:updatePlayerInfo", GetPlayerServerId(PlayerId(-1)))
--             end, GetPlayerServerId(PlayerId(-1)))
-- 		end
-- 	end)
-- end)


-- Item('s210-2', function(data, slot)
-- 	ox_inventory:useItem(data, function(data)
-- 		if data then
--             TriggerEvent('esx_status:getStatus', 'hunger', function(h)
--           		TriggerEvent('esx_status:remove', 'hunger', h.val/3.0)
--             end)
-- 			ESX.ShowNotification('感覺受到精靈的祝福，精神都變好了。')
-- 			TriggerServerEvent('CenturionFarmerJob:removeItem',"a36_bug1",1)
            
--             ESX.TriggerServerCallback('stadus_skills:getSkills', function(data,data1)
--             	TriggerServerEvent('stadus_skills:setStrength', GetPlayerServerId(PlayerId(-1)), 99.9)
--             	TriggerServerEvent('stadus_skills:setStamina', GetPlayerServerId(PlayerId(-1)), 99.9)
--             	SetRunSprintMultiplierForPlayer(PlayerId(-1),1.34)
--                 Citizen.Wait(60*1000)
--                 TriggerServerEvent('stadus_skills:setStrength', GetPlayerServerId(PlayerId(-1)), data1/1.2)
--                 TriggerServerEvent('stadus_skills:setStamina', GetPlayerServerId(PlayerId(-1)), data/1.2)
--             	SetRunSprintMultiplierForPlayer(PlayerId(-1),1.00)
--                 Citizen.Wait(10*1000)
--             	TriggerServerEvent("stadus_skills:updatePlayerInfo", GetPlayerServerId(PlayerId(-1)))
--             end, GetPlayerServerId(PlayerId(-1)))
-- 		end
-- 	end)
-- end)

Item('t40-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('nitro:start')
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

Item('t26-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			-- ExecuteCommand('radio')
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


Item('s342-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('headmaster_pirate', './sounds/headmaster_pirate.mp3', 0.5, false)
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


Item('f247-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('ruru_rincookie', './sounds/ruru_rincookie.mp3', 0.5, false)
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
Item('c7-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				ExecuteCommand('helpme_giveitem bottle 1')
			end)
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


Item('f137-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				xSound:PlayUrl('d_cheez', './sounds/d_cheez.mp3', 0.75, false)
			end)
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

Item('green_melon', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('Green_Melon', './sounds/Green_Melon.mp3', 0.2, false)
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

Item('f303-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx:showNotification', '你覺得歆情特好,有種愛的衝動。')
			xSound:PlayUrl('hlin_taow', './sounds/hlin_taow.mp3', 0.2, false)
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

Item('f302-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx:showNotification', '你更愛棠棠了。')
			xSound:PlayUrl('hlin_taow', './sounds/hlin_taow.mp3', 0.2, false)
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

Item('t81-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
		    ClearPedBloodDamage(PlayerPedId())
		    ClearPedWetness(PlayerPedId())
		    ClearPedEnvDirt(PlayerPedId())
		    ResetPedVisibleDamage(PlayerPedId())
		end
	end)
end)

Item('t81-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx:showNotification', '毛巾溫溫熱熱的很舒服。')
		    ClearPedBloodDamage(PlayerPedId())
		    ClearPedWetness(PlayerPedId())
		    ClearPedEnvDirt(PlayerPedId())
		    ResetPedVisibleDamage(PlayerPedId())
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

Item('f437-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx:showNotification', '緩解痠痛，通體舒暢!')
			TriggerEvent('CF_core:qqcandy')
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

Item('f431-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx:showNotification', '幸運餅乾給你勇氣')
			TriggerServerEvent('CF_core:gua_fortunecookiea')
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

Item('f450-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx:showNotification', '吃了琥珀糖')
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

Item('f243-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','maru_fastline2.png')
				Wait(5*1000)
				TriggerEvent('wf_menuViewer:picFadeout',2*1000)
			end)
		end
	end)
end)

Item('s162-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','liz_flower.png')
			end)
		end
	end)
end)

Item('s151-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','hagua_invite.png')
			end)
		end
	end)
end)

Item('s162-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','liz_lucky.png')
			end)
		end
	end)
end)
Item('s160-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','d_eldia.png')
			end)
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

Item('s17-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('wf_menuViewer:open','bon_book33.png')
		end
	end)
end)
Item('s39-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('wf_menuViewer:open','dragon_map2.png')
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

Item('bon_book3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('wf_menuViewer:open','bon_book33.png')
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

Item('s147-4', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('wf_menuViewer:open','0205news.png')
		end
	end)
end)

Item('news0210', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('wf_menuViewer:open','0210news.png')
		end
	end)
end)

Item('s147-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('wf_menuViewer:open','0302news.png')
		end
	end)
end)


Item('s190-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('wf_menuViewer:open','ga_seqw12.png')
		end
	end)
end)

Item('hao_pic', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('wf_menuViewer:open','hao_pic.png')
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

Item('s172-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerServerEvent('CF_core:startmusic')
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

Item('s15-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('yimo_message')
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


Item('f458-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx:showNotification', '覺得吃起來真的很硬，但是充滿能量。')
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


Item('s391-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('kai_food', './sounds/kai_food.mp3', 0.25, false)
			TriggerEvent('esx:showNotification', '雖然很飽，但是口乾舌燥，腦中出現了特殊的旋律。')
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

Item('m1-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx:showNotification', '把藥包拆開')
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


Item('t60-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx:showNotification', '打開家傳廚刀組')
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

Item('o63-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx:showNotification', '嘴裡充滿鹹味，請盡快飲水。')
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


Item('t77-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('gcPhone:OpenPhone')
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
                  	TriggerServerEvent('esx_religion_initial:removeItem','electric_bug',1) 
                  	TriggerServerEvent('esx_religion_initial:giveItem','techgem',1) 
                    TriggerServerEvent('wf_logs:addone', 'techgem2') 
                                
                end)
            end
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
Item('s24-12', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
            local maxHealth = 200
            SetEntityHealth(PlayerData.ped, 200)
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
Item('s24-9', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
            local maxHealth = 200
            SetEntityHealth(PlayerData.ped, 200)
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

Item('devitems', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			local metadata = data.metadata
			if metadata.itemtype == 'skinData' then
				TriggerEvent('bp_character:oyuncukiyafetyukle', metadata.skinData)
				TriggerEvent('bp_character:tattoyukle', metadata.tattoData)
			end
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

Item('whalepic_effectcard', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			local metadata = data.metadata
			TriggerServerEvent('CF_core:addvalue', 'effects', metadata.effectname)
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

Item('s122-4', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerServerEvent('CF_core:addRvalue', 'effects')
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

Item('s122-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerServerEvent('CF_core:addRlevel', 'ability', 1)
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

Item('t54-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			local metadata = data.metadata
			TriggerServerEvent('CF_core:addvalue', 'craft', metadata.crafting)
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


Item('f421-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerServerEvent('CF_core:hagua_galettes')
		end
	end)
end)

-----------------
--- bao edit

Item('t45-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx_religion_initial:screen_dragon')
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

Item('s181-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('hair')
		end
	end)
end)

Item('m30-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx_religion_initial:dragon_medican')
		end
	end)
end)

Item('t58-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e smoke')
		end
	end)
end)

Item('t58-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e smoke')
		end
	end)
end)

Item('t58-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e smoke')
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

Item('t85-8', function(data, slot)
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

Item('t85-4', function(data, slot)
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

Item('t85-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e bouquet')
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

Item('t85-7', function(data, slot)
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

Item('s169-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e teddy')
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

Item('f94-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('hagua_purewhite', './sounds/hagua_purewhite.mp3', 0.5, false)
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

Item('s391-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('kai_foodb', './sounds/kai_foodb.mp3', 0.5, false)
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
Item('f113-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx_religion_initial:red_screen20')
		end
	end)
end)

Item('f110-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
            TriggerServerEvent('esx_religion_initial:giveItem', 'hagua_dirty_lunch_box', 2) 
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

Item('s161-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e teddy')
		end
	end)
end)
Item('s13-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','wulong_note1.png')
			end)
		end
	end)
end)
Item('s13-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','wulong_note2.png')
			end)
		end
	end)
end)
Item('s13-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','wulong_note3.png')
			end)
		end
	end)
end)
Item('s13-4', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','wulong_note4.png')
			end)
		end
	end)
end)
Item('s13-5', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','wulong_note5.png')
			end)
		end
	end)
end)
Item('s13-6', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','wulong_note6.png')
			end)
		end
	end)
end)
Item('s13-7', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','wulong_note7.png')
			end)
		end
	end)
end)
Item('s13-8', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','wulong_note8.png')
			end)
		end
	end)
end)
Item('s13-9', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','wulong_note9.png')
			end)
		end
	end)
end)
Item('s159-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','blue_x1.png')
			end)
		end
	end)
end)
Item('s159-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','blue_x2.png')
			end)
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


Item('s156-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('wf_menuViewer:open','baby_meow.png')
			xSound:PlayUrl('kai_foodb', './sounds/baby_meow.ogg', 0.5, false)
		end
	end)
end)
Item('s157-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('wf_menuViewer:open','pon_uotbook_.png')
		end
	end)
end)
Item('s10-12', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','whitecity_lovenote1.png')
			end)
		end
	end)
end)

Item('s10-11', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','whitecity_lovenote2.png')
			end)
		end
	end)
end)

Item('s10-10', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','whitecity_lovenote3.png')
			end)
		end
	end)
end)

Item('s10-9', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','whitecity_lovenote4.png')
			end)
		end
	end)
end)

Item('s10-8', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','whitecity_lovenote5.png')
			end)
		end
	end)
end)

Item('f390-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				xSound:PlayUrl('pio_ha', './sounds/pio_ha.mp3', 0.55, false)
				TriggerEvent('wf_menuViewer:open','double-hachi.png')
				TriggerEvent('wf_menuViewer:picFadeout', 700)
			end)
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

Item('f82-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e chicken')
		end
	end)
end)

Item('s147-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','news0307.png')
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

--[[Item('t1-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_General:hacha_dig')
			end)
		end
	end)
end)]]
Item('c43-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e bouquet')
		end
	end)
end)

Item('s139-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','bon_1st_school_hunk.png')
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

Item('s124-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx_religion_initial:teleport_menuuu')
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


Item('s137-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('wf_menuViewer:open','baby_meow_pro.png')
			xSound:PlayUrl('baby_meow_pro', './sounds/baby_meow_pro.ogg', 0.6, false)
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
Item('s148-7', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				xSound:PlayUrl('ruru_dollrin', './sounds/ruru_dollrin.mp3', 0.55, false)
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
Item('s148-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				xSound:PlayUrl('ruru_dollhappy', './sounds/ruru_dollhappy.mp3', 0.75, false)
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
Item('s148-4', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				xSound:PlayUrl('ruru_dollyen', './sounds/ruru_dollyen.mp3', 0.55, false)
			end)
		end
	end)
end)

Item('s8-11', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','lulu_cardbrown.png')
			end)
		end
	end)
end)
Item('s8-9', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','lulu_cardshiny.png')
			end)
		end
	end)
end)
Item('s8-8', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','lulu_cardni.png')
			end)
		end
	end)
end)
Item('s8-7', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','lulu_cardrin.png')
			end)
		end
	end)
end)
Item('s8-5', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','lulu_cardhappy.png')
			end)
		end
	end)
end)
Item('s8-4', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','lulu_carddream.png')
			end)
		end
	end)
end)
Item('s8-6', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','lulu_card04.png')
			end)
		end
	end)
end)
Item('s8-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','lulu_card5.png')
			end)
		end
	end)
end)
Item('s8-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','lulu_carddeer.png')
			end)
		end
	end)
end)
Item('s8-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','lulu_cardyen.png')
			end)
		end
	end)
end)

Item('f50-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('wf_menuViewer:open','r7_guan.png')
			xSound:PlayUrl('kai_foodb', './sounds/r7_guan.mp3', 0.3, false)
		end
	end)
end)

Item('s132-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('wf_menuViewer:open','longpong_birth.png')
			xSound:PlayUrl('kai_foodb', './sounds/longpong_birth.mp3', 0.4, false)
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

Item('s131-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_core:startItemEffect','fire2_hand')
		end
	end)
end)

Item('s12-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','lee_cookni.png')
			end)
		end
	end)
end)
Item('s12-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','lee_cookshi.png')
			end)
		end
	end)
end)
Item('s12-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','lee_cooktang.png')
			end)
		end
	end)
end)

Item('s11-5', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','bear_letter1.png')
			end)
		end
	end)
end)
Item('s11-4', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','bear_letter2.png')
			end)
		end
	end)
end)
Item('s11-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','bear_letter3.png')
			end)
		end
	end)
end)
Item('s11-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','bear_letter4.png')
			end)
		end
	end)
end)
Item('s11-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','bear_letter5.png')
			end)
		end
	end)
end)
Item('s130-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','bon_deer.png')
			end)
		end
	end)
end)
Item('s129-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','doll_family.png')
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
Item('s125-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','d_card1.png')
			end)
		end
	end)
end)

Item('s125-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','d_card2.png')
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

Item('t182-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','salmon_peace.png')
			end)
		end
	end)
end)

Item('s346-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','daan_pic.png')
			end)
		end
	end)
end)

Item('s344-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('sugar_dragon', './sounds/sugar_dragon.ogg', 0.75, false)
			TriggerEvent('wf_menuViewer:open','sugar_dragon.png')
		end
	end)
end)

Item('s347-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','arbe_military.png')
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

Item('t92-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
    			TriggerEvent('dice_poker:Menu')
			end)
		end
	end)
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

Item('t183-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','hagua_wolf.png')
			end)
		end
	end)
end)

Item('s353-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','uzay_87.png')
			end)
		end
	end)
end)

Item('s353-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','uzay_guard.png')
			end)
		end
	end)
end)

Item('s353-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','uzay_hunter.png')
			end)
		end
	end)
end)

Item('s353-4', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','uzay_predictor.png')
			end)
		end
	end)
end)

Item('s353-5', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','uzay_process.png')
			end)
		end
	end)
end)

Item('s353-6', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','uzay_villagers.png')
			end)
		end
	end)
end)

Item('s353-7', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','uzay_wizard.png')
			end)
		end
	end)
end)

Item('s353-8', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','uzay_wolf.png')
			end)
		end
	end)
end)

Item('s353-9', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','uzay_rules.png')
			end)
		end
	end)
end)
Item('s355-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','schooldays_owo.png')
			end)
		end
	end)
end)
Item('s355-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','schooldays_p1p2.png')
			end)
		end
	end)
end)
Item('s363-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','schooldays2_powo.png')
			end)
		end
	end)
end)
Item('s363-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','schooldays2_p1p2.png')
			end)
		end
	end)
end)
Item('s355-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','schooldays_p3p4.png')
			end)
		end
	end)
end)
Item('s358-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','liz_fcardb.png')
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
Item('f1011-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e jdj')
		end
	end)
end)

Item('s270-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','gua_fate_1.png')
			end)
		end
	end)
end)
Item('s270-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','gua_fate_2.png')
			end)
		end
	end)
end)
Item('s270-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','gua_fate_3.png')
			end)
		end
	end)
end)
Item('s270-4', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','gua_fate_4.png')
			end)
		end
	end)
end)
Item('s270-5', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','gua_fate_5.png')
			end)
		end
	end)
end)
Item('s270-6', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','gua_fate_6.png')
			end)
		end
	end)
end)
Item('s270-7', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','gua_fate_7.png')
			end)
		end
	end)
end)
Item('s270-8', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','gua_fate_8.png')
			end)
		end
	end)
end)
Item('s270-9', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','gua_fate_9.png')
			end)
		end
	end)
end)
Item('s270-10', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','gua_fate_10.png')
			end)
		end
	end)
end)
Item('s270-11', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('gua_fate_11', './sounds/gua_fate_11.ogg', 0.55, false)
			TriggerEvent('wf_menuViewer:open','gua_fate_11.png')
		end
	end)
end)
Item('s270-12', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','gua_fate_12.png')
			end)
		end
	end)
end)
Item('s270-13', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('gua_fate_13', './sounds/gua_fate_13.ogg', 0.55, false)
			TriggerEvent('wf_menuViewer:open','gua_fate_13.png')
		end
	end)
end)
Item('s270-14', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('gua_fate_14', './sounds/gua_fate_14.ogg', 0.55, false)
			TriggerEvent('wf_menuViewer:open','gua_fate_14.png')
		end
	end)
end)
Item('s270-15', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','gua_fate_15.png')
			end)
		end
	end)
end)
Item('s270-16', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('gua_fate_16', './sounds/gua_fate_16.ogg', 0.55, false)
			TriggerEvent('wf_menuViewer:open','gua_fate_16.png')
		end
	end)
end)
Item('s270-17', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','gua_fate_17.png')
			end)
		end
	end)
end)
Item('s270-18', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','gua_fate_18.png')
			end)
		end
	end)
end)
Item('s270-19', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','gua_fate_19.png')
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
				TriggerEvent('wf_menuViewer:open','bon_sleep.png')
			end)
		end
	end)
end)

Item('s367-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('me 抱住管理者抱枕')
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','bon_guan.png')
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

Item('s364-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('CF_core:startInputText')
			end)
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


Item('s369-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('gua_konfu', './sounds/gua_konfu.ogg', 0.35, false)
			Wait(5*1000)
			ExecuteCommand('e karate')
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


Item('t197-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx_policejob:starthandcuff',data.name)
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

Item('s366-4', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			exports['okokNotify']:Alert("演繹提示", "一般人吃了不會有任何效果和副作用，但若是受到心理暗示或精神打擊而精神錯亂者，服用後會進入沉睡，並沉睡10-15分鐘，甦醒後會恢復正常，且遺忘精神暗示內容(精神異常期間記憶將保存)。 沉睡指令：/selfkill", 100000, 'warning')
		end
	end)
end)


Item('t201-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','moka_cheque.png')
			end)
		end
	end)
end)
Item('t200-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','moka_credit_card.png')
			end)
		end
	end)
end)
Item('s371-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','moka_poker.png')
			end)
		end
	end)
end)

Item('t202-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('ella_talk', './sounds/ella_talk.ogg', 0.55, false)
			TriggerEvent('wf_menuViewer:open','ella_talk.png')
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

Item('t203-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','d_tod1.png')
			end)
		end
	end)
end)

local selection_list = {'笑筊','聖筊','陰筊','笑筊','聖筊','陰筊','笑筊','聖筊','陰筊','笑筊','聖筊','陰筊','笑筊','聖筊','陰筊','笑筊','聖筊','陰筊','立筊 '}
function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict( dict )
        Citizen.Wait(5)
    end
end

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

--1/28

Item('s271-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','b1_end.png')
			end)
		end
	end)
end)
Item('s271-4', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','b3_end.png')
			end)
		end
	end)
end)
Item('s272-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_19.png')
			end)
		end
	end)
end)
Item('s272-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_19boom.png')
			end)
		end
	end)
end)
Item('s272-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_19cn.png')
			end)
		end
	end)
end)
Item('s272-5', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_19us.png')
			end)
		end
	end)
end)
Item('s272-4', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_19train.png')
			end)
		end
	end)
end)
Item('s272-6', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_19zem.png')
			end)
		end
	end)
end)
Item('s273-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_aurora.png')
			end)
		end
	end)
end)
Item('t108-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e smoke')
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
Item('s288-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_8184_photo.png')
			end)
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
Item('s290-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_5938_letter.png')
			end)
		end
	end)
end)
Item('s290-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_2529_leaflet.png')
			end)
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

Item('t134-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e smoke')
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


Item('f733-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('g1_5748_wafer', './sounds/g1_5748_wafer.ogg', 0.55, false)
		end
	end)
end)
Item('f676-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('g1_5748_letmedoitforyou', './sounds/g1_5748_letmedoitforyou.ogg', 0.55, false)
		end
	end)
end)
--[[Item('s302-2', function(data, slot)
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
end)]]

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
Item('t142-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e smoke')
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
Item('t145-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_6268_paper.png')
			end)
		end
	end)
end)
Item('s305-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_0604_letter1.png')
			end)
		end
	end)
end)
Item('s305-4', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_0604_letter2.png')
			end)
		end
	end)
end)
Item('s305-5', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_0604_letter3.png')
			end)
		end
	end)
end)
Item('s263-5', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_0825_utian.png')
			end)
		end
	end)
end)
Item('s263-9', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_3240_utian.png')
			end)
		end
	end)
end)
Item('t151-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e smoke')
			end
	end)
end)


Item('s262-2', function(data, slot)
	local ItemAuthorized = checkItemsv({'g1_0604_radio'}and{'g1_0604_better'})
	if ItemAuthorized  ~= nil then
		xSound:PlayUrl('g1_0604_tape', './sounds/g1_0604_tape.ogg', 0.99, false)
		if math.random(1,100) > 80 then 
			TriggerServerEvent('esx_religion_initial:removeItem','g1_0604_better',1) 
			TriggerServerEvent('esx_religion_initial:giveItem','g1_0604_better2',1) 
		end
	end
end)
Item('s262-1', function(data, slot)
	local ItemAuthorized = checkItemsv({'g1_0604_radio'}and{'g1_0604_better'})
	if ItemAuthorized  ~= nil then
		xSound:PlayUrl('g1_0604_tape', './sounds/g1_0604_tape2.ogg', 0.79, false)
		if math.random(1,100) > 80 then 
			TriggerServerEvent('esx_religion_initial:removeItem','g1_0604_better',1) 
			TriggerServerEvent('esx_religion_initial:giveItem','g1_0604_better2',1) 
		end
	end
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

Item('s308-3', function(data, slot)
    ox_inventory:useItem(data, function(data)
        if data then
            xSound:PlayUrl('g1_5637_octopus', './sounds/g1_5637_octopus.ogg', 0.55, false)
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
end)Item('f692-1', function(data, slot)
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
Item('f672-2', function(data, slot)
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
Item('f673-1', function(data, slot)
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
Item('f674-1', function(data, slot)
    local ItemAuthorized = checkItemsv({'g1_opener'})
    if ItemAuthorized  ~= nil then
        ox_inventory:useItem(data, function(data)
        end)
    else
      lib.notify({type = 'error', description = '你沒有可以開啟他的工具'})
    end
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
Item('t140-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx_religion_initial:heal3',0.1)
		end
	end)
end)
Item('t4-4', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx_religion_initial:heal3',0.3)
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

Item('m46-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e smoke')
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
Item('g1_3931_can1', function(data, slot)
    ox_inventory:useItem(data, function(data)
        if data then
            TriggerEvent('CF_General:g1_3931_can1')
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

Item('g1_1788_foodcan4', function(data, slot)
    local ItemAuthorized = checkItemsv({'g1_opener'})
    if ItemAuthorized  ~= nil then
        ox_inventory:useItem(data, function(data)
        end)
    else
      lib.notify({type = 'error', description = '你沒有可以開啟他的工具'})
    end
end)
Item('s314-4', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_eden_3.png')
			end)
		end
	end)
end)
Item('s314-5', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_eden_4.png')
			end)
		end
	end)
end)
Item('s314-6', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_eden_5.png')
			end)
		end
	end)
end)
Item('s314-7', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_eden_6.png')
			end)
		end
	end)
end)
Item('t160-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_3240_pot.png')
			end)
		end
	end)
end)
Item('o33-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_3240_curry.png')
			end)
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
Item('c94-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx_religion_initial:heal3',0.1)
		end
	end)
end)


local g1_4753_mask = {
	id = 0,
	color = 0,
	flag = false
}
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
local g1_3618_ring = {
	id = 0,
	color = 0,
	flag = false
}
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
local g1_3468_ring = {
	id = 0,
	color = 0,
	flag = false
}
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

Item('m20-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx_religion_initial:heal3',0.3)
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
Item('t166-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_1001_pot.png')
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
g1_airpod_flag = false
Item('t91-2', function(data, slot)
    local ItemAuthorized = checkItemsv({'g1_0604_better'})
    if ItemAuthorized  ~= nil then
        g1_airpod_flag  = not g1_airpod_flag 
        if g1_airpod_flag then
            xSound:PlayUrl('g1_1684_airpod', './sounds/g1_1684_airpod.ogg', 0.65, true)
            if math.random(1,100) > 90 then 
                TriggerServerEvent('esx_religion_initial:removeItem','g1_0604_better',1) 
                TriggerServerEvent('esx_religion_initial:giveItem','g1_0604_better2',1) 
            end
        else
            xSound:Destroy('g1_1684_airpod')
        end
    end
end)Item('t168-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_3240_longmao.png')
			end)
		end
	end)
end)
Item('s320-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_3240_friendly.png')
			end)
		end
	end)
end)
Item('s321-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_3240_uda.png')
			end)
		end
	end)
end)
Item('s321-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_3240_sawcleanner.png')
			end)
		end
	end)
end)
Item('s321-5', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('g1_3240_saw3', './sounds/g1_3240_saw3.ogg', 0.65, false)
			TriggerServerEvent('esx_religion_initial:giveItem','water',2) 
			TriggerServerEvent('esx_religion_initial:giveItem','g1_3240_saw1',1) 
			TriggerServerEvent('esx_religion_initial:giveItem','g1_3240_sawcleanner',1)
			if math.random(1,100) > 80 then				
				TriggerServerEvent('esx_religion_initial:removeItem','g1_3240_sawcleanner',1)
			end 
		end
	end)
end)
Item('t168-1', function(data, slot)
	local ItemAuthorized = checkItemsv({'g1_0604_better'})
	if ItemAuthorized  ~= nil then
		xSound:PlayUrl('g1_3240_longmao', './sounds/g1_3240_longmao.ogg', 0.55, false)
		if math.random(1,100) > 80 then 
			TriggerServerEvent('esx_religion_initial:removeItem','g1_0604_better',1) 
			TriggerServerEvent('esx_religion_initial:giveItem','g1_0604_better2',1) 
		end
	end
end)
Item('s321-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('CF_General:g1_3240_saw1')
		end
	end)
end)
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
            TriggerServerEvent('esx_religion_initial:giveItem', 'water', 1)  
            TriggerServerEvent('esx_religion_initial:removeItem', 'rain_water', 2)  
            lib.notify({title = '濾水系統',description = '濾水成功',type = 'success'})
            if math.random(1,100) > (80+math.random(0,20)) then 
                TriggerServerEvent('esx_religion_initial:removeItem',ItemAuthorized ,1) 
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
            TriggerServerEvent('esx_religion_initial:giveItem', 'water', 1)  
            TriggerServerEvent('esx_religion_initial:removeItem', 'g1_dirty_water', 4)  
            lib.notify({title = '濾水系統',description = '濾水成功',type = 'success'})
            if math.random(1,100) > (80+math.random(0,20)) then 
                TriggerServerEvent('esx_religion_initial:removeItem',ItemAuthorized ,1) 
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
end)Item('t173-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e danceglowstick')
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
                    TriggerServerEvent('esx_religion_initial:giveItem','g1_5637_4444',1)
                    TriggerServerEvent('esx_religion_initial:removeItem',ItemAuthorized,1)
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
        TriggerServerEvent('esx_religion_initial:removeItem','g1_5637_3333',1)
		ExecuteCommand('WEc:SNPFX_NEW core ent_dst_inflatable 0.0 0.0 0.02 0 0 0 0')
    end
end)
Item('s259-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_0604_pic1.png')
			end)
		end
	end)
end)
Item('s259-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_0604_pic2.png')
			end)
		end
	end)
end)
Item('s265-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_eden_12140112.png')
			end)
		end
	end)
end)
Item('s265-2', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_eden_12130403.png')
			end)
		end
	end)
end)
Item('s265-3', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_eden_12131116.png')
			end)
		end
	end)
end)
Item('s265-4', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_eden_12140505.png')
			end)
		end
	end)
end)
Item('s265-5', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_eden_12141007.png')
			end)
		end
	end)
end)
Item('s265-6', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_eden_12141112.png')
			end)
		end
	end)
end)
Item('s265-7', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_eden_12141210.png')
			end)
		end
	end)
end)
Item('s265-8', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_eden_d1.png')
			end)
		end
	end)
end)
Item('s265-15', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_eden_d8.png')
			end)
		end
	end)
end)
Item('s265-14', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_eden_d7.png')
			end)
		end
	end)
end)
Item('s265-13', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_eden_d6.png')
			end)
		end
	end)
end)
Item('s265-12', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_eden_d5.png')
			end)
		end
	end)
end)
Item('s265-11', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_eden_d4.png')
			end)
		end
	end)
end)
Item('s265-10', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_eden_d3.png')
			end)
		end
	end)
end)
Item('s265-9', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_eden_d2.png')
			end)
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
Item('f888-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('helpme_giveitem g1_1397_littlefood 10')
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
Item('s334-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			ExecuteCommand('e umbrella')
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


Item('s336-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_0001_label.png')
			end)
		end
	end)
end)

Item('s338-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_2529_pic.png')
			end)
		end
	end)
end)
Item('s339-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			Citizen.CreateThread(function()
				TriggerEvent('wf_menuViewer:open','g1_6268_card.png')
			end)
		end
	end)
end)

Item('s341-1', function(data, slot)
	ox_inventory:useItem(data, function(data)
		if data then
			xSound:PlayUrl('r4_3870_shrimp', './sounds/r4_3870_shrimp.ogg', 0.15, false)
			TriggerEvent('wf_menuViewer:open','r4_3870_shrimp.png')
		end
	end)
end)


-----------------------------------------------------------------------------------------------

exports('Items', function(item) return getItem(nil, item) end)
exports('ItemList', function(item) return getItem(nil, item) end)

return Items
