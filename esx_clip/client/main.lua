ESX          = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

-- RegisterNetEvent('esx_clip:clipcli')
-- AddEventHandler('esx_clip:clipcli', function()
--   -- ped = GetPlayerPed(-1)
--   -- if IsPedArmed(ped, 4) then
--     -- hash=GetSelectedPedWeapon(ped)
--     -- if hash~=nil then
--       TriggerServerEvent('esx_clip:remove')
--       -- AddAmmoToPed(GetPlayerPed(-1), hash,30)
--       ESX.ShowNotification("Uzyles tej rzeczy")
--     else
--       ESX.ShowNotification("Nie masz broni w kaburze")
--     end
--   else
--     ESX.ShowNotification("Ta amunicja nie nadaje sie do tej broni")
--   end
-- end)