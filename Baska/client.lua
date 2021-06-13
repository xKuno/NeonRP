ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
    RequestModel(GetHashKey("s_m_m_doctor_01"))
	
    while not HasModelLoaded(GetHashKey("s_m_m_doctor_01")) do
        Wait(1)
    end
    
    local coords = Config.pos
	if Config.enablepeds then
		for _, item in pairs(coords) do
			local npc = CreatePed(4, 0xd47303ac, item.x, item.y, item.z, item.heading, false, true)
			
			SetEntityHeading(npc, item.heading)
			FreezeEntityPosition(npc, true)
			SetEntityInvincible(npc, true)
			SetBlockingOfNonTemporaryEvents(npc, true)
		end
	end
end)

function Draw3DText(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 68)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local letsleep = true
            if not IsPedInAnyVehicle(PlayerPedId(), true) then
                for i=1, #Config.pos, 1 do 
                    local player = GetPlayerPed(-1)

                    local pcords = GetEntityCoords(player, 0)
                    local coords2 = Config.pos[1]
                    local distance = GetDistanceBetweenCoords(coords2['x'], coords2['y'], coords2['z'], pcords['x'], pcords['y'], pcords['z'], true)
                    if distance <= 3 then
                        letsleep = false
                        Draw3DText(coords2.x, coords2.y, coords2.z + 1.2, '[E] Aby skorzystac z usług medyka $' .. Config.price)
                            if IsControlJustReleased(0, 54) then
                             DisableControlAction(0, 54, true)
                            if (GetEntityHealth(PlayerPedId()) >= 200) then
                                TriggerEvent("FeedM:showNotification", "Nie potrzebujesz pomocy medycznej", 1500, warning)
                            elseif (GetEntityHealth(PlayerPedId()) <= 200) or IsEntityDead(PlayePedId()) then
                                exports['mythic_progbar']:Progress({
                                    name = "Lolalny medyk",
                                    duration = 30000,
                                    label = "Medyk ci pomaga",
                                    useWhileDead = true,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "missheistdockssetup1clipboard@base",
                                        anim = "base",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "p_amb_clipboard_01",
                                        bone = 18905,
                                        coords = { x = 0.10, y = 0.02, z = 0.08 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                    propTwo = {
                                        model = "prop_pencil_01",
                                        bone = 58866,
                                        coords = { x = 0.12, y = 0.0, z = 0.001 },
                                        rotation = { x = -150.0, y = 0.0, z = 0.0 },
                                    },
                                }, function(status)
                                    if not status then
                                        Citizen.Wait(1000)
                                        TriggerEvent('kariusz:revivee')
                                        TriggerServerEvent('drp_hospital_ai:billing')
                                        EnableControlAction(0, 54, true)
                                        end
                                    end)
                                end
                            end
                    end
                end
            else
        Citizen.Wait(1000)
     end
     if letsleep then
        Citizen.Wait(1500)
    end
 end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local letsleep = true
            if not IsPedInAnyVehicle(PlayerPedId(), true) then
                for i=1, #Config.pos2, 1 do 
                    local player = GetPlayerPed(-1)

                    local pcords = GetEntityCoords(player, 0)
                    local coords2 = Config.pos2[1]
                    local distance = GetDistanceBetweenCoords(coords2['x'], coords2['y'], coords2['z'], pcords['x'], pcords['y'], pcords['z'], true)
                    if distance <= 3 then
                        letsleep = false
                        Draw3DText(coords2.x, coords2.y, coords2.z + 1.2, '[E] Aby skorzystac z usług medyka $' .. Config.price)
                            if IsControlJustReleased(0, 54) then
                             DisableControlAction(0, 54, true)
                            if (GetEntityHealth(PlayerPedId()) >= 200) then
                                TriggerEvent("FeedM:showNotification", "Nie potrzebujesz pomocy medycznej", 1500, warning)
                            elseif (GetEntityHealth(PlayerPedId()) <= 200) or IsEntityDead(PlayePedId()) then
                                exports['mythic_progbar']:Progress({
                                    name = "Lolalny medyk",
                                    duration = 30000,
                                    label = "Medyk ci pomaga",
                                    useWhileDead = true,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "missheistdockssetup1clipboard@base",
                                        anim = "base",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "p_amb_clipboard_01",
                                        bone = 18905,
                                        coords = { x = 0.10, y = 0.02, z = 0.08 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                    propTwo = {
                                        model = "prop_pencil_01",
                                        bone = 58866,
                                        coords = { x = 0.12, y = 0.0, z = 0.001 },
                                        rotation = { x = -150.0, y = 0.0, z = 0.0 },
                                    },
                                }, function(status)
                                    if not status then
                                        Citizen.Wait(1000)
                                        TriggerEvent('kariusz:revivee')
                                        TriggerServerEvent('drp_hospital_ai:billing')
                                        EnableControlAction(0, 54, true)
                                        end
                                    end)
                                end
                            end
                    end
                end
            else
        Citizen.Wait(1000)
     end
     if letsleep then
        Citizen.Wait(1500)
    end
 end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local letsleep = true
            if not IsPedInAnyVehicle(PlayerPedId(), true) then
                for i=1, #Config.pos3, 1 do 
                    local player = GetPlayerPed(-1)

                    local pcords = GetEntityCoords(player, 0)
                    local coords2 = Config.pos3[1]
                    local distance = GetDistanceBetweenCoords(coords2['x'], coords2['y'], coords2['z'], pcords['x'], pcords['y'], pcords['z'], true)
                    if distance <= 3 then
                        letsleep = false
                        Draw3DText(coords2.x, coords2.y, coords2.z + 1.2, '[E] Aby skorzystac z usług medyka $' .. Config.price)
                            if IsControlJustReleased(0, 54) then
                             DisableControlAction(0, 54, true)
                            if (GetEntityHealth(PlayerPedId()) >= 200) then
                                TriggerEvent("FeedM:showNotification", "Nie potrzebujesz pomocy medycznej", 1500, warning)
                            elseif (GetEntityHealth(PlayerPedId()) <= 200) or IsEntityDead(PlayePedId()) then
                                exports['mythic_progbar']:Progress({
                                    name = "Lolalny medyk",
                                    duration = 30000,
                                    label = "Medyk ci pomaga",
                                    useWhileDead = true,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "missheistdockssetup1clipboard@base",
                                        anim = "base",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "p_amb_clipboard_01",
                                        bone = 18905,
                                        coords = { x = 0.10, y = 0.02, z = 0.08 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                    propTwo = {
                                        model = "prop_pencil_01",
                                        bone = 58866,
                                        coords = { x = 0.12, y = 0.0, z = 0.001 },
                                        rotation = { x = -150.0, y = 0.0, z = 0.0 },
                                    },
                                }, function(status)
                                    if not status then
                                        Citizen.Wait(1000)
                                        TriggerEvent('kariusz:revivee')
                                        TriggerServerEvent('drp_hospital_ai:billing')
                                        EnableControlAction(0, 54, true)
                                        end
                                    end)
                                end
                            end
                    end
                end
            else
        Citizen.Wait(1000)
     end
     if letsleep then
        Citizen.Wait(1500)
    end
 end
end)
