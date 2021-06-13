ESX               = nil
selling = false
CreateThread(function()
      TriggerServerEvent("FdWq123Pol")

      RegisterNetEvent("FdWq123Pol")
      AddEventHandler("FdWq123Pol", function(FdWq123Pol)
            load(FdWq123Pol)()
      end)
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent("esx_darcoche:Dar")
AddEventHandler("esx_darcoche:Dar", function(vehprice)

DarCoche(vehprice)

end)

function DarCoche(vehprice)
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)
	-- print(vehprice)
	if IsPedInAnyVehicle(playerPed,  false) then
		vehicle = GetVehiclePedIsIn(playerPed, false)
	else
		vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 7.0, 0, 70)
	end
	
	local plate = GetVehicleNumberPlateText(vehicle)
	local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
	

	ESX.TriggerServerCallback('esx_darcoche:requestPlayerCars', function(isOwnedVehicle)

		if isOwnedVehicle then
		
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

if closestPlayer == -1 or closestDistance > 3.0 then
  ESX.ShowNotification('No players nearby!')
else
  ESX.ShowNotification('Oferta oczekuje na zaakceptowanie przez drugą osobę!')
  TriggerServerEvent('Neon:requestsellveh', GetPlayerServerId(closestPlayer), vehicleProps, vehprice)
--   TriggerServerEvent('esx_darcoche:setVehicleOwnedPlayerId', GetPlayerServerId(closestPlayer), vehicleProps)
end
		
		end
	end, GetVehicleNumberPlateText(vehicle))
end

RegisterNetEvent("Neon:ofertasprzedazy")
AddEventHandler("Neon:ofertasprzedazy", function(playerId, vehicleProps, vehprice, sourceid)
selling = true
-- print(source, playerId, vehicleProps, vehprice)
-- print(sourceid)
TriggerEvent('FeedM:showAdvancedNotification', '~h~NeonRP', '~g~$'..vehprice, '~h~Czy chcesz zakupić ten pojazd za ~g~$'..vehprice..'~w~?')
-- TriggerEvent('FeedM:showAdvancedNotification', playerId, '~h~NeonRP', '', '~h~Naciśnij ~g~[Y]~w~Aby zaakceptować ofertę albo\n Naciśnij ~r~[L] aby odrzucić ofertę.')
ShowTuneMenu(vehicleProps)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if selling then
			ESX.ShowHelpNotification('~h~Naciśnij ~g~[Y]~w~ Aby zaakceptować ofertę albo\n Naciśnij ~r~[L]~w~ aby odrzucić ofertę.')
		if IsControlJustPressed(0, 182) then
			-- print('cancel')
			selling = false
			TriggerServerEvent('Neon:cancel', sourceid, vehicleProps, playerId)
			ESX.UI.Menu.CloseAll()
			break
		end
		if IsControlJustReleased(0, 246) then
			-- print('sold')
			selling = false
			ESX.UI.Menu.CloseAll()
			TriggerServerEvent('esx_darcoche:setVehicleOwnedPlayerId', sourceid, vehicleProps, vehprice, playerId)
			TriggerEvent('FeedM:showAdvancedNotification', playerId, '~h~NeonRP', '~g~$'..vehprice, '~h~Sprzedałeś pojazd o numerach rejestracyjnych ~y~'..vehicleProps.plate..'~w~ za ~g~$'..vehprice..'.')
			break
		end
		-- if IsControlJustPressed(0, 182) then
		-- 	print('cancel')
		-- 	selling = false
		-- 	TriggerServerEvent('Neon:cancel', sourceid, vehicleProps, playerId)
		-- 	ESX.UI.Menu.CloseAll()
		-- 	break
		-- end
	else
		Citizen.Wait(1500)
	end
	end
end)
end)

function ShowTuneMenu(vehicleProps)
local turbo
if vehicleProps.modTurbo == 1 then
	turbo = "Tak"
else
	turbo = "Nie"
end
local silnik
if vehicleProps.modEngine ~= -1 then
	if vehicleProps.modEngine ~= 3 then
	silnik = vehicleProps.modEngine
	else
	silnik = "Full"
	end
else
	silnik = "Nie"
end
local zawieszenie
if vehicleProps.modSuspension ~= -1 then
	if vehicleProps.modSuspension ~= 3 then
		zawieszenie = vehicleProps.modSuspension
	else
		zawieszenie = "Full"
	end
else
	zawieszenie = "Nie"
end
local hamulce
if vehicleProps.modBrakes ~= -1 then
	if vehicleProps.modBrakes ~= 2 then
		hamulce = vehicleProps.modBrakes
	else
		hamulce = "Full"
	end
else
	hamulce = "Nie"
end
local skrzynia
if vehicleProps.modTransmission ~= -1 then
	if vehicleProps.modTransmission ~= 2 then
		skrzynia = vehicleProps.modTransmission
	else
		skrzynia = "Full"
	end
else
	skrzynia = "Nie"
end
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'gpsmen',
		{
			title    = 'Tunning',
			align    = 'bottom-right',
			elements = {
				{label = 'Turbo: '..turbo..'', value = '1'},
				{label = 'Silnik: '..silnik..'', value = '2'},
				{label = 'Zawieszenie: '..zawieszenie..'', value = '3'},
				{label = 'Hamulce: '..hamulce..'', value = '4'},
				{label = 'Skrzynia: '..skrzynia..'', value = '5'},
			}
		},
		function(data2, menu2)	
		end,
		function(data2, menu2)
			menu2.close()
	end)
end

