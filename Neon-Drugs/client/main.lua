local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["F"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
print("essadsa")
print("essadsa")
print("essadsa")
local PlayerData                = {}
ESX = nil
local isActionFailed = false
local x, y, z = nil
local playerHasDrugs = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
	Citizen.Wait(1000)
	if Config.Narko ~= nil then
	print('[Neon-Drugs] - Downloaded coords')
	end
	if PlayerData.job.name ~= 'police' or PlayerData.job.name ~= 'offpolice' or PlayerData.job.name ~= 'ambulance' or PlayerData.job.name ~= 'offambulance' then
	print('[Neon-Drugs] - Displaying markers')
	else
	print('[Neon-Drugs] - Markers are invisible for job: '..PlayerData.job.name..'')
	end
end)

-- ########################################
-- -----------  Zbiórka  ------------------
-- ########################################

Citizen.CreateThread(function()
    while true do
	   Citizen.Wait(5)
	   local letsleep = true
	   for location, val in pairs(Config.Narko) do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		local plyCoords = GetEntityCoords(PlayerPedId())
				local Exit = val['opium1']
				if GetDistanceBetweenCoords(plyCoords, Exit['x'], Exit['y'], Exit['z'], true) <= 20 then
					letsleep = false
					if PlayerData.job.name == 'police' or PlayerData.job.name == 'offpolice' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'offambulance' then
						return
					else
					DrawM(Exit['x'], Exit['y'], Exit['z'])
				if GetDistanceBetweenCoords(plyCoords, Exit['x'], Exit['y'], Exit['z'], true) <= 3 then
					TriggerEvent('mozezbierac')
						if IsPedInAnyVehicle(PlayerPedId(), true) then
						ESX.ShowNotification(_U('autko'))
						else 
						if IsControlEnabled(0, 38) then
							if IsControlJustReleased(0, 38) then
						Wait(5000)
						animkanarko()
						TriggerServerEvent('iluka:opiumzboirka')
						if IsControlJustReleased(0, 73) then
						DisableControlAction(0, 38,   true)
					end
				end
				end
				end
				end
			end	
		end
	end
	if letsleep then
		Citizen.Wait(1500)
	end
	end
	Wait(3000)
end)

Citizen.CreateThread(function()
    while true do
	   Citizen.Wait(5)
	   local letsleep = true
	   for location, val in pairs(Config.Narko) do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		local plyCoords = GetEntityCoords(PlayerPedId())
				local Exit = val['meta1']
				if GetDistanceBetweenCoords(plyCoords, Exit['x'], Exit['y'], Exit['z'], true) <= 20 then
					letsleep = false
					if PlayerData.job.name == 'police' or PlayerData.job.name == 'offpolice' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'offambulance' then
						return
					else
					DrawM(Exit['x'], Exit['y'], Exit['z'])
				if GetDistanceBetweenCoords(plyCoords, Exit['x'], Exit['y'], Exit['z'], true) <= 3 then
					TriggerEvent('mozezbierac')
						if IsPedInAnyVehicle(PlayerPedId(), true) then
						ESX.ShowNotification(_U('autko'))
						else 
						if IsControlEnabled(0, 38) then
							if IsControlJustReleased(0, 38) then
						Wait(5000)
						animkanarko()
						if IsControlJustReleased(0, 73) then
						DisableControlAction(0, 38,   true)
						ClearPedTasksImmediately()
                        ClearPedTasks()
				        ClearPedSecondaryTask()
						return
					else
						TriggerServerEvent('iluka:metazboirka')
					end
				end
				end
				end
				end
			end	
		end

	end
	if letsleep then
		Citizen.Wait(1500)
	end
	end
	Wait(3000)
end)

Citizen.CreateThread(function()
    while true do
	   Citizen.Wait(5)
	   local letsleep = true
	   for location, val in pairs(Config.Narko) do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		local plyCoords = GetEntityCoords(PlayerPedId())
				local Exit = val['koka1']
				if GetDistanceBetweenCoords(plyCoords, Exit['x'], Exit['y'], Exit['z'], true) <= 20 then
					letsleep = false
					if PlayerData.job.name == 'police' or PlayerData.job.name == 'offpolice' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'offambulance' then
						return
					else
					DrawM(Exit['x'], Exit['y'], Exit['z'])
				if GetDistanceBetweenCoords(plyCoords, Exit['x'], Exit['y'], Exit['z'], true) <= 3 then
					TriggerEvent('mozezbierac')
						if IsPedInAnyVehicle(PlayerPedId(), true) then
						ESX.ShowNotification(_U('autko'))
						else 
						if IsControlEnabled(0, 38) then
							if IsControlJustReleased(0, 38) then
						Wait(5000)
						animkanarko()
						TriggerServerEvent('iluka:kokazboirka')
						if IsControlJustReleased(0, 73) then
						DisableControlAction(0, 38,   true)
					end
				end
				end
				end
				end
			end	
		end
	end
	if letsleep then
		Citizen.Wait(1500)
	end
	end
	Wait(3000)
end)

Citizen.CreateThread(function()
    while true do
	   Citizen.Wait(5)
	   local letsleep = true
	   for location, val in pairs(Config.Narko) do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		local plyCoords = GetEntityCoords(PlayerPedId())
				local Exit = val['hera1']
				if GetDistanceBetweenCoords(plyCoords, Exit['x'], Exit['y'], Exit['z'], true) <= 20 then
					letsleep = false
					if PlayerData.job.name == 'police' or PlayerData.job.name == 'offpolice' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'offambulance' then
						return
					else
					DrawM(Exit['x'], Exit['y'], Exit['z'])
				if GetDistanceBetweenCoords(plyCoords, Exit['x'], Exit['y'], Exit['z'], true) <= 3 then
					TriggerEvent('mozezbierac')
						if IsPedInAnyVehicle(PlayerPedId(), true) then
						ESX.ShowNotification(_U('autko'))
						else 
						if IsControlEnabled(0, 38) then
							if IsControlJustReleased(0, 38) then
						Wait(5000)
						animkanarko()
						if IsControlJustReleased(0, 73) then
						DisableControlAction(0, 38,   true)
						ClearPedTasksImmediately()
                        ClearPedTasks()
				        ClearPedSecondaryTask()
						return
					else
						TriggerServerEvent('iluka:herazboirka')
				end
				end
				end
			end
			end
			end	
		end
		end
		if letsleep then
		Citizen.Wait(1500)
		end
	end
	Wait(3000)
end)

Citizen.CreateThread(function()
    while true do
	   Citizen.Wait(5)
	   local letsleep = true
	   for location, val in pairs(Config.Narko) do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		local plyCoords = GetEntityCoords(PlayerPedId())
				local Exit = val['maryha1']
				if GetDistanceBetweenCoords(plyCoords, Exit['x'], Exit['y'], Exit['z'], true) <= 20 then
					letsleep = false
					if PlayerData.job.name == 'police' or PlayerData.job.name == 'offpolice' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'offambulance' then
						return
					else
					DrawM(Exit['x'], Exit['y'], Exit['z'])
				if GetDistanceBetweenCoords(plyCoords, Exit['x'], Exit['y'], Exit['z'], true) <= 3 then
					TriggerEvent('mozezbierac')
						if IsPedInAnyVehicle(PlayerPedId(), true) then
						ESX.ShowNotification(_U('autko'))
						else 
						if IsControlEnabled(0, 38) then
							if IsControlJustReleased(0, 38) then
						Wait(5000)
						animkanarko()
						if IsControlJustReleased(0, 73) then
						DisableControlAction(0, 38,   true)
						ClearPedTasksImmediately()
                        ClearPedTasks()
				        ClearPedSecondaryTask()
						return
					else
						TriggerServerEvent('iluka:maryhazboirka')
				end
				end
				end
			end
			end
			end	
		end
		end
		if letsleep then
		Citizen.Wait(1500)
		end
	end
	Wait(3000)
end)



-- ########################################
-- ----------- Przerobki ------------------
-- ########################################

CreateThread(function ()
	RegisterNetEvent('iluka:config')
	AddEventHandler('iluka:config', function(cossa)
		Config.Narko = cossa
	
	end)
	
		while ESX == nil do
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
			Citizen.Wait(1)
		end
	
		while ESX.GetPlayerData() == nil do
			Citizen.Wait(10)
		end
	
		PlayerData = ESX.GetPlayerData()
	
	end) 
function animkanarko()
				local pid = PlayerPedId()
				local player = GetPlayerPed(-1)		
				local playerloc = GetEntityCoords(player, 0)	

				local a = 'amb@world_human_gardener_plant@male@exit'
				local b = 'exit'
				RequestAnimDict(a)
				while (not HasAnimDictLoaded(a)) do 
					Citizen.Wait(0) 
				end
				TaskPlayAnim(PlayerPedId(),a,b,8.0, -8.0, -1, 0, 0, false, false, false)
				Wait(1500)
				ClearPedTasksImmediately()
                ClearPedTasks()
				ClearPedSecondaryTask()
end



Citizen.CreateThread(function()
    while true do
	   Citizen.Wait(5)
	   local letsleep = true
	   for location, val in pairs(Config.Narko) do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		local plyCoords = GetEntityCoords(PlayerPedId())
				local Exit = val['opium2']
				if GetDistanceBetweenCoords(plyCoords, Exit['x'], Exit['y'], Exit['z'], true) <= 20 then
					letsleep = false
					if PlayerData.job.name == 'police' or PlayerData.job.name == 'offpolice' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'offambulance' then
						return
					else
					DrawM(Exit['x'], Exit['y'], Exit['z'])
				if GetDistanceBetweenCoords(plyCoords, Exit['x'], Exit['y'], Exit['z'], true) <= 3 then
					TriggerServerEvent('checkes')
						if IsPedInAnyVehicle(PlayerPedId(), true) then
						ESX.ShowNotification(_U('autko'))
						else 
					if playerHasDrugs and not isActionFailed then 
						if IsControlEnabled(0, 38) then
						if IsControlJustReleased(0, 38) then
						Wait(5000)
						animkanarko()
						TriggerServerEvent('iluka:opiumprzerobka')
					end
				end
				end
				end
			end	
		end
		end
	end
	if letsleep then
		Citizen.Wait(1500)
	end
	end
	Wait(3000)
end)


Citizen.CreateThread(function()
    while true do
	   Citizen.Wait(5)
	   local letsleep = true
	   for location, val in pairs(Config.Narko) do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		local plyCoords = GetEntityCoords(PlayerPedId())
				local Exit = val['meta2']
				if GetDistanceBetweenCoords(plyCoords, Exit['x'], Exit['y'], Exit['z'], true) <= 20 then
					letsleep = false
					if PlayerData.job.name == 'police' or PlayerData.job.name == 'offpolice' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'offambulance' then
						return
					else
					DrawM(Exit['x'], Exit['y'], Exit['z'])
				if GetDistanceBetweenCoords(plyCoords, Exit['x'], Exit['y'], Exit['z'], true) <= 3 then
					TriggerServerEvent('checkes')
						if IsPedInAnyVehicle(PlayerPedId(), true) then
						ESX.ShowNotification(_U('autko'))
						else 
					if playerHasDrugs and not isActionFailed then 
						if IsControlEnabled(0, 38) then
						if IsControlJustReleased(0, 38) then
						Wait(5000)
						animkanarko()
						TriggerServerEvent('iluka:metaprzerobka')
					end
				end
				end
				end
			end	
		end
		end
	end
	if letsleep then
		Citizen.Wait(1500)
	end
	end
	Wait(3000)
end)

Citizen.CreateThread(function()
    while true do
	   Citizen.Wait(5)
	   local letsleep = true
	   for location, val in pairs(Config.Narko) do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		local plyCoords = GetEntityCoords(PlayerPedId())
				local Exit = val['koka2']
				if GetDistanceBetweenCoords(plyCoords, Exit['x'], Exit['y'], Exit['z'], true) <= 20 then
					letsleep = false
					if PlayerData.job.name == 'police' or PlayerData.job.name == 'offpolice' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'offambulance' then
						return
					else
					DrawM(Exit['x'], Exit['y'], Exit['z'])
				if GetDistanceBetweenCoords(plyCoords, Exit['x'], Exit['y'], Exit['z'], true) <= 3 then
					TriggerServerEvent('checkes')
						if IsPedInAnyVehicle(PlayerPedId(), true) then
						ESX.ShowNotification(_U('autko'))
						else 
					if playerHasDrugs and not isActionFailed then 
						if IsControlEnabled(0, 38) then
						if IsControlJustReleased(0, 38) then
						Wait(5000)
						animkanarko()
						TriggerServerEvent('iluka:kokaprzerobka')
					end
				end
				end
				end
			end	
		end
		end
	end
	if letsleep then
		Citizen.Wait(1500)
	end
	end
	Wait(3000)
end)

Citizen.CreateThread(function()
    while true do
	   Citizen.Wait(5)
	   local letsleep = true
	   for location, val in pairs(Config.Narko) do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		local plyCoords = GetEntityCoords(PlayerPedId())
				local Exit = val['hera2']
				if GetDistanceBetweenCoords(plyCoords, Exit['x'], Exit['y'], Exit['z'], true) <= 20 then
					letsleep = false
					if PlayerData.job.name == 'police' or PlayerData.job.name == 'offpolice' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'offambulance' then
						return
					else
					DrawM(Exit['x'], Exit['y'], Exit['z'])
				if GetDistanceBetweenCoords(plyCoords, Exit['x'], Exit['y'], Exit['z'], true) <= 3 then
					TriggerServerEvent('checkes')
						if IsPedInAnyVehicle(PlayerPedId(), true) then
						ESX.ShowNotification(_U('autko'))
						else 
					if playerHasDrugs and not isActionFailed then 
						if IsControlEnabled(0, 38) then
						if IsControlJustReleased(0, 38) then
						Wait(5000)
						animkanarko()
						TriggerServerEvent('iluka:heraprzerobka')
					end
				end
				end
				end
			end	
		end
		end
	end
	if letsleep then
		Citizen.Wait(1500)
	end
	end
	Wait(3000)
end)

Citizen.CreateThread(function()
    while true do
	   Citizen.Wait(5)
	   local letsleep = true
	   for location, val in pairs(Config.Narko) do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		local plyCoords = GetEntityCoords(PlayerPedId())
				local Exit = val['maryha2']
				if GetDistanceBetweenCoords(plyCoords, Exit['x'], Exit['y'], Exit['z'], true) <= 20 then
					letsleep = false
					if PlayerData.job.name == 'police' or PlayerData.job.name == 'offpolice' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'offambulance' then
						return
					else
					DrawM(Exit['x'], Exit['y'], Exit['z'])
				if GetDistanceBetweenCoords(plyCoords, Exit['x'], Exit['y'], Exit['z'], true) <= 3 then
					TriggerServerEvent('checkes')
						if IsPedInAnyVehicle(PlayerPedId(), true) then
						ESX.ShowNotification(_U('autko'))
						else 
					if playerHasDrugs and not isActionFailed then 
						if IsControlEnabled(0, 38) then
						if IsControlJustReleased(0, 38) then
						Wait(5000)
						animkanarko()
						TriggerServerEvent('iluka:maryhaprzerobka')
					end
				end
				end
				end
			end	
		end
		end
	end
	if letsleep then
		Citizen.Wait(1500)
	end
	end
	Wait(3000)
end)


RegisterNetEvent('manarko')
AddEventHandler('manarko', function()
	ESX.ShowHelpNotification(_U('essa123'))
	playerHasDrugs = true
end)

RegisterNetEvent('mozezbierac')
AddEventHandler('mozezbierac', function()
	ESX.ShowHelpNotification(_U('essa123222'))
	playerHasDrugs = true
end)

RegisterNetEvent('nima')
AddEventHandler('nima', function()
	ESX.ShowNotification(_U('nima'))
	playerHasDrugs = false
end)

function DrawM(x, y, z)
	DrawMarker(1, x, y, z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 5.1, 5.1, 1.5, 15, 52, 52, 92, false, true, 2, false, false, false, false)
end

--###### selldrugs ######

local PlayerData = {}
local InventoryData = {}
local ScriptData = {
	isSelling = false,
	timeLeft = 0,
	lspdCount = 0,
	hasDrugs = true,
	lastPed = nil,
	prop = nil,
	prop2 = nil,
	prop3 = nil
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	RequestAnimDict('misscarsteal4@actor')
	RequestAnimDict('mp_ped_interaction')
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)


RegisterNetEvent('neonrpselldrugs:photoMessage')
AddEventHandler('neonrpselldrugs:photoMessage', function(id)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
  	TriggerEvent('chatMessage',"^*Obywatel zrobił Ci zdjęcie!", {255, 152, 247})
  end
end)


Citizen.CreateThread(function()
	print('[Neon-Drugs] - Player loaded')
	while true do
		Citizen.Wait(5)
		if not IsJobBlocked() then
			if IsControlJustReleased(0, 51) then
				if not (ScriptData.isSelling) then
					local handle, _pedHandle = FindFirstPed()
					local success
					repeat
						success, _pedHandle = FindNextPed(handle)
						if DoesEntityExist(_pedHandle) and (ScriptData.lastPed ~= _pedHandle) then
							if not IsPedAPlayer(_pedHandle) then
								if not IsPedInAnyVehicle(_pedHandle, false) then            
									if not IsPedDeadOrDying(_pedHandle) then
										if GetPedType(_pedHandle) ~= 28 then
											if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(_pedHandle), true) < 0.8 then
												if (ScriptData.lastPed ~= _pedHandle) then
													local thisped = _pedHandle
													ScriptData.lspdCount = exports['esx_scoreboard']:counter('police')
													if (ScriptData.hasDrugs == true) and (ScriptData.lspdCount >= 1 ) then
														ESX.TriggerServerCallback('neonrpselldrugs:checkDrugs', function(cb)
															if cb == 1 then
																math.randomseed(math.random(0, 9999999999999))
																if (math.random(0, 100) >= 50) then
																	SellDrugs(thisped, ScriptData.lspdCount)
																else
																	FailSellDrugs(thisped)
																end
															elseif cb == 2 then
																ESX.ShowNotification('~r~Nie ma wystarczającej liczby policjantów na służbie')
																Citizen.Wait(5000)
															elseif cb == 3 then
																ESX.ShowNotification('~r~Nie masz przy sobie żadnych narkotyków')
																Citizen.Wait(5000)
															end
														end, exports['esx_scoreboard']:counter('police'))											
													else
														ESX.ShowNotification('~r~Nie ma wystarczającej liczby policjantów na służbie')
														Citizen.Wait(5000)
													end
												else
													Citizen.Wait(5000)
												end
											end
										end
									end
								end
							end
						end
					until not success
					EndFindPed(handle)
				else
					Citizen.Wait(500)
				end
			end
		else
			Citizen.Wait(500)
		end
	end
end)

IsJobBlocked = function()
	local found = false
	if PlayerData.job ~= nil then
		for i=1, #Config.BlockedJobs, 1 do
			if PlayerData.job.name == Config.BlockedJobs[i] then
				found = true
				break
			end
		end
	end
	return found
end

IsItemDrug = function(itemName)
	if PlayerData.job ~= nil then
		for i=1, #Config.AllowedDrugs, 1 do
			if itemName == Config.AllowedDrugs[i] then
				return true
			end
		end
	end
	return false
end

SellDrugs = function(targetPed, lspdCount)
	local playerPed = GetPlayerPed(-1)

	if ScriptData.isSelling then
		return
	end

	ScriptData.lastPed = targetPed

	SetEntityAsMissionEntity(targetPed, true, true)	
	SetEntityInFrontOfPlayer(ScriptData.lastPed, playerPed)

	FreezeEntityPosition(ScriptData.lastPed, true)
	FreezeEntityPosition(playerPed, true)

	SellAnim(playerPed, ScriptData.lastPed)

	-- Check if timer goes 0
	while ScriptData.timeLeft ~= 0 do
		if (ScriptData.isSelling == false and ScriptData.timeLeft == 0) then
			return
		end
		
		if ScriptData.timeLeft < 0 then
			ScriptData.timeLeft = 0
		end
		Citizen.Wait(50)
	end
	TriggerServerEvent('neonrpselldrugs:sell', lspdCount)
end

FailSellDrugs = function(targetPed)
	local playerPed = GetPlayerPed(-1)

	if ScriptData.isSelling then
		return
	end

	ScriptData.lastPed = targetPed

	SetEntityAsMissionEntity(targetPed, true, true)	
	SetEntityInFrontOfPlayer(ScriptData.lastPed, playerPed)

	FreezeEntityPosition(ScriptData.lastPed, true)
	FreezeEntityPosition(playerPed, true)

	SellAnim(playerPed, ScriptData.lastPed)
	while ScriptData.timeLeft ~= 0 do
		if (ScriptData.isSelling == false and ScriptData.timeLeft == 0) then
			return
		end
		if ScriptData.timeLeft < 0 then
			ScriptData.timeLeft = 0
		end
		Citizen.Wait(50)
	end
	
	ScriptData.lastPed = targetPed
	TriggerEvent('neonrpselldrugs:stopSell', 2)
end

SellAnim = function(localPed, targetPed)
	ScriptData.timeLeft = Config.TimeToSell
	ScriptData.isSelling = true
	PlayAnim('misscarsteal4@actor', 'assistant_berated', 10000, localPed)
	PlayAnim('misscarsteal4@actor', 'assistant_loop', 10000, targetPed)	
end

SetEntityInFrontOfPlayer = function(targetPed, playerPed)
	local playerPedCoords = GetEntityCoords(playerPed)
	local forward   = GetEntityForwardVector(playerPed)	
	local heading = GetEntityHeading(playerPed)
	local newheading = 0

	if(heading >= 180) then
		newheading = heading - 180.0
	else
		newheading = heading + 180.0
	end

	xDFF, yDFF, zDFF   = table.unpack(playerPedCoords + forward * 1.19)

	SetEntityCoords(targetPed, xDFF, yDFF, zDFF-1, false, false, false, false)
	SetEntityHeading(targetPed, newheading)
end

PlayAnim = function(ad, anim, dur, ped)
	local player = ped	

	if ScriptData.isSelling == true then
		TaskPlayAnim( player, ad, anim, 1.0, 1.0, dur, 0, 0.0, 0, 0, 0 )
	end
end

function faceNotification(title, subject, msg, playerID)
  local mugshot, mugshotStr = ESX.Game.GetPedMugshot(GetPlayerPed(GetPlayerFromServerId(playerID)))
  ESX.ShowAdvancedNotification(title, subject, msg, mugshotStr, 1)
  UnregisterPedheadshot(mugshot)
end

RegisterNetEvent('notifyc')
AddEventHandler('notifyc', function(sourceID)
	local title = "Centrala"
	local subject = "Anonim"
	local msg = "Osoba na zdjęciu chciała sprzedać mi narkotyki!"
	faceNotification(title,subject,msg,sourceID)
end)

RegisterNetEvent('neonrpselldrugs:stopSell')
AddEventHandler('neonrpselldrugs:stopSell', function(soldInt, soldString)
	local playerPed = GetPlayerPed(-1)
	local targetPed = ScriptData.lastPed

	ScriptData.isSelling = false
	ScriptData.timeLeft = 100
	ClearPedTasksImmediately(playerPed)
	ClearPedTasksImmediately(targetPed)
	Citizen.Wait(300)
	
	if soldInt == 1 then
		TaskPlayAnim(playerPed, 'mp_ped_interaction', 'handshake_guy_a', 8.0, -8.0, -1, 0, 0, false, false, false)
		TaskPlayAnim(targetPed, 'mp_ped_interaction', 'handshake_guy_a', 8.0, -8.0, -1, 0, 0, false, false, false)
		Citizen.Wait(1500)
	end

	FreezeEntityPosition(playerPed, false)
	FreezeEntityPosition(targetPed, false)
	ClearPedTasksImmediately(playerPed)
	ClearPedTasksImmediately(targetPed)

	DeleteObject(ScriptData.prop)
	DeleteObject(ScriptData.prop2)
	DeleteObject(ScriptData.prop3)

	SetEntityAsNoLongerNeeded(targetPed)
	
	if soldInt == 0 then
		ScriptData.timeLeft = 0
		ESX.ShowNotification('~b~Przerwano sprzedaż!')
	elseif soldInt == 1 then
		ESX.ShowNotification('~b~Sprzedałeś ' .. soldString)
	elseif soldInt == 2 then
		local notify = math.random(1,3)
		if notify == 1 then
			local coords = GetEntityCoords(playerPed)
			local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z))
			-- Zamień na funkcję na /do, która pojawi się na czacie
			TriggerEvent('neonrpselldrugs:photoMessage', GetPlayerServerId(PlayerId()))
			TriggerServerEvent('neonrpselldrugs:triggerDispatch', coords, street, true)
			ESX.ShowNotification('~b~Osoba nie jest zainteresowana')
		elseif notify == 2 then
			local coords = GetEntityCoords(playerPed)
			local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z))
			TriggerServerEvent('neonrpselldrugs:triggerDispatch', coords, street, false)
			ESX.ShowNotification('~b~Osoba nie jest zainteresowana')
		elseif notify == 3 then
			ESX.ShowNotification('~b~Osoba nie jest zainteresowana')
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)

		if ScriptData.isSelling then
			if ScriptData.timeLeft > 1 then
				ScriptData.timeLeft = (ScriptData.timeLeft-1)
				ESX.ShowNotification('~b~Trwa sprzedaż: ~o~'..ScriptData.timeLeft..'s')
			else
				ScriptData.timeLeft = 0
			end
		end
	end
end)

RegisterNetEvent('neonrpselldrugs:showNotify')
AddEventHandler('neonrpselldrugs:showNotify', function(pos, street, msg)
	if PlayerData.job ~= nil and (PlayerData.job.name == 'police') then
		--[[TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 0.5vw;  margin: 0.5vw; background-color: rgba(29, 9, 38, 0.7); color: white; border-radius: 3px;"><i class="fas fa-phone"style="font-size:15px;color:rgb(255,255,255,0.5)"> <font color="#FFFFFF">{0}</font>&ensp;<font color="white">{1}</font></div>',
			args = { "", msg}
		})]]
		TriggerEvent("chatMessage", '^0[^3Centrala^0]', { 0, 0, 0 }, msg)
	  
		local opacity = 250
		local blip = AddBlipForCoord(pos.x, pos.y, pos.z)

		SetBlipSprite(blip,  51)
		SetBlipColour(blip,  30)
		SetBlipAlpha(blip,  opacity)
		SetBlipAsShortRange(blip, false)
		SetBlipScale(blip, 0.8)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('# Narkotyki')
		EndTextCommandSetBlipName(blip)
		
		PlaySoundFrontend(-1, "HACKING_CLICK_GOOD", 0, 1)

		Citizen.Wait(60000)

		while opacity ~= 0 do
			Wait(30*4)
			opacity = opacity - 1

			SetBlipAlpha(blip, opacity)

			if opacity == 0 then
				RemoveBlip(blip)
				break
			end
		end		   
	end
end)