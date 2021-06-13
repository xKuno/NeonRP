ESX = nil
local ActiveBlips, ActiveZones, Timer, secondsRemaining, canTake, isDead, InZone, currentZone, playerPos = {}, {}, {}, {}, true, false, false, nil, nil

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()
end)

-- RegisterNetEvent('esx:setHiddenJob')
-- AddEventHandler('esx:setHiddenJob', function(hiddenjob)
--     PlayerData.hiddenjob = hiddenjob
-- end)

RegisterNetEvent('kaiser_mafia:setjobs')
AddEventHandler('kaiser_mafia:setjobs', function(job, job_grade)	
	PlayerData.hiddenjob = job
end)

CreateThread(function()
	while true do
		local playerPed = PlayerPedId()
		playerPos = GetEntityCoords(playerPed)
		Citizen.Wait(500)
	end
end)

CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/strefa', 'Uruchamia podaną strefe')
end)

RegisterNetEvent("neon_zones:zoneTaken")
AddEventHandler("neon_zones:zoneTaken", function(currentZone)
    ESX.ShowNotification("~g~Przejąłeś strefe, gratulacje!\n~w~Na konto twojej organizacji wpłynęło ~g~300 000$")
    TriggerServerEvent("neon_zones:zoneTakenServer", PlayerData.hiddenjob, PlayerData.hiddenjob, currentZone)
end)

RegisterNetEvent("neon_zones:CreateBlip")
AddEventHandler("neon_zones:CreateBlip", function(zone)
    for i=1, #Config.Strefy[zone].Jobs, 1 do
        if PlayerData.hiddenjob ~= nil then
            if PlayerData.hiddenjob == Config.Strefy[zone].Jobs[i] then
                blipZone = AddBlipForCoord(Config.Strefy[zone].coords)
                SetBlipSprite(blipZone, 148)
                SetBlipColour(blipZone, 59)
                SetBlipAlpha(blipZone, 50)
                SetBlipScale (blipZone, 2.5)
                SetBlipAsShortRange(blipZone, true)

                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(Config.Strefy[zone].label)
                EndTextCommandSetBlipName(blipZone)

                table.insert(ActiveBlips, {id = blipZone, zone = zone})
            end
        end
    end
end)

RegisterNetEvent("neon_zones:RemoveBlip")
AddEventHandler("neon_zones:RemoveBlip", function(currentZone)
    if ActiveBlips[1] ~= nil then
        for i=1, #ActiveBlips, 1 do
            if ActiveBlips[i].zone == currentZone then
                RemoveBlip(ActiveBlips[i].id)
                table.remove(ActiveBlips, i)
            end
        end
    end
end)

RegisterNetEvent("neon_zones:RemoveActiveZone")
AddEventHandler("neon_zones:RemoveActiveZone", function(currentZone, job_label, job)
    secondsRemaining[currentZone] = Config.secondsRemaining
    Timer[currentZone] = false
    if ActiveZones[1] ~= nil then
        for i=1, #ActiveZones, 1 do
            if ActiveZones[i].zone == currentZone then
                ActiveZones[i].active = false
                table.remove(ActiveZones, i)
            end
        end
    end
    for i=1, #Config.Strefy[currentZone].Jobs, 1 do
        if PlayerData.hiddenjob ~= nil then
            if PlayerData.hiddenjob == Config.Strefy[currentZone].Jobs[i] then
                ESX.ShowNotification("~r~ORGANIZACJA ~y~" .. job_label .. "~r~ PRZEJELA ~y~STREFE ~r~".. currentZone .. "!")
            end
        end
    end
    TriggerServerEvent('neon_zones:HoldZone', currentZone, false)
    --TriggerServerEvent('neon_zones:SaveZone', currentZone, job)
end)

RegisterNetEvent("neon_zones:startZone")
AddEventHandler("neon_zones:startZone", function(zone)
    table.insert(ActiveZones, {zone = zone, coords = Config.Strefy[zone].coords, active = true, jobs = Config.Strefy[zone].Jobs})

    for i=1, #Config.Strefy[zone].Jobs, 1 do
        if PlayerData.hiddenjob ~= nil then
            if PlayerData.hiddenjob == Config.Strefy[zone].Jobs[i] then
                ESX.ShowNotification("~r~STREFA " .. zone .. " RUSZYLA! ~y~KIERUJ SIE NA ~r~GPS.")
            end
        end
    end
end)

CreateThread(function()
    while PlayerData == nil do
        Citizen.Wait(3000)
    end
    while true do
        Citizen.Wait(3)
        for i=1, #ActiveZones, 1 do
            for j=1, #ActiveZones[i].jobs, 1 do
                if PlayerData.hiddenjob == ActiveZones[i].jobs[j] then
                    if ActiveZones[i].active then
                        if GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, ActiveZones[i].coords) < 30.0 then
                            DrawMarker(23, ActiveZones[i].coords.x, ActiveZones[i].coords.y, ActiveZones[i].coords.z - 0.9, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 10.0, 10.0, 10.0, 184, 86, 79, 100, false, true, 2, nil, nil, false)
                            if GetDistanceBetweenCoords(playerPos.x,playerPos.y,playerPos.z,ActiveZones[i].coords) < 4.0 then
                                if not isDead and not IsPedInAnyVehicle(PlayerPedId(), false) then
                                    ESX.ShowHelpNotification("Naciśnij ~INPUT_PICKUP~ aby rozpocząć ~r~przejmowanie strefy")
                                    if IsControlJustPressed(0, 38) then
                                        if not IsPedInAnyVehicle(PlayerPedId(), false) then
                                            currentZone = TakeZone(playerPos)
                                            secondsRemaining[currentZone] = Config.secondsRemaining
                                            ESX.TriggerServerCallback('neon_zones:CheckZone', function(hold)
                                                if not hold then
                                                    TriggerServerEvent('neon_zones:HoldZone', currentZone, true)
                                                    Timer[currentZone] = true
                                                    ESX.ShowNotification("~r~ZAPAMIĘTAJ! \n~w~Opuszczenie ~r~markera ~w~spowoduje ~r~anulowanie ~w~przejmowania strefy!")
                                                else
                                                ESX.ShowNotification("~r~Ktoś aktualnie przejmuje tą strefe!")
                                                end
                                        
                                            end, currentZone)
                                        else
                                            ESX.ShowNotification("~r~Nie możesz przejmować strefy będąc w aucie!")
                                        end
                                    end
                                end
                            end
                        end
                        if Timer[currentZone] then
                            if secondsRemaining[currentZone] <= Config.secondsRemaining and secondsRemaining[currentZone] >= 5 then
                                timeLeft = 'sekund'
                            elseif secondsRemaining[currentZone] <= 4 and secondsRemaining[currentZone] >= 2 then
                                timeLeft = 'sekundy'
                            else
                                timeLeft = 'sekunda'
                            end
                            if ActiveZones[i].zone == currentZone then
                                DrawText3D(Config.Strefy[currentZone].coords.x, Config.Strefy[currentZone].coords.y, Config.Strefy[currentZone].coords.z, "Przejmowanie... | Pozostało: ".. secondsRemaining[currentZone] ..' '..timeLeft)
                            end
                        end
                        if (isDead and Timer[currentZone]) or (Timer[currentZone] and IsPedInAnyVehicle(PlayerPedId(), false)) then
                            ESX.ShowNotification("~r~Anulowano przejmowanie strefy!")
                            TriggerServerEvent('neon_zones:HoldZone', currentZone, false)
                            Timer[currentZone] = false
                            secondsRemaining[currentZone] = Config.secondsRemaining
                            currentZone = nil
                        end
                    else
                        Citizen.Wait(200)
                    end
                end
            end
        end
    end
end)

CreateThread(function()
    while currentZone == nil do
        Citizen.Wait(500)
    end
    while true do
        Citizen.Wait(1000)
        for i=1, #ActiveZones, 1 do
            if ActiveZones[i].active then
                if Timer[currentZone] then
                    while secondsRemaining[currentZone] > 0 and not isDead do
                        Citizen.Wait(1000)
                        secondsRemaining[currentZone] = secondsRemaining[currentZone] - 1
                        if GetDistanceBetweenCoords(playerPos, Config.Strefy[currentZone].coords) > 4.0 then
                            ESX.ShowNotification("~r~Anulowano przejmowanie strefy!")
                            TriggerServerEvent('neon_zones:HoldZone', currentZone, false)
                            secondsRemaining[currentZone] = Config.secondsRemaining
                            Timer[currentZone] = false
                            currentZone = nil
                            break
                        end
                        if secondsRemaining[currentZone] <= 0 then
                            TriggerEvent('neon_zones:zoneTaken', currentZone)
                            break
                        end
                    end
                end
            end
        end
    end
end)


DrawText3D = function(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    local scale = 0.45

    if onScreen then
		SetTextScale(scale, scale)
		SetTextFont(8)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 370
        DrawRect(_x, _y + 0.0150, 0.150 + factor , 0.030, 219, 154, 154, 150)
    end
end

TakeZone = function(pCoords)
    if GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, Config.Strefy[1].coords) < 10.0 then
        return 1
    elseif GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, Config.Strefy[2].coords) < 10.0 then
        return 2
    elseif GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, Config.Strefy[3].coords) < 10.0 then
        return 3
    elseif GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, Config.Strefy[4].coords) < 10.0 then
        return 4
    elseif GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, Config.Strefy[5].coords) < 10.0 then
        return 5
    elseif GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, Config.Strefy[6].coords) < 10.0 then
        return 6
    elseif GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, Config.Strefy[7].coords) < 10.0 then
        return 7
    elseif GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, Config.Strefy[8].coords) < 10.0 then
        return 8
    end
end


AddEventHandler('esx:onPlayerDeath', function()
    isDead = true
end)

AddEventHandler('playerSpawned', function()
    isDead = false
end)