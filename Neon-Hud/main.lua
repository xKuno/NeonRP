local effectActive = false            -- Blur screen effect active
local blackOutActive = false          -- Blackout effect active
local currAccidentLevel = 0           -- Level of accident player has effect active of
local wasInCar = false
local oldBodyDamage = 0.0
local oldSpeed = 0.0
local currentDamage = 0.0
local currentSpeed = 0.0
local vehicle
local disableControls = false

IsCar = function(veh)
        local vc = GetVehicleClass(veh)
        return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
end 

function note(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

RegisterNetEvent("crashEffect")
AddEventHandler("crashEffect", function(countDown, accidentLevel)

    if not effectActive or (accidentLevel > currAccidentLevel) then
        currAccidentLevel = accidentLevel
        disableControls = true
        effectActive = true
        blackOutActive = true
        blackOutActive = false
        StartScreenEffect('Dont_tazeme_bro', 0, true)
        StartScreenEffect('MP_race_crash', 0, true)
    
        while countDown > 0 do
            if countDown > (3.5*accidentLevel)   then 
                ShakeGameplayCam("MEDIUM_EXPLOSION_SHAKE", (accidentLevel * Config.ScreenShakeMultiplier))
            end 
            Wait(750)
            -- TriggerEvent('chatMessage', "countdown: " .. countDown) -- Debug printout ]]
            
            countDown = countDown - 1

            if countDown < 3 then
              disableControls = false
            end
            if countDown <= 1 then
              StopScreenEffect('Dont_tazeme_bro')
              StopScreenEffect('MP_race_crash')
            end
        end
        currAccidentLevel = 0
        effectActive = false
    end
end)




Citizen.CreateThread(function()
	while true do
        Citizen.Wait(10)
        
            -- If the damage changed, see if it went over the threshold and blackout if necesary
            vehicle = GetVehiclePedIsIn(PlayerPedId(-1), false)
            if DoesEntityExist(vehicle) and (wasInCar or IsCar(vehicle)) then
                wasInCar = true
                oldSpeed = currentSpeed
                oldBodyDamage = currentDamage
                currentDamage = GetVehicleBodyHealth(vehicle)
                currentSpeed = GetEntitySpeed(vehicle) * 2.23

                if currentDamage ~= oldBodyDamage then
                    -- print("crash")
                    if not effect and currentDamage < oldBodyDamage then
                        -- print("effect")
                        print(oldBodyDamage - currentDamage)
                        if (oldBodyDamage - currentDamage) >= Config.BlackoutDamageRequiredLevel5 or
                        (oldSpeed - currentSpeed)  >= Config.BlackoutSpeedRequiredLevel5
                        then
                            --[[ note("lv5") ]]
                            oldBodyDamage = currentDamage
                            TriggerEvent("crashEffect", Config.EffectTimeLevel5, 5)
                            --[[ note(oldSpeed - currentSpeed)
                            note(oldBodyDamage - currentDamage) ]]
                            
                            
                            

                        elseif (oldBodyDamage - currentDamage) >= Config.BlackoutDamageRequiredLevel4 or
                        (oldSpeed - currentSpeed)  >= Config.BlackoutSpeedRequiredLevel4
                        then
                            --[[ note("lv4") ]]
                            TriggerEvent("crashEffect", Config.EffectTimeLevel4, 4)
                            oldBodyDamage = currentDamage
                           --[[  note(oldSpeed - currentSpeed)
                            note(oldBodyDamage - currentDamage) ]]
                            
                        

                        elseif (oldBodyDamage - currentDamage) >= Config.BlackoutDamageRequiredLevel3 or
                        (oldSpeed - currentSpeed)  >= Config.BlackoutSpeedRequiredLevel3
                        then   
                            --[[ note(oldSpeed - currentSpeed)
                            note(oldBodyDamage - currentDamage)
                            note("lv3") ]]
                            oldBodyDamage = currentDamage
                            TriggerEvent("crashEffect", Config.EffectTimeLevel3, 3)
                            
                        

                        elseif (oldBodyDamage - currentDamage) >= Config.BlackoutDamageRequiredLevel2 or
                        (oldSpeed - currentSpeed)  >= Config.BlackoutSpeedRequiredLevel2
                        then
                            --[[ note(-(oldSpeed - currentSpeed))
                            note(oldBodyDamage - currentDamage)
                            note("lv2") ]]
                            oldBodyDamage = currentDamage
                            TriggerEvent("crashEffect", Config.EffectTimeLevel2, 2)


                        elseif (oldBodyDamage - currentDamage) >= Config.BlackoutDamageRequiredLevel1 or
                        (oldSpeed - currentSpeed)  >= Config.BlackoutSpeedRequiredLevel1
                        then
                            --[[ note(-(oldSpeed - currentSpeed))
                            note(oldBodyDamage - currentDamage)
                            note("lv1") ]]
                            oldBodyDamage = currentDamage
                            TriggerEvent("crashEffect", Config.EffectTimeLevel1, 1)
                        end
                    end
                end
            elseif wasInCar then
                wasInCar = false
                beltOn = false
                currentDamage = 0
                oldBodyDamage = 0
                currentSpeed = 0
                oldSpeed = 0
            end
            
        if disableControls then
            -- Controls to disable while player is on blackout
			DisableControlAction(0,71,true) -- veh forward
			DisableControlAction(0,72,true) -- veh backwards
			DisableControlAction(0,63,true) -- veh turn left
			DisableControlAction(0,64,true) -- veh turn right
			-- DisableControlAction(0,75,true) -- disable exit vehicle
		end
	end
end)

local isUiOpen = false 
local speedBuffer  = {}
local velBuffer    = {}
local beltOn       = false
local wasInCar     = false

IsCar = function(veh)
        local vc = GetVehicleClass(veh)
        return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
        end 

Fwv = function (entity)
        local hr = GetEntityHeading(entity) + 90.0
        if hr < 0.0 then hr = 360.0 + hr end
        hr = hr * 0.0174533
        return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
      end
 
 
Citizen.CreateThread(function()
  RequestStreamedTextureDict('mpinventory')
    while not HasStreamedTextureDictLoaded('mpinventory') do
        Citizen.Wait(0)
    end


	local timer = GetGameTimer()
  
  
  while true do
  Citizen.Wait(0)
  
    local ped = GetPlayerPed(-1)
    local car = GetVehiclePedIsIn(ped)
    
    if car ~= 0 and (wasInCar or IsCar(car)) then
      wasInCar = true
             if isUiOpen == false and not IsPlayerDead(PlayerId()) then
              DrawSprite('mpinventory', 'mp_specitem_ped', 0.162, 0.984, 0.015, 0.025, 0.0, 255, 255, 255, 255)
              local tmp = GetGameTimer() - timer
              if tmp > 1000 then
                timer = GetGameTimer()
              elseif tmp > 500 then
                DrawSprite('mpinventory', 'mp_specitem_partnericon', 0.162, 0.984, 0.01, 0.02, 0.0, 255, 0, 0, 255)
              end	
            end

      if beltOn then 
        
        DisableControlAction(0, 75)
        DrawSprite('mpinventory', 'mp_specitem_ped', 0.162, 0.984, 0.015, 0.025, 0.0, 255, 255, 255, 255)
        DrawSprite('mpinventory', 'mp_specitem_partnericon', 0.162, 0.984, 0.01, 0.02, 0.0, 0, 255, 0, 255)
        
      
      end

      speedBuffer[2] = speedBuffer[1]
      speedBuffer[1] = GetEntitySpeed(car)
      
      if speedBuffer[2] ~= nil 
         and not beltOn
         and GetEntitySpeedVector(car, true).y > 1.0  
         and speedBuffer[1] > 19.25 
         and (speedBuffer[2] - speedBuffer[1]) > (speedBuffer[1] * 0.255) then
         
        local co = GetEntityCoords(ped)
        local fw = Fwv(ped)
        SetEntityCoords(ped, co.x + fw.x, co.y + fw.y, co.z - 0.47, true, true, true)
        SetEntityVelocity(ped, velBuffer[2].x, velBuffer[2].y, velBuffer[2].z)
        Citizen.Wait(1)
        SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
      end
        
      velBuffer[2] = velBuffer[1]
      velBuffer[1] = GetEntityVelocity(car)
        
      if IsControlJustReleased(0, 58) and GetLastInputMethod(0) then
        beltOn = not beltOn 
        if beltOn then 
      TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 3, "belton", 1.0)
      DrawSprite('mpinventory', 'mp_specitem_ped', 0.162, 0.984, 0.015, 0.025, 0.0, 255, 255, 255, 255)
      DrawSprite('mpinventory', 'mp_specitem_partnericon', 0.162, 0.984, 0.01, 0.02, 0.0, 0, 255, 0, 255)
		else 
      TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 3, "beltoff", 1.0)
      DrawSprite('mpinventory', 'mp_specitem_ped', 0.162, 0.984, 0.015, 0.025, 0.0, 255, 255, 255, 255)
      local tmp = GetGameTimer() - timer
      if tmp > 1000 then
        timer = GetGameTimer()
      elseif tmp > 500 then
        DrawSprite('mpinventory', 'mp_specitem_partnericon', 0.162, 0.984, 0.01, 0.02, 0.0, 255, 0, 0, 255)
      end
		end
      end
      
    elseif wasInCar then
      wasInCar = false
      beltOn = false
      speedBuffer[1], speedBuffer[2] = 0.0, 0.0
             if isUiOpen == true and not IsPlayerDead(PlayerId()) then
                DrawSprite('mpinventory', 'mp_specitem_ped', 0.162, 0.984, 0.015, 0.025, 0.0, 255, 255, 255, 255)
                DrawSprite('mpinventory', 'mp_specitem_partnericon', 0.162, 0.984, 0.01, 0.02, 0.0, 0, 255, 0, 255) 
            end
        end
    end
end)


