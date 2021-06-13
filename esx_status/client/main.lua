local Status = {}
local isPaused = false
local playerSpawned = false
function GetStatusData(minimal)
	local status = {}

	for i=1, #Status, 1 do
		if minimal then
			table.insert(status, {
				name    = Status[i].name,
				val     = Status[i].val,
				percent = (Status[i].val / Config.StatusMax) * 100
			})
		else
			table.insert(status, {
				name    = Status[i].name,
				val     = Status[i].val,
				color   = Status[i].color,
				visible = Status[i].visible(Status[i]),
				max     = Status[i].max,
				percent = (Status[i].val / Config.StatusMax) * 100
			})
		end
	end

	return status
end

AddEventHandler('esx_status:registerStatus', function(name, default, color, visible, tickCallback)
	local status = CreateStatus(name, default, color, visible, tickCallback)
	table.insert(Status, status)
end)
RegisterNetEvent('esx_status:charSpawnedClient')
AddEventHandler('esx_status:charSpawnedClient', function()
	Citizen.Wait(5000)
	playerSpawned = true
end)
RegisterNetEvent('esx_status:load')
AddEventHandler('esx_status:load', function(status)
	for i=1, #Status, 1 do
		for j=1, #status, 1 do
			if Status[i].name == status[j].name then
				Status[i].set(status[j].val)
			end
		end
	end

	Citizen.CreateThread(function()
		while true do
			for i=1, #Status, 1 do
				Status[i].onTick()
			end

			SendNUIMessage({
				update = true,
				status = GetStatusData()
			})

			TriggerEvent('esx_status:onTick', GetStatusData(true))
			TriggerEvent('esx_customui:updateStatus', GetStatusData(true))
			
			Citizen.Wait(Config.TickTime)

		end
	end)
end)

RegisterNetEvent('esx_status:set')
AddEventHandler('esx_status:set', function(name, val)
	for i=1, #Status, 1 do
		if Status[i].name == name then
			Status[i].set(val)
			break
		end
	end

	SendNUIMessage({
		update = true,
		status = GetStatusData()
	})

	TriggerServerEvent('esx_status:update', GetStatusData(true), playerSpawned)
end)

RegisterNetEvent('esx_status:add')
AddEventHandler('esx_status:add', function(name, val)
	for i=1, #Status, 1 do
		if Status[i].name == name then
			Status[i].add(val)
			break
		end
	end

	SendNUIMessage({
		update = true,
		status = GetStatusData()
	})
	TriggerServerEvent('esx_status:update', GetStatusData(true), playerSpawned)
end)

RegisterNetEvent('esx_status:remove')
AddEventHandler('esx_status:remove', function(name, val)
	for i=1, #Status, 1 do
		if Status[i].name == name then
			Status[i].remove(val)
			break
		end
	end

	SendNUIMessage({
		update = true,
		status = GetStatusData()
	})
	
	TriggerServerEvent('esx_status:update', GetStatusData(true), playerSpawned)
end)

AddEventHandler('esx_status:getStatus', function(name, cb)
	for i=1, #Status, 1 do
		if Status[i].name == name then
			cb(Status[i])
			return
		end
	end
end)

AddEventHandler('esx_status:setDisplay', function(val)
	SendNUIMessage({
		setDisplay = true,
		display    = val
	})
end)

-- Pause menu disable hud display
--[[
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(300)

		if IsPauseMenuActive() and not isPaused then
			isPaused = true
			TriggerEvent('esx_status:setDisplay', 0.0)
		elseif not IsPauseMenuActive() and isPaused then
			isPaused = false 
			TriggerEvent('esx_status:setDisplay', 0.5)
		end
	end
end)
]]
-- Loaded event
Citizen.CreateThread(function()
	TriggerEvent('esx_status:loaded')
end)

-- Update server
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(Config.UpdateInterval)
		
		TriggerServerEvent('esx_status:update', GetStatusData(true), true)
	end
end)

-- local Ped = {
-- 	Active = false,
-- 	Id = 0,
-- 	Alive = false,
-- 	Available = false,
-- 	Visible = false,
-- 	InVehicle = false,
-- 	OnFoot = false,
-- 	Vehicle = nil,
-- 	VehicleClass = nil,
-- 	VehicleStopped = true,
-- 	VehicleEngine = false,
-- 	VehicleCurrentGear = nil,
-- 	VehicleHighGear = nil,
-- 	Ped = nil,
-- 	Coords = nil,
-- 	Zone = nil,
-- 	Direction = nil,
-- 	StreetLabel = {},
-- 	CurrentTimeHours = nil,
-- 	CurrentTimeMinutes = nil,
-- 	ShowGears = false,
-- 	currentFuel = nil,
-- 	Health = 0,
-- 	Armor = 0,
-- 	Stamina = 0,
-- 	Underwater = false,
-- 	UnderwaterTime = 0,
-- 	Driver = false,
-- 	PhoneVisible = false,
-- }
-- local PlayerData = {}
-- local GUI = {}
-- local Status = true

-- ESX = nil
-- GUI.Time = 0

-- Citizen.CreateThread(function()
-- 	while ESX == nil do
-- 		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
-- 		Citizen.Wait(0)
-- 	end

-- 	Citizen.Wait(5000)
-- 	PlayerData = ESX.GetPlayerData()
-- end)

-- local idplayer = GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1)))

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(300)
-- 		Ped.Id = PlayerPedId()
-- 		Ped.RealId = PlayerId()
-- 		Ped.Active = true
-- 		Ped.Ped = GetPlayerPed(-1)
-- 		if not IsEntityDead(Ped.Id) then
-- 			Ped.Alive = true
-- 			Ped.Available = (Ped.Alive)
-- 			Ped.Visible = IsEntityVisible(Ped.Id)
-- 			Ped.OnFoot = IsPedOnFoot(Ped.Id)
-- 			Ped.Coords = GetEntityCoords(Ped.Ped)
-- 			Ped.PhoneVisible = exports['gcphone']:getMenuIsOpen()
-- 		else
-- 			Ped.Alive = false
-- 			Ped.Available = false
-- 			Ped.Visible = IsEntityVisible(Ped.Id)
-- 			Ped.OnFoot = true
-- 			Ped.Collection = false
-- 			Ped.PhoneVisible = false
-- 		end
-- 		if Status then
-- 			if IsPedInAnyVehicle(Ped.Id, false) then
-- 				Ped.InVehicle = true
-- 				Ped.Vehicle = GetVehiclePedIsIn(Ped.Id, false)
-- 				Ped.VehicleClass = GetVehicleClass(Ped.Vehicle)
-- 				Ped.VehicleStopped = IsVehicleStopped(Ped.Vehicle)
-- 				Ped.VehicleEngine = GetIsVehicleEngineRunning(Ped.Vehicle)
-- 				Ped.VehicleCurrentGear = GetVehicleCurrentGear(Ped.Vehicle)
-- 				Ped.VehicleHighGear = GetVehicleHighGear(Ped.Vehicle)
-- 				Ped.Driver = GetPedInVehicleSeat(GetVehiclePedIsIn(Ped.Id, false), -1) == Ped.Id
-- 				Ped.Zone = GetNameOfZone(Ped.Coords.x, Ped.Coords.y, Ped.Coords.z)
-- 				for k, v in pairs(Config.Directions) do
-- 					Ped.Direction = GetEntityHeading(Ped.Id)
-- 					if math.abs(Ped.Direction - k) < 22.5 then
-- 						Ped.Direction = v
-- 						break
-- 					end
-- 				end
-- 				Ped.StreetLabel.zone = (Config.Zones[Ped.Zone:upper()] or Ped.Zone:upper())
-- 				Ped.StreetLabel.street = GetStreetsCustom(Ped.Coords)
-- 				Ped.StreetLabel.direction = (Ped.Direction or 'N')
-- 				Ped.CurrentTimeHours = GetClockHours()
-- 				if Ped.CurrentTimeHours <= 9 then
-- 					Ped.CurrentTimeHours = '0'..Ped.CurrentTimeHours
-- 				end
-- 				Ped.CurrentTimeMinutes = GetClockMinutes()
-- 				if Ped.CurrentTimeMinutes <= 9 then
-- 					Ped.CurrentTimeMinutes = '0'..Ped.CurrentTimeMinutes
-- 				end
-- 				Ped.ShowGears = true
-- 				if Ped.VehicleClass == 13 or Ped.VehicleClass == 14 or Ped.VehicleClass == 15 or Ped.VehicleClass == 16 then
-- 					Ped.ShowGears = false
-- 				end
-- 				Ped.currentFuel = math.ceil(65 * GetVehicleFuelLevel(Ped.Vehicle) / GetVehicleHandlingFloat(Ped.Vehicle,"CHandlingData","fPetrolTankVolume"))
-- 			else
-- 				Ped.Health = GetEntityHealth(Ped.Id)
-- 				Ped.Armor = GetPedArmour(Ped.Id)
-- 				Ped.Underwater = IsPedSwimmingUnderWater(Ped.Id)
-- 				Ped.Stamina = GetPlayerSprintStaminaRemaining(Ped.RealId)

-- 				Ped.UnderwaterTime = GetPlayerUnderwaterTimeRemaining(Ped.RealId)
-- 				if Ped.UnderwaterTime < 0.0 then
-- 					Ped.UnderwaterTime = 0.0
-- 				end
-- 				Ped.InVehicle = false
-- 				Ped.Vehicle = nil
-- 			end
-- 		else
-- 			Ped.Vehicle = nil
-- 		end
-- 	end
-- end)

-- function drawRct(x,y,width,height,r,g,b,a)
-- 	DrawRect(x + width/2, y + height/2, width, height, r, g, b, a)
-- end

-- function GetPedData()
-- 	return Ped
-- end
