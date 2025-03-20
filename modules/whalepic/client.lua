local WhaleEpic = {}

RegisterCommand('ox_inventory:toggleGiveMode', function()
	client.giveplayerlist = not client.giveplayerlist
	if client.giveplayerlist then
		lib.notify({
		    title = '背包系統',
		    description = '變更給予模式為 玩家列表 模式',
		    type = 'success'
		})
	else
		lib.notify({
		    title = '背包系統',
		    description = '變更給予模式為 Raycast 模式',
		    type = 'success'
		})
	end
end)

function WhaleEpic.Raycast(flag, radius)
	local playerCoords = GetEntityCoords(cache.ped)
	local plyOffset = GetOffsetFromEntityInWorldCoords(cache.ped, 0.0, radius, -0.25)
	local rayHandle = StartShapeTestCapsule(plyOffset.x, plyOffset.y, plyOffset.z + 0.5, plyOffset.x, plyOffset.y, plyOffset.z + 0.5, radius, flag or 30, cache.ped, 4)

	while true do
		Wait(0)
		local retval, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)
		if result ~= 1 then
			local entityType
			if entityHit then entityType = GetEntityType(entityHit) end
			if entityHit and entityType ~= 0 then
				return entityHit, entityType
			end
			return false
		end
	end
end


client.whalepic = WhaleEpic