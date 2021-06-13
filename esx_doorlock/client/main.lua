ESX = nil
local closestDoor, closestV, closestDistance, playerPed, playerCoords, doorCount, retrievedData
local playerNotActive = true

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	ESX.PlayerData = ESX.GetPlayerData()
	-- Sync doors with the server
	ESX.TriggerServerCallback('nui_doorlock:getDoorInfo', function(doorInfo)
		for doorID, locked in pairs(doorInfo) do
			Config.DoorList[doorID].locked = locked
		end
		retrievedData = true
	end)
	while not retrievedData do Citizen.Wait(0) end
	while IsPedStill(PlayerPedId()) and not IsPedInAnyVehicle(PlayerPedId()) do Citizen.Wait(0) end
	updateDoors()
	playerNotActive = nil
	retrievedData = nil
end)

-- Sync a door with the server
RegisterNetEvent('nui_doorlock:setState')
AddEventHandler('nui_doorlock:setState', function(doorID, locked, src)
	CreateThread(function()
		Config.DoorList[doorID].locked = locked
		while true do
			Citizen.Wait(0)
			if Config.DoorList[doorID].doors then
				for k, v in pairs(Config.DoorList[doorID].doors) do
					if not DoesEntityExist(v.object) then return end -- If the entity does not exist, end the loop
					v.currentHeading = GetEntityHeading(v.object)
					v.doorState = DoorSystemGetDoorState(v.doorHash)
					if Config.DoorList[doorID].slides then
						if Config.DoorList[doorID].locked then
							DoorSystemSetDoorState(v.doorHash, 1, false, false) -- Set to locked
							DoorSystemSetAutomaticDistance(v.doorHash, 0, false, false)
							if k == 2 then playSound(Config.DoorList[doorID], src) return end -- End the loop
						else
							DoorSystemSetDoorState(v.doorHash, 0, false, false) -- Set to unlocked
							DoorSystemSetAutomaticDistance(v.doorHash, 20, false, false)
							if k == 2 then playSound(Config.DoorList[doorID], src) return end -- End the loop
						end
					elseif Config.DoorList[doorID].locked and (v.doorState == 4) then
						if Config.DoorList[doorID].oldMethod then FreezeEntityPosition(v.object, true) end
						DoorSystemSetDoorState(v.doorHash, 1, false, false) -- Set to locked
						if Config.DoorList[doorID].doors[1].doorState == Config.DoorList[doorID].doors[2].doorState then playSound(Config.DoorList[doorID], src) return end -- End the loop
					elseif not Config.DoorList[doorID].locked then
						if Config.DoorList[doorID].oldMethod then FreezeEntityPosition(v.object, false) end
						DoorSystemSetDoorState(v.doorHash, 0, false, false) -- Set to unlocked
						if Config.DoorList[doorID].doors[1].doorState == Config.DoorList[doorID].doors[2].doorState then playSound(Config.DoorList[doorID], src) return end -- End the loop
					else
						if round(v.currentHeading, 0) == round(v.objHeading, 0) then
							DoorSystemSetDoorState(v.doorHash, 4, false, false) -- Force to close
						end
					end
				end
			else
				if not DoesEntityExist(Config.DoorList[doorID].object) then return end -- If the entity does not exist, end the loop
				Config.DoorList[doorID].currentHeading = GetEntityHeading(Config.DoorList[doorID].object)
				Config.DoorList[doorID].doorState = DoorSystemGetDoorState(Config.DoorList[doorID].doorHash)
				if Config.DoorList[doorID].slides then
					if Config.DoorList[doorID].locked then
						DoorSystemSetDoorState(Config.DoorList[doorID].doorHash, 1, false, false) -- Set to locked
						DoorSystemSetAutomaticDistance(Config.DoorList[doorID].doorHash, 0, false, false)
						playSound(Config.DoorList[doorID], src)
						return -- End the loop
					else
						DoorSystemSetDoorState(Config.DoorList[doorID].doorHash, 0, false, false) -- Set to unlocked
						DoorSystemSetAutomaticDistance(Config.DoorList[doorID].doorHash, 20, false, false)
						playSound(Config.DoorList[doorID], src)
						return -- End the loop
					end
				elseif Config.DoorList[doorID].locked and (Config.DoorList[doorID].doorState == 4) then
					if Config.DoorList[doorID].oldMethod then FreezeEntityPosition(Config.DoorList[doorID].object, true) end
					DoorSystemSetDoorState(Config.DoorList[doorID].doorHash, 1, false, false) -- Set to locked
					playSound(Config.DoorList[doorID], src)
					return -- End the loop
				elseif not Config.DoorList[doorID].locked then
					if Config.DoorList[doorID].oldMethod then FreezeEntityPosition(Config.DoorList[doorID].object, false) end
					DoorSystemSetDoorState(Config.DoorList[doorID].doorHash, 0, false, false) -- Set to unlocked
					playSound(Config.DoorList[doorID], src)
					return -- End the loop
				else
					if round(Config.DoorList[doorID].currentHeading, 0) == round(Config.DoorList[doorID].objHeading, 0) then
						DoorSystemSetDoorState(Config.DoorList[doorID].doorHash, 4, false, false) -- Force to close
					end
				end
			end
		end
	end)
end)

function playSound(door, src)
	local origin
	if src and src ~= playerPed then src = NetworkGetEntityFromNetworkId(src) end
	if not src then origin = door.textCoords elseif src == playerPed then origin = playerCoords else origin = NetworkGetPlayerCoords(src) end
	local distance = #(playerCoords - origin)
	--print(origin)
	if distance < 10 then
		if not door.audioLock then
			if door.audioRemote then
				door.audioLock = {['file'] = 'button-remote.ogg', ['volume'] = 0.08}
				door.audioUnlock = {['file'] = 'button-remote.ogg', ['volume'] = 0.08}
			else
				door.audioLock = {['file'] = 'door-bolt-4.ogg', ['volume'] = 0.1}
				door.audioUnlock = {['file'] = 'door-bolt-4.ogg', ['volume'] = 0.1}
			end
		end
		local sfx_level = GetProfileSetting(300)
		if door.locked then SendNUIMessage ({action = 'audio', audio = door.audioLock, distance = distance, sfx = sfx_level})
		else SendNUIMessage ({action = 'audio', audio = door.audioUnlock, distance = distance, sfx = sfx_level}) end
	end
end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

local last_x, last_y, lasttext, isDrawing
function DrawTextNUI(coords, text)
	local paused = false
	if IsPauseMenuActive() then paused = true end
	local onScreen,_x,_y = GetScreenCoordFromWorldCoord(coords.x,coords.y,coords.z)
	if _x ~= last_x or _y ~= last_y or text ~= lasttext or paused then
		isDrawing = true
		if paused then SendNUIMessage ({action = "hide"}) else SendNUIMessage({action = "display", x = _x, y = _y, text = text}) end
		last_x, last_y, lasttext = _x, _y, text
		Citizen.Wait(0)
	end
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

function dooranim(entity, state)
	Citizen.CreateThread(function()
    loadAnimDict("anim@heists@keycard@") 
	TaskPlayAnim(playerPed, "anim@heists@keycard@", "exit", 8.0, 1.0, -1, 16, 0, 0, 0, 0)
    Citizen.Wait(550)
	ClearPedTasks(playerPed)
	end)
end

function round(num, decimal)
	local mult = 10^(decimal)
	return math.floor(num * mult + 0.5) / mult
end

function debug(doorID, data)
	if GetDistanceBetweenCoords(playerCoords, data.textCoords) < 3 then
		if data.doors then door = '{'.. data.doors[1].object..' '.. data.doors[2].object.. '}' else door = data.object end
		return print(   ('[%s] locked: %s  object: %s'):format(index, data.locked, door)   )
	end
end

function updateDoors()
	playerCoords = GetEntityCoords(PlayerPedId())
	for doorID, data in ipairs(Config.DoorList) do
		if data.doors then
			for k,v in ipairs(data.doors) do
				if #(vector2(playerCoords.x, playerCoords.y) - vector2(v.objCoords.x, v.objCoords.y)) < 100 then
					v.object = GetClosestObjectOfType(v.objCoords, 1.0, v.objHash, false, false, false)
					if data.delete then
						SetEntityAsMissionEntity(v.object, 1, 1)
						DeleteObject(v.object)
						v.object = nil
					end
					if v.object then
						v.doorHash = 'doorlock_'..doorID..'-'..k
						AddDoorToSystem(v.doorHash, v.objHash, v.objCoords, false, false, false)
						if data.locked then
							DoorSystemSetDoorState(v.doorHash, 4, false, false) DoorSystemSetDoorState(v.doorHash, 1, false, false)
						 else
							DoorSystemSetDoorState(v.doorHash, 0, false, false) if data.oldMethod then FreezeEntityPosition(v.object, false) end
						end
					end
				elseif v.object then RemoveDoorFromSystem(v.doorHash) end
			end
		elseif not data.doors then
			if #(vector2(playerCoords.x, playerCoords.y) - vector2(data.objCoords.x, data.objCoords.y)) < 100 then
				if data.slides then data.object = GetClosestObjectOfType(data.objCoords, 5.0, data.objHash, false, false, false) else
					data.object = GetClosestObjectOfType(data.objCoords, 1.0, data.objHash, false, false, false)
				end
				if data.delete then
					SetEntityAsMissionEntity(data.object, 1, 1)
					DeleteObject(data.object)
					data.object = nil
				end
				if data.object then
					data.doorHash = 'doorlock_'..doorID
					AddDoorToSystem(data.doorHash, data.objHash, data.objCoords, false, false, false) 
					if data.locked then
						DoorSystemSetDoorState(data.doorHash, 4, false, false) DoorSystemSetDoorState(data.doorHash, 1, false, false)
					 else
						DoorSystemSetDoorState(data.doorHash, 0, false, false) if data.oldMethod then FreezeEntityPosition(data.object, false) end
					end
				end
			elseif data.object then RemoveDoorFromSystem(data.doorHash) end
		end
		-- set text coords
		if not data.setText and data.doors then
			for k,v in ipairs(data.doors) do
				if k == 1 and DoesEntityExist(v.object) then
					data.textCoords = v.objCoords
				elseif k == 2 and DoesEntityExist(v.object) and data.textCoords then
					local textDistance = data.textCoords - v.objCoords
					data.textCoords = (data.textCoords - (textDistance / 2))
					data.setText = true
				end
				if k == 2 and data.textCoords and data.slides then
					if GetEntityHeightAboveGround(v.object) < 1 then
						data.textCoords = vector3(data.textCoords.x, data.textCoords.y, data.textCoords.z+1.2)
					end
				end
			end
		elseif not data.setText and not data.doors and DoesEntityExist(data.object) then
			if not data.garage then
				local minDimension, maxDimension = GetModelDimensions(data.objHash)
				if data.fixText then dimensions = minDimension - maxDimension else dimensions = maxDimension - minDimension end
				local dx, dy = tonumber(string.sub(dimensions.x, 1, 6)), tonumber(string.sub(dimensions.y, 1, 6))
				local h = tonumber(string.sub(data.objHeading, 1, 1))
				if h == 9 or h == 8 or h == 2 then dx, dy = dy, dx end
				local maths = vector3(dx/2, dy/2, 0)
				data.textCoords = GetEntityCoords(data.object) - maths
				data.setText = true
			else
				data.textCoords = GetEntityCoords(data.object)
				data.setText = true
			end
			if data.slides then
				if GetEntityHeightAboveGround(data.object) < 1 then
					data.textCoords = vector3(data.textCoords.x, data.textCoords.y, data.textCoords.z+1.6)
				end
			end
		end
	end
	doorCount = DoorSystemGetSize()
	if doorCount ~= 0 then print(('%s doorlock zaladowano'):format(doorCount)) end
end

Citizen.CreateThread(function()
	while playerNotActive do Citizen.Wait(100) end
	lastCoords = playerCoords
	while playerCoords do
		local distance = #(playerCoords - lastCoords)
		if distance > 30 then
			updateDoors()
			lastCoords = playerCoords
		end
		Citizen.Wait(500)
		if doorCount == 0 then Citizen.Wait(500) end
	end
end)

local doorSleep = 500
Citizen.CreateThread(function()
	while not playerCoords do Citizen.Wait(0) end
	while true do
		Citizen.Wait(0)
		if doorCount then
			local distance
			for k,v in ipairs(Config.DoorList) do
				if v.setText and (v.object or (v.doors and v.doors[1].object)) then
					distance = #(vector2(v.textCoords.x, v.textCoords.y) - vector2(playerCoords.x, playerCoords.y))
					if v.setText and distance < v.maxDistance then
						closestDoor, closestV, closestDistance = k, v, distance
					end
				end
			end
			Citizen.Wait(doorSleep)
		else Citizen.Wait(1000) end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		playerPed = PlayerPedId()
		playerCoords = GetEntityCoords(playerPed)
		if doorCount ~= nil and doorCount ~= 0 and closestDistance and closestV.setText then
			closestDistance = #(closestV.textCoords - playerCoords)
			if closestDistance < closestV.maxDistance then
				doorSleep = 5
				if not closestV.doors then
					local doorState = DoorSystemGetDoorState(closestV.doorHash)
					local heading = GetEntityHeading(closestV.object)
					if closestV.locked and round(heading, 0) ~= round(closestV.objHeading, 0) then
						DrawTextNUI(closestV.textCoords, 'Locking')
					elseif not closestV.locked then
						if Config.ShowUnlockedText then DrawTextNUI(closestV.textCoords, 'Unlocked') else if isDrawing then SendNUIMessage ({action = "hide"}) isDrawing = false end end
					else
						DrawTextNUI(closestV.textCoords, 'Locked')
					end
				else
					local door = {}
					for k2,v2 in ipairs(closestV.doors) do
						local doorState = DoorSystemGetDoorState(v2.doorHash)
						if doorState == 1 and closestV.locked then door[k2] = true else door[k2] = false end
					end
					if door[1] and door[1] == door[2] then DrawTextNUI(closestV.textCoords, 'Locked')
					elseif not closestV.locked then if Config.ShowUnlockedText then DrawTextNUI(closestV.textCoords, 'Unlocked') else if isDrawing then SendNUIMessage ({action = "hide"}) isDrawing = false end end
					else DrawTextNUI(closestV.textCoords, 'Locking') end
				end
			else
				if closestDistance > closestV.maxDistance and isDrawing then
					SendNUIMessage ({action = "hide"}) isDrawing = false
				end
				closestDoor, closestV, closestDistance = nil, nil, nil
			end
		end
		
		if doorCount == 0 then doorSleep = 1000 Citizen.Wait(900) end
	end
end)

function IsAuthorized(doorID)
	if ESX.PlayerData.job == nil then
		return false
	end

	for _,job in pairs(doorID.authorizedJobs) do
		if job == ESX.PlayerData.job.name then
			return true
		end
	end

	return false
end

RegisterCommand('doorlock', function()
	if closestDoor and IsAuthorized(closestV) then
		if IsControlPressed(0, 86) or IsControlReleased(0, 86) then key = 'e' end
		local veh = GetVehiclePedIsIn(playerPed)
		dooranim(closestV.object, closestV.locked)
		if veh and key == 'e' then
			Citizen.CreateThread(function()
				local counter = 0
				local siren = IsVehicleSirenOn(veh)
				repeat
					DisableControlAction(0, 86, true)
					SetHornEnabled(veh, false)
					if not siren then SetVehicleSiren(veh, false) end
					counter = counter + 1
					Citizen.Wait(0)
				until (counter == 100)
				SetHornEnabled(veh, true)
			end)
		end
		closestV.locked = not closestV.locked
		--debug(closestDoor, closestV)
		if closestV.audioRemote then src = NetworkGetNetworkIdFromEntity(playerPed) else src = nil end
		TriggerServerEvent('nui_doorlock:updateState', closestDoor, closestV.locked, src) -- Broadcast new state of the door to everyone
	end
end)
RegisterKeyMapping('doorlock', 'Interact with a door lock', 'keyboard', 'e')



RegisterNetEvent('nui_doorlock:newDoorSetup')
AddEventHandler('nui_doorlock:newDoorSetup', function(args)
	if not args[1] then print('/newdoor [doortype] [locked] [jobs]\nDoortypes: door, sliding, garage, double, doublesliding\nLocked: true or false\nJobs: Up to four can be added with the command') return end
	local doorType = tostring(args[1])
	local doorLocked = not not args[2]
	local validTypes = {['door']=true, ['sliding']=true, ['garage']=true, ['double']=true, ['doublesliding']=true}
	if not validTypes[doorType] then print(doorType.. 'is not a valid doortype') return end
	if doorLocked ~= false and doorLocked ~= true then print('Second argument must be true or false') return end
	if args[7] then print('You can only set four authorised jobs - if you want more, add them to the config later') return end
	if doorType == 'door' or doorType == 'sliding' or doorType == 'garage' then
		local entity, coords, heading, model
		print('Aim at your desired door and press left mouse button')
		while true do
			Citizen.Wait(0)
			if IsPlayerFreeAiming(PlayerId()) then
				result, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())
				coords = GetEntityCoords(entity)
				heading = GetEntityHeading(entity)
				model = GetEntityModel(entity)
			end
			if IsControlJustPressed(0, 24) then break end
		end
		if model == 0 then print('Did not receive a model hash') return end
		local jobs = tostring("'"..args[3].."'")
		if args[4] then jobs = jobs..', '..tostring("'"..args[4].."'") end
		if args[5] then jobs = jobs..', '..tostring("'"..args[5].."'") end
		if args[6] then jobs = jobs..', '..tostring("'"..args[6].."'") end
		local maxDistance, slides, garage = 2.0, false, false
		if doorType == 'slides' then maxDistance, slides = 6.0, true
		elseif doorType == 'garage' then maxDistance, slides, garage = 6.0, true, true end
		TriggerServerEvent('nui_doorlock:newDoorCreate', model, heading, coords, jobs, doorLocked, maxDistance, slides, garage, false)
		print('Successfully sent door data to the server')
	elseif doorType == 'double' or doorType == 'doublesliding' then
		local entity, coords, heading, model = {}, {}, {}, {},
		print('Aim at each desired door and press left mouse button')
		while true do
			Citizen.Wait(0)
			if IsPlayerFreeAiming(PlayerId()) then
				result, entity[1] = GetEntityPlayerIsFreeAimingAt(PlayerId())
				coords[1] = GetEntityCoords(entity[1])
				heading[1] = GetEntityHeading(entity[1])
				model[1] = GetEntityModel(entity[1])
			end
			if IsControlJustPressed(0, 24) then break end
		end
		while true do
			Citizen.Wait(0)
			if IsPlayerFreeAiming(PlayerId()) then
				result, entity[2] = GetEntityPlayerIsFreeAimingAt(PlayerId())
				coords[2] = GetEntityCoords(entity[2])
				heading[2] = GetEntityHeading(entity[2])
				model[2] = GetEntityModel(entity[2])
			end
			if IsControlJustPressed(0, 24) then break end
		end
		if model == 0 then print('Did not receive a model hash') return end
		local jobs = tostring("'"..args[3].."'")
		if args[4] then jobs = jobs..', '..tostring("'"..args[4].."'") end
		if args[5] then jobs = jobs..', '..tostring("'"..args[5].."'") end
		if args[6] then jobs = jobs..', '..tostring("'"..args[6].."'") end
		local maxDistance, slides, garage = 2.5, false, false
		if doorType == 'slides' then slides = true end
		TriggerServerEvent('nui_doorlock:newDoorCreate', model, heading, coords, jobs, doorLocked, maxDistance, slides, garage, true)
		print('Successfully sent door data to the server')
	end
end)
