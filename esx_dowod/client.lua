-----------------------------------------------------
-------- Skrypt napisany przez elfeedoo#6029 --------
-----------------------------------------------------
ESX                           = nil
local PlayerData                = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(1)
	end

	PlayerData = ESX.GetPlayerData()
end)



function ShowAdvancedNotification(title, subject, msg, icon, iconType)


	SetNotificationTextEntry('STRING')
    SetNotificationBackgroundColor(200)
	AddTextComponentString(msg)
	SetNotificationMessage(icon, icon, false, iconType, title, subject)
	DrawNotification(false, false)
	UnregisterPedheadshot(headshot)

end
RegisterNetEvent('esx:dowod_pokazdowod')
AddEventHandler('esx:dowod_pokazdowod', function(id, imie, data, dodatek, ubezpieczenie, character, phonenumber, sex, jobName, jobLabel, jobGrade, fakeJob)


local job = PlayerData.job.label

  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
	if pid ~= -1 then  
		local mugshot, mugshotStr = ESX.Game.GetPedMugshot(GetPlayerPed(pid))
		if pid == myId then
		ShowAdvancedNotification(imie, data, dodatek, mugshotStr, 8)
		TriggerEvent('chatMessage',"^*Obywatel["  .. id .. "] Wyciąga Dowod Osobisty: " .. imie, {255, 152, 247})

		elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
		ShowAdvancedNotification(imie, data, dodatek, mugshotStr, 8)
		TriggerEvent('chatMessage',"^*Obywatel["  .. id .. "] Wyciąga Dowod Osobisty: " .. imie, {255, 152, 247})
		Citizen.Wait(15000)
		RemoveNotification(n)

		end

		UnregisterPedheadshot(mugshot)
	end

end)

RegisterNetEvent('esx:dowod_wiz')
AddEventHandler('esx:dowod_wiz', function(id, imie, data, dodatek, numer)


local job = PlayerData.job.label

local myId = PlayerId()
local pid = GetPlayerFromServerId(id)
	if pid ~= -1 then
		local mugshot, mugshotStr = ESX.Game.GetPedMugshot(GetPlayerPed(pid))
		if pid == myId then
		ShowAdvancedNotification(imie, data, dodatek, mugshotStr, 8)
		TriggerEvent('chatMessage',"^*Obywatel["  .. id .. "] Wyciąga Wizytówkę: " .. imie ..' | tel. '..numer, {255, 152, 247})

		elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
		ShowAdvancedNotification(imie, data, dodatek, mugshotStr, 8)
		TriggerEvent('chatMessage',"^*Obywatel["  .. id .. "] Wyciąga Wizytówkę: " .. imie ..' | tel. '..numer, {255, 152, 247})
		Citizen.Wait(15000)
		RemoveNotification(n)

		end

		UnregisterPedheadshot(mugshot)
	end
end)

RegisterCommand("dowod", function(source)
	while true do
		Citizen.Wait(5000)
		TriggerServerEvent('esx_dowod:dajitem', GetPlayerPed(-1))
		TriggerServerEvent('esx_dowod:dajwiz', GetPlayerPed(-1))
		lastGameTimerId = GetGameTimer() + 15000
		
			 end
		end)
RegisterNetEvent('esx_dowod:sendProximityMessagePhone')
AddEventHandler('esx_dowod:sendProximityMessagePhone', function(id, character, name, phonenumber, sex, jobName, jobLabel, jobGrade, fakeJob)
	local playerId = GetPlayerFromServerId(id)

	local playerPed = GetPlayerPed(playerId)
	if playerId ~= PlayerId() then
		if #(GetEntityCoords(PlayerPedId(), true) - GetEntityCoords(playerPed, true)) > 3.0 then
			return
		end
	end

	Citizen.CreateThread(function()
		local headshot = RegisterPedheadshot(playerPed)
		while not IsPedheadshotReady(headshot) do
			Citizen.Wait(0)
		end

		headshot = GetPedheadshotTxdString(headshot)
		SetNotificationTextEntry("STRING")
		AddTextComponentString("~o~Numer telefonu~w~: " .. phonenumber)

		if (not fakeJob or fakeJob:len() == 0) and jobName:len() > 0 then
			if jobName == 'sindicate' or jobName:find("org_") ~= nil then
				fakeJob = "Bezrobocie"
			elseif jobName == "police" then
				fakeJob = "LSPD - poza służbą"
			elseif jobName == "offambulance" then
				fakeJob = "EMS - poza służbą"
			elseif jobName == "offmecano" then
				fakeJob = "Mechanik - poza służbą"
			else
				fakeJob = jobLabel
			end
		end

		Citizen.InvokeNative(0x92F0DA1E27DB96DC, sex == 1 and 150 or 200)
		SetNotificationMessage(headshot, headshot, false, 8, name, '~y~' .. fakeJob)

		local n = DrawNotification(false, false)
		UnregisterPedheadshot(headshot)
		Citizen.Wait(15000)
		RemoveNotification(n)
	end)
end)

-----------------------------------------------------
-------- Skrypt napisany przez elfeedoo#6029 --------
-----------------------------------------------------