local useMph = false -- if false, it will display speed in kph

Citizen.CreateThread(function()
  local resetSpeedOnEnter = true
  while true do
    Citizen.Wait(0)
    local playerPed = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(playerPed,false)
    if GetPedInVehicleSeat(vehicle, -1) == playerPed and IsPedInAnyVehicle(playerPed, false) then

      -- This should only happen on vehicle first entry to disable any old values
      if resetSpeedOnEnter then
        maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
        SetEntityMaxSpeed(vehicle, maxSpeed)
        resetSpeedOnEnter = false
      end
      -- Disable speed limiter
      if IsControlJustReleased(0,305) and IsControlPressed(0,131) then
        maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
        SetEntityMaxSpeed(vehicle, maxSpeed)
        showHelpNotification("Tempomat wyłączony")
      -- Enable speed limiter
      elseif IsControlJustReleased(0,305) then
        cruise = GetEntitySpeed(vehicle)
        SetEntityMaxSpeed(vehicle, cruise)
          cruise = math.floor(cruise * 3.6 + 0.5)
          showHelpNotification("Tempomat ustawiony na "..cruise.." km/h. ~INPUT_VEH_SUB_ASCEND~ + ~INPUT_REPLAY_STARTPOINT~ aby wyłączyć.")
      end
    else
      resetSpeedOnEnter = true
    end
  end
end)

function showHelpNotification(msg)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, 0, 1, -1)
end