ESX = nil
local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

isDead = false


AddEventHandler('playerSpawned', function(spawn)
	isDead = false
end)

AddEventHandler('esx:onPlayerDeath', function()
	isDead = true
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsControlJustReleased(0, Keys['F7']) and not isDead then
			local playerPed = PlayerPedId()    
			local isInVehicle = IsPedInAnyVehicle(playerPed, false) 
			if isInVehicle then  
				local vehicle = GetVehiclePedIsIn(playerPed, false) 
				
				if GetPedInVehicleSeat(vehicle, -1) == playerPed then
					openCarControl()
				end
			end
		end
		
		if (IsControlJustReleased(0, Keys['Y']) or IsDisabledControlJustReleased(0, Keys['Y'])) and not isDead then
			local playerPed = PlayerPedId()    
			local isInVehicle = IsPedInAnyVehicle(playerPed, false) 
			
			if isInVehicle then  
				local vehicle = GetVehiclePedIsIn(playerPed, false)
				
				if GetPedInVehicleSeat(vehicle, -1) == playerPed then
					toggleEngine()
				end
			end
        end

		if DoesEntityExist(PlayerPedId()) and IsPedInAnyVehicle(PlayerPedId(), false) and IsControlPressed(2, 75) and not isDead and not IsPauseMenuActive() then
			local ped = PlayerPedId()
			local engineWasRunning = GetIsVehicleEngineRunning(GetVehiclePedIsIn(ped, true))
			Citizen.Wait(1000)
			if DoesEntityExist(ped) and not IsPedInAnyVehicle(ped, false) and not isDead and not IsPauseMenuActive() then
				local veh = GetVehiclePedIsIn(ped, true)
				if (engineWasRunning) then
					SetVehicleEngineOn(veh, true, true, true)
				end
			end
		end
		
	end
end)

function openCarControl()

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'car_menu', {
		title	= 'Pojazd',
		align	= 'bottom-right',
		elements = {
			{label = 'Włącz / wyłącz silnik', value = 'engine'},
			{label = 'Otwórz / zamknij maskę', value = 'hood'},
			{label = 'Otwórz / zamknij bagażnik', value = 'trunk'},
			{label = 'Otwórz / zamknij drzwi', value = 'doors'},
			{label = 'Otwórz / zamknij okno', value = 'windows'},	
		}
	}, function(data, menu)
		local action = data.current.value

		if action == 'engine' then
			toggleEngine()
		elseif action == 'hood' then
			OpenDoor(4)
		elseif action == 'trunk' then
			OpenDoor(5)
		elseif action == 'doors' then
			menu.close()
			CarDoorsMenu()
		elseif action == 'windows' then
			menu.close()
			CarWindowsMenu()
		end
	end, function(data, menu)
		menu.close()
	end)
end

function CarDoorsMenu()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'car_doors_menu', {
		title	= 'Pojazd - drzwi',
		align	= 'bottom-right',
		elements = {
			{label = 'Zamknij wszystkie drzwi', value = 'close'},
			{label = 'Lewy przód', value = 0},
			{label = 'Prawy przód', value = 1},
			{label = 'Lewy tył', value = 2},
			{label = 'Prawy tył', value = 3},
		}
	}, function(data, menu)
		local action = data.current.value
		if data.current.value == 'close' then
			CloseDoors()
		elseif data.current.value > -1 and data.current.value < 4 then
			OpenDoor(data.current.value)
		end
	end, function(data, menu)
		menu.close()
		openCarControl()
	end)
end

function OpenDoor(id)
	local playerPed = PlayerPedId()    
	local isInVehicle = IsPedInAnyVehicle(playerPed, false) 
	if isInVehicle then  
		local vehicle = GetVehiclePedIsIn(playerPed, false) 
		
		if GetPedInVehicleSeat(vehicle, -1) == playerPed then
			if GetVehicleDoorAngleRatio(vehicle, id) > 0 then
				SetVehicleDoorShut(vehicle, id, false)
			else
				SetVehicleDoorOpen(vehicle, id, false, false)
			end
		end
	end
end

function CloseDoors()
	local playerPed = PlayerPedId()    
	local isInVehicle = IsPedInAnyVehicle(playerPed, false) 
	if isInVehicle then  
		local vehicle = GetVehiclePedIsIn(playerPed, false) 
		
		if GetPedInVehicleSeat(vehicle, -1) == playerPed then
			for i = 0, 6 do
				SetVehicleDoorShut(vehicle, i, false)
			end
		end
	end
end

function CarWindowsMenu()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'car_doors_menu', {
		title	= 'Pojazd - okna',
		align	= 'bottom-right',
		elements = {
			{label = 'Zamknij wszystkie okna', value = 'close'},
			{label = 'Lewy przód', value = 0},
			{label = 'Prawy przód', value = 1},
			{label = 'Lewy tył', value = 2},
			{label = 'Prawy tył', value = 3},
		}
	}, function(data, menu)
		local action = data.current.value
		if data.current.value == 'close' then
			CloseWindows()
		elseif data.current.value > -1 and data.current.value < 4 then
			OpenWindow(data.current.value)
		end
	end, function(data, menu)
		menu.close()
		openCarControl()
	end)
end

function OpenWindow(id)
	local playerPed = PlayerPedId()    
	local isInVehicle = IsPedInAnyVehicle(playerPed, false) 
	if isInVehicle then  
		local vehicle = GetVehiclePedIsIn(playerPed, false) 
		
		if GetPedInVehicleSeat(vehicle, -1) == playerPed then
			if IsVehicleWindowIntact(vehicle, id) then
				RollDownWindow(vehicle, id)
			else
				RollUpWindow(vehicle, id)
				
			end
		end
	end
end

function CloseWindows()
	local playerPed = PlayerPedId()    
	local isInVehicle = IsPedInAnyVehicle(playerPed, false) 
	if isInVehicle then  
		local vehicle = GetVehiclePedIsIn(playerPed, false) 
		
		for i = 0, 4 do
			RollUpWindow(vehicle, i)
		end
	end
end

function toggleEngine()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, -1) then
        SetVehicleEngineOn(vehicle, (not GetIsVehicleEngineRunning(vehicle)), false, true)
    end
end 