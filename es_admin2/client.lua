local group
local states = {}
states.frozen = false
states.frozenPos = nil

Citizen.CreateThread(function()
	while group == nil do 
		Citizen.Wait(1000)
	end
	while true do
		Wait(0)
		if group ~= "user" then
			if (IsControlJustPressed(1, 212)) then
				SetNuiFocus(true, true)
				SendNUIMessage({type = 'open', players = getPlayers()})
				TriggerEvent("pNotify:SendNotification", {text = '<font color=green>Otworzono</font> panel admina!', timeout=7000})
			end
		else
			Citizen.Wait(2000)
		end
	end
end)

RegisterNetEvent('es_admin:setGroup')
AddEventHandler('es_admin:setGroup', function(g)
	group = g
end)

RegisterNUICallback('close', function(data, cb)
	SetNuiFocus(false)
	TriggerEvent("pNotify:SendNotification", {text = '<font color=red>Zamknięto</font> panel admina!', timeout=7000})
end)

RegisterNUICallback('quick', function(data, cb)
	if data.type == "slay_all" or data.type == "bring_all" or data.type == "slap_all" then
		TriggerServerEvent('es_admin:all', data.type)
	else
		TriggerServerEvent('es_admin:quick', data.id, data.type)
	end
end)

RegisterNUICallback('set', function(data, cb)
	TriggerServerEvent('es_admin:set', data.type, data.user, data.param)
	TriggerEvent("pNotify:SendNotification", {text = '<font color=green>Sukces!</font> Pomyślnie zmieniono atrybut!', timeout=7000})
end)

local noclip = false
RegisterNetEvent('es_admin:quick')
AddEventHandler('es_admin:quick', function(t, target)
	if t == "slay" then SetEntityHealth(PlayerPedId(), 0) end
	if t == "goto" then SetEntityCoords(PlayerPedId(), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target)))) 
		TriggerEvent("pNotify:SendNotification", {text = '<font color=green>Sukces!</font> Pomyślnie teleportowałeś się do innego gracza!', timeout=7000})
	end
	if t == "bring" then 
		states.frozenPos = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target)))
		SetEntityCoords(PlayerPedId(), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target)))) 
		TriggerEvent("pNotify:SendNotification", {text = '<font color=green>Sukces!</font> Przeteleportowałeś do siebie innego gracza!', timeout=7000})
	end
	if t == "crash" then 
		Citizen.Trace("Fivem Error\n")
		Citizen.CreateThread(function()
			while true do end
		TriggerEvent("pNotify:SendNotification", {text = '<font color=green>Sukces!</font> Scrashowałeś innego gracza!', timeout=7000})
		end) 
	end
	if t == "slap" then ApplyForceToEntity(PlayerPedId(), 1, 9500.0, 3.0, 7100.0, 1.0, 0.0, 0.0, 1, false, true, false, false) end
	if t == "noclip" then
        	local msg = "<font color=red>WYLACZONY</font>"
      		if(noclip == false)then
            		noclip_pos = GetEntityCoords(GetPlayerPed(-1), false)
      		end

     	        noclip = not noclip

       		 if(noclip)then
            		msg = "<font color=green>WLACZONY</font>"
        	 end
        TriggerEvent("pNotify:SendNotification", {text = 'Noclip został:   ' .. msg, timeout=7000})	end
	if t == "freeze" then
		local player = PlayerId()

		local ped = GetPlayerPed(-1)

		states.frozen = not states.frozen
		states.frozenPos = GetEntityCoords(ped, false)

		TriggerEvent("pNotify:SendNotification", {text = '<font color=green>Sukces!</font> Zamroziłeś/odmroziłeś innego gracza!', timeout=7000})
		if not state then
			if not IsEntityVisible(ped) then
				SetEntityVisible(ped, true)
			end

			if not IsPedInAnyVehicle(ped) then
				SetEntityCollision(ped, true)
			end

			FreezeEntityPosition(ped, false)
			--SetCharNeverTargetted(ped, false)
			SetPlayerInvincible(player, false)
		else
			SetEntityCollision(ped, false)
			FreezeEntityPosition(ped, true)
			--SetCharNeverTargetted(ped, true)
			SetPlayerInvincible(player, true)
			--RemovePtfxFromPed(ped)

			if not IsPedFatallyInjured(ped) then
				ClearPedTasksImmediately(ped)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if(states.frozen)then
			ClearPedTasksImmediately(GetPlayerPed(-1))
			SetEntityCoords(GetPlayerPed(-1), states.frozenPos)
		else
			Citizen.Wait(500)
		end
	end
end)

local heading = 0

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if(noclip)then
			SetEntityCoordsNoOffset(GetPlayerPed(-1),  noclip_pos.x,  noclip_pos.y,  noclip_pos.z,  0, 0, 0)

			if(IsControlPressed(1,  34))then
				heading = heading + 1.5
				if(heading > 360)then
					heading = 0
				end
				SetEntityHeading(GetPlayerPed(-1),  heading)
			end
			if(IsControlPressed(1,  9))then
				heading = heading - 1.5
				if(heading < 0)then
					heading = 360
				end
				SetEntityHeading(GetPlayerPed(-1),  heading)
			end
			if(IsControlPressed(1,  8))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 1.0, 0.0)
			end
			if(IsControlPressed(1,  32))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, -1.0, 0.0)
			end

			if(IsControlPressed(1,  27))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 0.0, 1.0)
			end
			if(IsControlPressed(1,  173))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 0.0, -1.0)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('es_admin:spawnVehicle')
AddEventHandler('es_admin:spawnVehicle', function(v)
	local carid = GetHashKey(v)
	local playerPed = GetPlayerPed(-1)
	if playerPed and playerPed ~= -1 then
		RequestModel(carid)
		while not HasModelLoaded(carid) do
				Citizen.Wait(0)
		end
		local playerCoords = GetEntityCoords(playerPed)

		veh = CreateVehicle(carid, playerCoords, 0.0, true, false)
		SetVehicleAsNoLongerNeeded(veh)
		TaskWarpPedIntoVehicle(playerPed, veh, -1)
	end
end)

RegisterNetEvent('es_admin:freezePlayer')
AddEventHandler("es_admin:freezePlayer", function(state)
	local player = PlayerId()

	local ped = GetPlayerPed(-1)

	states.frozen = state
	states.frozenPos = GetEntityCoords(ped, false)

	if not state then
		if not IsEntityVisible(ped) then
			SetEntityVisible(ped, true)
		end

		if not IsPedInAnyVehicle(ped) then
			SetEntityCollision(ped, true)
		end

		FreezeEntityPosition(ped, false)
		--SetCharNeverTargetted(ped, false)
		SetPlayerInvincible(player, false)
	else
		SetEntityCollision(ped, false)
		FreezeEntityPosition(ped, true)
		--SetCharNeverTargetted(ped, true)
		SetPlayerInvincible(player, true)
		--RemovePtfxFromPed(ped)

		if not IsPedFatallyInjured(ped) then
			ClearPedTasksImmediately(ped)
		end
	end
end)

RegisterNetEvent('es_admin:teleportUser')
AddEventHandler('es_admin:teleportUser', function(x, y, z)
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
	states.frozenPos = {x = x, y = y, z = z}
end)

RegisterNetEvent('es_admin:slap')
AddEventHandler('es_admin:slap', function()
	local ped = GetPlayerPed(-1)
	TriggerEvent("pNotify:SendNotification", {text = '<font color=red>Uderzono</font> innego gracza!', timeout=5000})

	ApplyForceToEntity(ped, 1, 9500.0, 3.0, 7100.0, 1.0, 0.0, 0.0, 1, false, true, false, false)
end)

RegisterNetEvent('es_admin:givePosition')
AddEventHandler('es_admin:givePosition', function()
	local pos = GetEntityCoords(GetPlayerPed(-1))
	local string = "{ ['x'] = " .. pos.x .. ", ['y'] = " .. pos.y .. ", ['z'] = " .. pos.z .. " },\n"
	TriggerServerEvent('es_admin:givePos', string)
	TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, 'Position saved to file.')
end)

RegisterNetEvent('es_admin:kill')
AddEventHandler('es_admin:kill', function()
	SetEntityHealth(GetPlayerPed(-1), 0)
	TriggerEvent("pNotify:SendNotification", {text = '<font color=red>Zabito</font> innego gracza!', timeout=5000})
end)

RegisterNetEvent('es_admin:vanishon')
AddEventHandler('es_admin:vanishon', function()
	SetEntityVisible(GetPlayerPed(-1), false)
	TriggerEvent("pNotify:SendNotification", {text = '<font color=green>Włączono</font> tryb niewidzialności!', timeout=7000})
end)

RegisterNetEvent('es_admin:vanishoff')
AddEventHandler('es_admin:vanishoff', function()
	SetEntityVisible(GetPlayerPed(-1), true)
	TriggerEvent("pNotify:SendNotification", {text = '<font color=red>Wyłączono</font> tryb niewidzialności!', timeout=7000})
end)

RegisterNetEvent('es_admin:heal')
AddEventHandler('es_admin:heal', function()
	SetEntityHealth(GetPlayerPed(-1), 200)
	TriggerEvent("pNotify:SendNotification", {text = '<font color=green>Uleczono</font> innego gracza!', timeout=7000})
end)

RegisterNetEvent('es_admin:crash')
AddEventHandler('es_admin:crash', function()
	while true do
	TriggerEvent("pNotify:SendNotification", {text = '<font color=green>Sukces!</font> Scrashowałeś innego gracza!', timeout=7000})
	end
end)

RegisterNetEvent("es_admin:noclip")
AddEventHandler("es_admin:noclip", function(t)
    local msg = "<font color=red>WYLACZONY</font>"
    if(noclip == false)then
        noclip_pos = GetEntityCoords(GetPlayerPed(-1), false)
    end

    noclip = not noclip

    if(noclip)then
        msg = "<font color=green>WLACZONY</font>"
    end

    TriggerEvent("pNotify:SendNotification", {text = 'Noclip został:   ' .. msg, timeout=7000})
end)

function getPlayers()
	local players = {}
	for i = 0,255 do
		if NetworkIsPlayerActive(i) then
			table.insert(players, {id = GetPlayerServerId(i), name = GetPlayerName(i)})
		end
	end
	return players
end