ESX						= nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('otworz') 
AddEventHandler('otworz', function()
	if IsPedInVehicle(PlayerPedId(), GetVehiclePedIsUsing(PlayerPedId()), false) then
		OtworzMenu()
	else
		ESX.ShowNotification("~r~Nie znajdujesz sie w pojezdzie!~W~")
	end
end)

function OtworzMenu()
	ESX.UI.Menu.Open( 
		'default', GetCurrentResourceName(), 'nomdumenu',
		{
			title    = ('ustaw kolor swiatel'),
			align = 'center', 
			elements = { 
				{label = ('STANDARDOWY'),     value = 'standardowe'},
				{label = ('BIALY'),     value = 'biale'},
				{label = ('NIEBIESKI'),      value = 'niebieskie'},
				{label = ('NIEBIESKO ELEKTRYCZNY'),      value = 'elektryczny_blue'},
				{label = ('MIETOWY ZIELONY'),      value = 'mietowa_zielen'},
				{label = ('LIMONKOWY ZIELONY'),      value = 'limonkowa_zielen'},
				{label = ('ZLOTY'),      value = 'zolty'},
				{label = ('ZLOTNISTY'),      value = 'zloty'},
				{label = ('POMARANCZOWY'),      value = 'pomaranczowy'},
				{label = ('CZERWONY'),      value = 'czerwony'},
				{label = ('ROZOWY'),      value = 'rozowy'},
				{label = ('GORACY ROZOWY'),      value = 'goracy_rozowy'},
				{label = ('FIOLETOWY'),      value = 'fioletowy'},
				{label = ('CIEMNY FIOLETOWY'),      value = 'czarny'}
			}
		},
		function(data, menu) 
			
        
			if data.current.value == 'standardowe' then
				ESX.ShowAdvancedNotification("Kontroler koloru swiatel", "", "Zmieniono kolor swiatel na ~g~standardowy~W~", "CHAR_CARSITE", 8)
				local veh = GetVehiclePedIsUsing(PlayerPedId())
				ToggleVehicleMod(veh, 22, true) 
				SetVehicleHeadlightsColour(veh, -1)
			end

			if data.current.value == 'biale' then
				ESX.ShowAdvancedNotification("Kontroler koloru swiatel", "", "Zmieniono kolor swiatel na ~g~bialy~w~", "CHAR_CARSITE", 8)
				local veh = GetVehiclePedIsUsing(PlayerPedId())
				ToggleVehicleMod(veh, 22, true) 
				SetVehicleHeadlightsColour(veh, 0)
			end

			if data.current.value == 'niebieskie' then
				ESX.ShowAdvancedNotification("Kontroler koloru swiatel", "", "Zmieniono kolor swiatel na ~g~niebieski~w~", "CHAR_CARSITE", 8)
				local veh = GetVehiclePedIsUsing(PlayerPedId())
				ToggleVehicleMod(veh, 22, true)
				SetVehicleHeadlightsColour(veh, 1)
			end

			if data.current.value == 'elektryczny_blue' then
				ESX.ShowAdvancedNotification("Kontroler koloru swiatel", "", "Zmieniono kolor swiatel na ~g~elektryczny niebieski~w~", "CHAR_CARSITE", 8)
				local veh = GetVehiclePedIsUsing(PlayerPedId())
				ToggleVehicleMod(veh, 22, true) 
				SetVehicleHeadlightsColour(veh, 2)
			end

			if data.current.value == 'mietowa_zielen' then
				ESX.ShowAdvancedNotification("Kontroler koloru swiatel", "", "Zmieniono kolor swiatel na ~g~mietowa zielen~w~", "CHAR_CARSITE", 8)
				local veh = GetVehiclePedIsUsing(PlayerPedId())
				ToggleVehicleMod(veh, 22, true) 
				SetVehicleHeadlightsColour(veh, 3)
			end

			if data.current.value == 'limonkowa_zielen' then
				ESX.ShowAdvancedNotification("Kontroler koloru swiatel", "", "Zmieniono kolor swiatel na ~g~limonkowa zielen~w~", "CHAR_CARSITE", 8)
				local veh = GetVehiclePedIsUsing(PlayerPedId())
				ToggleVehicleMod(veh, 22, true) 
				SetVehicleHeadlightsColour(veh, 4)
			end

			if data.current.value == 'zolty' then
				ESX.ShowAdvancedNotification("Kontroler koloru swiatel", "", "Zmieniono kolor swiatel na ~g~zolty~w~", "CHAR_CARSITE", 8)
				local veh = GetVehiclePedIsUsing(PlayerPedId())
				ToggleVehicleMod(veh, 22, true) 
				SetVehicleHeadlightsColour(veh, 5)
			end
			
			if data.current.value == 'zloty' then
				ESX.ShowAdvancedNotification("Kontroler koloru swiatel", "", "Zmieniono kolor swiatel na ~g~zloty~w~", "CHAR_CARSITE", 8)
				local veh = GetVehiclePedIsUsing(PlayerPedId())
				ToggleVehicleMod(veh, 22, true) 
				SetVehicleHeadlightsColour(veh, 6)
			end

			if data.current.value == 'pomaranczowy' then
				ESX.ShowAdvancedNotification("Kontroler koloru swiatel", "", "Zmieniono kolor swiatel na ~g~pomaranczowy~w~", "CHAR_CARSITE", 8)
				local veh = GetVehiclePedIsUsing(PlayerPedId())
				ToggleVehicleMod(veh, 22, true) 
				SetVehicleHeadlightsColour(veh, 7)
			end

			if data.current.value == 'czerwony' then
				ESX.ShowAdvancedNotification("Kontroler koloru swiatel", "", "Zmieniono kolor swiatel na ~g~czerwony~w~", "CHAR_CARSITE", 8)
				local veh = GetVehiclePedIsUsing(PlayerPedId())
				ToggleVehicleMod(veh, 22, true) 
				SetVehicleHeadlightsColour(veh, 8)
			end

			if data.current.value == 'rozowy' then
				ESX.ShowAdvancedNotification("Kontroler koloru swiatel", "", "Zmieniono kolor swiatel na ~g~rozowy~w~", "CHAR_CARSITE", 8)
				local veh = GetVehiclePedIsUsing(PlayerPedId())
				ToggleVehicleMod(veh, 22, true) 
				SetVehicleHeadlightsColour(veh, 9)
			end

			if data.current.value == 'goracy_rozowy' then
				ESX.ShowAdvancedNotification("Kontroler koloru swiatel", "", "Zmieniono kolor swiatel na ~g~goracy rozowy~w~", "CHAR_CARSITE", 8)
				local veh = GetVehiclePedIsUsing(PlayerPedId())
				ToggleVehicleMod(veh, 22, true) 
				SetVehicleHeadlightsColour(veh, 10)
			end

			if data.current.value == 'fioletowy' then
				ESX.ShowAdvancedNotification("Kontroler koloru swiatel", "", "Zmieniono kolor swiatel na ~g~fioletowy~w~", "CHAR_CARSITE", 8)
				local veh = GetVehiclePedIsUsing(PlayerPedId())
				ToggleVehicleMod(veh, 22, true) 
				SetVehicleHeadlightsColour(veh, 11)
			end

			if data.current.value == 'czarny' then
				ESX.ShowAdvancedNotification("Kontroler koloru swiatel", "", "Zmieniono kolor swiatel na ~g~ciemno fioletowy~w~", "CHAR_CARSITE", 8)
				local veh = GetVehiclePedIsUsing(PlayerPedId())
				ToggleVehicleMod(veh, 22, true) 
				SetVehicleHeadlightsColour(veh, 12)
			end

		end,
		function(data, menu)
			menu.close()
		end
	)
end

