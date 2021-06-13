-- RegisterNetEvent('esx_addons_gcphone:call')
-- AddEventHandler('esx_addons_gcphone:call', function(data)
--   local playerPed   = GetPlayerPed(-1)
--   local coords      = GetEntityCoords(playerPed)
--   local message     = data.message
--   local number      = data.number
--   if message == nil then
--     DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 200)
--     while (UpdateOnscreenKeyboard() == 0) do
--       DisableAllControlActions(0);
--       Wait(0);
--     end
--     if (GetOnscreenKeyboardResult()) then
--       message =  GetOnscreenKeyboardResult()
--     end
--   end
--   if message ~= nil and message ~= "" then
--     TriggerServerEvent('esx_addons_gcphone:startCall', number, message, {
--       x = coords.x,
--       y = coords.y,
--       z = coords.z
--     })
--   end
-- end)

RegisterNetEvent('esx_addons_gcphone:call')
AddEventHandler('esx_addons_gcphone:call', function(data)
  local cbs = function(msg)
    if msg ~= nil and msg ~= "" then
      local coords = GetEntityCoords(PlayerPedId(), false)
      TriggerServerEvent('esx_addons_gcphone:startCall', data.number, msg, {
        x = coords.x,
        y = coords.y,
        z = coords.z
      })
    end
  end

  if data.message == nil then
    TriggerEvent('async:keyboard', function(value)
      cbs(value)
    end, {
      limit = 255,
      type = 'textarea',
      title = 'Wpisz wiadomość:'
    })
  else
    cbs(data.message)
  end
  

  if message ~= nil and message ~= "" then
    TriggerServerEvent('esx_addons_gcphone:startCall', number, message, {
      x = coords.x,
      y = coords.y,
      z = coords.z
    })
  end
end)