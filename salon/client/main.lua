local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local IsInShopMenu            = false
local Categories              = {}
local Vehicles                = {}
local LastVehicles            = {}
local CurrentVehicleData      = nil
local cenaJazdy 			  = 30000
local essa = true
local timer = 30
local timerMax = timer
local isTesting = false
local testingVehicle = nil
local IsDead = false

ESX                           = nil

Citizen.CreateThread(function ()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(10000)

	ESX.TriggerServerCallback('esx_vehicleshop:getCategories', function (categories)
		Categories = categories
	end)

	ESX.TriggerServerCallback('esx_vehicleshop:getVehicles', function (vehicles)
		Vehicles = vehicles
	end)

	if Config.EnablePlayerManagement then
		if ESX.PlayerData.job.name == 'cardealer' then
			Config.Zones.ShopEntering.Type = 1

			if ESX.PlayerData.job.grade_name == 'boss' then
				Config.Zones.BossActions.Type = 1
			end

		else
			Config.Zones.ShopEntering.Type = -1
			Config.Zones.BossActions.Type  = -1
		end
	end
end)

RegisterNetEvent('PrintClientVehicleShop')
AddEventHandler('PrintClientVehicleShop', function()
	print('Wystąpił problem z kupnem/wykonaniem jakiej kolwiek akcji przy użyciu skryptu vehicleshop - Twoja tablica rejestracyjna została wykryta jako NIL zgłoś się proszę do administracji.')
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer

	if Config.EnablePlayerManagement then
		if ESX.PlayerData.job.name == 'cardealer' then
			Config.Zones.ShopEntering.Type = 1

			if ESX.PlayerData.job.grade_name == 'boss' then
				Config.Zones.BossActions.Type = 1
			end

		else
			Config.Zones.ShopEntering.Type = -1
			Config.Zones.BossActions.Type  = -1
		end
	end
end)

RegisterNetEvent('esx_vehicleshop:sendCategories')
AddEventHandler('esx_vehicleshop:sendCategories', function (categories)
	Categories = categories
end)

RegisterNetEvent('esx_vehicleshop:sendVehicles')
AddEventHandler('esx_vehicleshop:sendVehicles', function (vehicles)
	Vehicles = vehicles
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if timer < timerMax then
			timer = timer + 1
		end
	end
end)

AddEventHandler('esx_vehicleshop:getVehicles', function (cb)
    cb(Vehicles)
end)

function getVehicles()
	return Vehicles
end

function TestCar(vehicleData)
	timer = 0
	isTesting = true

	playerPed = Citizen.InvokeNative(0x43A66C31C68491C0, -1)
	ESX.Game.SpawnVehicle(vehicleData.model, {
		x = Config.TestDrive.coords.x,
		y = Config.TestDrive.coords.y,
		z = Config.TestDrive.coords.z
	}, Config.TestDrive.heading, function (vehicle)
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		ESX.ShowNotification('Masz trzy minuty na przetestowanie pojazdu')
		ESX.ShowNotification('Nie opuszczaj go!')

		testingVehicle = vehicle
		SetVehicleDoorsLocked(vehicle, 4)
		FreezeEntityPosition(playerPed, false)		
		Citizen.InvokeNative(0xEA1C610A04DB6BBB, playerPed, true)

		SetVehicleNumberPlateText(vehicle, 'TEST CAR')
		CreateThread(function()
			while true do 
				Citizen.Wait(1000)
				if timer ~= timerMax then
					SetTextComponentFormat('STRING')
					AddTextComponentString('Pozostało Ci ~b~' .. (timerMax - timer) .. '~w~/~b~' .. timerMax .. '~w~ sekund.')
					DisplayHelpTextFromStringLabel(0, 0, 1, -1)
					EndTextCommandDisplayHelp(0, 0, true, 1000)

					VehEngineHP = GetVehicleEngineHealth(vehicle) 
					if not IsPedSittingInAnyVehicle(Citizen.InvokeNative(0x43A66C31C68491C0, -1)) then
						ESX.ShowNotification('Opuściłeś pojazd!')
						isTesting = false
						timer = timerMax
						SetEntityCoords(vehicle, Config.TestDrive.coords, 1, 0, 0, 1)
						ESX.Game.DeleteVehicle(vehicle)
					elseif IsDead then
						ESX.ShowNotification('Obezwładniony!')
						isTesting = false
						timer = timerMax
						ESX.Game.DeleteVehicle(vehicle)
					elseif timer  == timerMax - 1 then
						ESX.ShowNotification('Skończył Ci się czas wypożyczenia!')
						isTesting = false
						timer = timerMax
						SetEntityCoords(vehicle, Config.TestDrive.coords, 1, 0, 0, 1)
						ESX.Game.DeleteVehicle(vehicle)
					elseif (VehEngineHP > 0) and (VehEngineHP < 980) then 
						ESX.ShowNotification('Uszkodziłeś pojazd')
						isTesting = false
						timer = timerMax
						SetEntityCoords(vehicle, Config.TestDrive.coords, 1, 0, 0, 1)
						ESX.Game.DeleteVehicle(vehicle)
					end
				end
			end
		end)
    end)
end

CreateThread(function()
	while true do 
		Citizen.Wait(1000)
		if IsPedInAnyVehicle(PlayerPedId()) then
			local vehicle = GetVehiclePedIsIn(PlayerPedId())
			if string.upper(tostring(GetVehicleNumberPlateText(vehicle))) == 'TEST CAR' and not isTesting then
				ESX.Game.DeleteVehicle(vehicle)
				ESX.ShowNotification('To pojazd testowy!')
			end
		end
	end
end)

function DeleteShopInsideVehicles()
	while #LastVehicles > 0 do
		local vehicle = LastVehicles[1]

		ESX.Game.DeleteVehicle(vehicle)
		table.remove(LastVehicles, 1)
	end
end

function ReturnVehicleProvider()

	ESX.TriggerServerCallback('esx_vehicleshop:getCommercialVehicles', function (vehicles)
		local elements = {}
		local returnPrice
		for i=1, #vehicles, 1 do
			returnPrice = ESX.Math.Round(vehicles[i].price * 0.75)

			table.insert(elements, {
				label = ('%s [<span style="color:orange;">%s</span>]'):format(vehicles[i].name, _U('generic_shopitem', ESX.Math.GroupDigits(returnPrice))),
				value = vehicles[i].name
			})
		end
	
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_provider_menu',
		{
			title    = _U('return_provider_menu'),
			align    = 'right',
			elements = elements
		}, function (data, menu)
			TriggerServerEvent('esx_vehicleshop:returnProvider', data.current.value)

			Citizen.Wait(300)
			menu.close()

			ReturnVehicleProvider()
		end, function (data, menu)
			menu.close()
		end)
	end)

end

function StartShopRestriction()

	Citizen.CreateThread(function()
		while IsInShopMenu do
			Citizen.Wait(1)
	
			DisableControlAction(0, 75,  true) -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		end
	end)

end

function OpenShopMenu()

	IsInShopMenu = true

	StartShopRestriction()
	ESX.UI.Menu.CloseAll()

	local playerPed = PlayerPedId()

	FreezeEntityPosition(playerPed, true)
	SetEntityVisible(playerPed, false)
	SetEntityCoords(playerPed, Config.Zones.ShopInside.Pos.x, Config.Zones.ShopInside.Pos.y, Config.Zones.ShopInside.Pos.z)

	local vehiclesByCategory = {}
	local elements           = {}
	local firstVehicleData   = nil

	for i=1, #Categories, 1 do
		vehiclesByCategory[Categories[i].name] = {}
	end

	for i=1, #Vehicles, 1 do
		if IsModelInCdimage(GetHashKey(Vehicles[i].model)) then
			table.insert(vehiclesByCategory[Vehicles[i].category], Vehicles[i])
		else
			print(('esx_vehicleshop: vehicle "%s" does not exist'):format(Vehicles[i].model))
		end
	end

	for i=1, #Categories, 1 do
		local category         = Categories[i]
		local categoryVehicles = vehiclesByCategory[category.name]
		local options          = {}

		for j=1, #categoryVehicles, 1 do
			local vehicle = categoryVehicles[j]

			if i == 1 and j == 1 then
				firstVehicleData = vehicle
			end

			table.insert(options, vehicle.name..(vehicle.limited == 1 and '<span style="color: red;"> Tylko podgląd</span>' or (ESX.PlayerData.job.name == 'cardealer' and '<span style="color: #7cfc00;"> $'..math.floor(vehicle.price * 85 / 100)..'</span>' or '<span style="color: #7cfc00;"> $'..ESX.Math.GroupDigits(vehicle.price)..'</span>')))
		end

		table.insert(elements, {
			name    = category.name,
			label   = category.label,
			value   = 0,
			type    = 'slider',
			max     = #Categories[i],
			limited = Categories[i].limited,
			options = options
		})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_shop',
	{
		title    = _U('car_dealer'),
		align    = 'right',
		elements = elements
	}, function (data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]

		if vehicleData.limited == 0 then

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
				title = (vehicleData.limited == 0 and _U('buy_vehicle_shop', vehicleData.name, ESX.PlayerData.job.name == 'cardealer' and ESX.Math.GroupDigits(math.floor(vehicleData.price * 85 / 100)) or ESX.Math.GroupDigits(vehicleData.price)) or 'Nie możesz kupić tego pojazdu'),
				align = 'right',
				
				elements = (vehicleData.limited == 0 and {
					{label = _U('yes'), value = 'yes'},
					{label = ('Jazda Testowa <font color=red>'..cenaJazdy..'</font>$'), value = 'test'},
					{label = ('Powrót'),  value = 'no'}
				} or {
					{label = ('Samochód jest wystawiony tylko na licytację'),  value = 'no'}
				}),
			}, function(data2, menu2)
				if data2.current.value == 'test' then
					if not isTesting then
						menu2.close()
						ESX.TriggerServerCallback('esx_vehiclekatalog:payTest', function (status)
							if status then
								menu.close()
								Citizen.Wait(500)
								TestCar(vehicleData)
							else
								ESX.ShowNotification('Nie masz odpowiedniej ilości gotówki!')
							end
						end)
					end		
				elseif data2.current.value == 'yes' then
					if Config.EnablePlayerManagement then
						ESX.TriggerServerCallback('esx_vehicleshop:buyVehicleSociety', function(hasEnoughMoney)

							if hasEnoughMoney then
								IsInShopMenu = false

								DeleteShopInsideVehicles()

								local playerPed = PlayerPedId()

								CurrentAction     = 'shop_menu'
								CurrentActionMsg  = _U('shop_menu')
								CurrentActionData = {}

								FreezeEntityPosition(playerPed, false)
								SetEntityVisible(playerPed, true)
								SetEntityCoords(playerPed, Config.Zones.ShopEntering.Pos.x, Config.Zones.ShopEntering.Pos.y, Config.Zones.ShopEntering.Pos.z)

								menu2.close()
								menu.close()

								ESX.ShowNotification(_U('vehicle_purchased'))
							else
								ESX.ShowNotification(_U('broke_company'))
							end

						end, 'cardealer', vehicleData.model)
					else
						local playerData = ESX.GetPlayerData()

						if Config.EnableSocietyOwnedVehicles and playerData.job.grade_name == 'boss' then

							ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm_buy_type', {
								title = _U('purchase_type'),
								align = 'right',
								elements = {
									{label = _U('staff_type'),   value = 'personnal'},
									{label = _U('society_type'), value = 'society'}
								}
							}, function (data3, menu3)

								if data3.current.value == 'personnal' then

									ESX.TriggerServerCallback('esx_vehicleshop:buyVehicle', function(hasEnoughMoney)

										if hasEnoughMoney then
											IsInShopMenu = false

											menu3.close()
											menu2.close()
											menu.close()

											DeleteShopInsideVehicles()

											ESX.Game.SpawnVehicle(vehicleData.model, Config.Zones.ShopOutside.Pos, Config.Zones.ShopOutside.Heading, function (vehicle)
												TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

												local newPlate     = GeneratePlate()
												local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
												vehicleProps.plate = newPlate
												SetVehicleNumberPlateText(vehicle, newPlate)

												if Config.EnableOwnedVehicles then
													TriggerServerEvent('esx_vehicleshop:setVehicleOwned', vehicleProps, vehicleData)
												end

												ESX.ShowNotification(_U('vehicle_purchased'))
											end)

											FreezeEntityPosition(playerPed, false)
											SetEntityVisible(playerPed, true)
										else
											ESX.ShowNotification(_U('not_enough_money'))
										end

									end, vehicleData.model)

								elseif data3.current.value == 'society' then

									ESX.TriggerServerCallback('esx_vehicleshop:buyVehicleSociety', function (hasEnoughMoney)

										if hasEnoughMoney then
											IsInShopMenu = false

											menu3.close()
											menu2.close()
											menu.close()

											DeleteShopInsideVehicles()

											ESX.Game.SpawnVehicle(vehicleData.model, Config.Zones.ShopOutside.Pos, Config.Zones.ShopOutside.Heading, function (vehicle)
												TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

												local newPlate     = GeneratePlate()
												local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
												vehicleProps.plate = newPlate
												SetVehicleNumberPlateText(vehicle, newPlate)

												TriggerServerEvent('esx_vehicleshop:setVehicleOwnedSociety', playerData.job.name, vehicleProps, vehicleData)

												ESX.ShowNotification(_U('vehicle_purchased'))
											end)

											FreezeEntityPosition(playerPed, false)
											SetEntityVisible(playerPed, true)
										else
											ESX.ShowNotification(_U('broke_company'))
										end

									end, playerData.job.name, vehicleData.model)

								end
							end, function (data3, menu3)
								menu3.close()
							end)
						else
							-- local brokerCount = exports['esx_scoreboard']:BierFrakcje('cardealer')
							if essa then
								ESX.TriggerServerCallback('esx_vehicleshop:buyVehicle', function (hasEnoughMoney)

									if hasEnoughMoney then
										IsInShopMenu = false

										menu2.close()
										menu.close()

										DeleteShopInsideVehicles()

										ESX.Game.SpawnVehicle(vehicleData.model, Config.Zones.ShopOutside.Pos, Config.Zones.ShopOutside.Heading, function (vehicle)
											TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

											local newPlate     = GeneratePlate()
											local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
											vehicleProps.plate = newPlate
											SetVehicleNumberPlateText(vehicle, newPlate)

											if Config.EnableOwnedVehicles then
												TriggerServerEvent('esx_vehicleshop:setVehicleOwned', vehicleProps, vehicleData)
											end

											ESX.ShowNotification(_U('vehicle_purchased'))
										end)

										FreezeEntityPosition(playerPed, false)
										SetEntityVisible(playerPed, true)
									else
										ESX.ShowNotification(_U('not_enough_money'))
									end

								end, vehicleData.model)
							else
								ESX.ShowNotification('Udaj się do ~o~brokera ~w~będącego na służbie, aby zakupić ten pojazd!')
							end
						end
					end
				elseif data2.current.value == 'no' then

				end

			end, function (data2, menu2)
				menu2.close()
			end)
		end

	end, function (data, menu)

		menu.close()

		DeleteShopInsideVehicles()

		local playerPed = PlayerPedId()

		CurrentAction     = 'shop_menu'
		CurrentActionMsg  = _U('shop_menu')
		CurrentActionData = {}

		FreezeEntityPosition(playerPed, false)
		SetEntityVisible(playerPed, true)
		SetEntityCoords(playerPed, Config.Zones.ShopEntering.Pos.x, Config.Zones.ShopEntering.Pos.y, Config.Zones.ShopEntering.Pos.z)

		IsInShopMenu = false

	end, function (data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]
		local playerPed   = PlayerPedId()

		DeleteShopInsideVehicles()
		WaitForVehicleToLoad(vehicleData.model)

		ESX.Game.SpawnLocalVehicle(vehicleData.model, Config.Zones.ShopInside.Pos, Config.Zones.ShopInside.Heading, function (vehicle)
			table.insert(LastVehicles, vehicle)
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			FreezeEntityPosition(vehicle, true)
		end)
	end)

	DeleteShopInsideVehicles()
	WaitForVehicleToLoad(firstVehicleData.model)

	ESX.Game.SpawnLocalVehicle(firstVehicleData.model, Config.Zones.ShopInside.Pos, Config.Zones.ShopInside.Heading, function (vehicle)
		table.insert(LastVehicles, vehicle)
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		FreezeEntityPosition(vehicle, true)
	end)

end

function WaitForVehicleToLoad(modelHash)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(1)

			DisableControlAction(0, Keys['TOP'], true)
			DisableControlAction(0, Keys['DOWN'], true)
			DisableControlAction(0, Keys['LEFT'], true)
			DisableControlAction(0, Keys['RIGHT'], true)
			DisableControlAction(0, 176, true) -- ENTER key
			DisableControlAction(0, Keys['BACKSPACE'], true)

			drawLoadingText(_U('shop_awaiting_model'), 255, 255, 255, 255)
		end
	end
end

RegisterNetEvent('esx_vehicleshop:openPersonnalVehicleMenu')
AddEventHandler('esx_vehicleshop:openPersonnalVehicleMenu', function ()
	OpenPersonnalVehicleMenu()
end)

function OpenPersonnalVehicleMenu()
	ESX.UI.Menu.CloseAll()

	ESX.TriggerServerCallback('esx_vehicleshop:getPersonnalVehicles', function (vehicles)
		local elements = {}

		for i=1, #vehicles, 1 do
			for j=1, #Vehicles, 1 do
				if vehicles[i].model == GetHashKey(Vehicles[j].model) then
					vehicles[i].name = Vehicles[j].name
					break
				end
			end
		end

		for i=1, #vehicles, 1 do
			table.insert(elements, {
				label = vehicles[i].name .. ' [<span style="color: orange;">' .. vehicles[i].plate .. '</span>]',
				value = vehicles[i]
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'personnal_vehicle',
		{
			title    = _U('personal_vehicle'),
			align    = 'top-left',
			elements = elements,
		}, function (data, menu)
			local playerPed   = PlayerPedId()
			local coords      = GetEntityCoords(playerPed)
			local heading     = GetEntityHeading(playerPed)
			local vehicleData = data.current.value

			menu.close()

			ESX.Game.SpawnVehicle(vehicleData.model, {
				x = coords.x,
				y = coords.y,
				z = coords.z
			}, heading, function (vehicle)
				ESX.Game.SetVehicleProperties(vehicle, vehicleData)
				TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			end)
		end, function (data, menu)
			menu.close()
		end)
	end)
end

function OpenResellerMenu()

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'reseller',
	{
		title    = _U('car_dealer'),
		align    = 'right',
		elements = {
			{label = _U('buy_vehicle'),                    value = 'buy_vehicle'},
			{label = _U('pop_vehicle'),                    value = 'pop_vehicle'},
			{label = _U('depop_vehicle'),                  value = 'depop_vehicle'},
			{label = _U('return_provider'),                value = 'return_provider'},
			{label = _U('create_bill'),                    value = 'create_bill'},
			{label = _U('get_rented_vehicles'),            value = 'get_rented_vehicles'},
			{label = _U('set_vehicle_owner_sell'),         value = 'set_vehicle_owner_sell'},
			{label = _U('set_vehicle_owner_rent'),         value = 'set_vehicle_owner_rent'},
			{label = _U('set_vehicle_owner_sell_society'), value = 'set_vehicle_owner_sell_society'},
			{label = _U('deposit_stock'),                  value = 'put_stock'},
			{label = _U('take_stock'),                     value = 'get_stock'}
		}
	}, function (data, menu)
		local action = data.current.value

		if action == 'buy_vehicle' then
			OpenShopMenu()
		elseif action == 'put_stock' then
			OpenPutStocksMenu()
		elseif action == 'get_stock' then
			OpenGetStocksMenu()
		elseif action == 'pop_vehicle' then
			OpenPopVehicleMenu()
		elseif action == 'depop_vehicle' then
			DeleteShopInsideVehicles()
		elseif action == 'return_provider' then
			ReturnVehicleProvider()
		elseif action == 'create_bill' then

			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer == -1 or closestDistance > 3.0 then
				ESX.ShowNotification(_U('no_players'))
				return
			end

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'set_vehicle_owner_sell_amount', {
				title = _U('invoice_amount')
			}, function (data2, menu2)
				local amount = tonumber(data2.value)

				if amount == nil then
					ESX.ShowNotification(_U('invalid_amount'))
				else
					menu2.close()

					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

					if closestPlayer == -1 or closestDistance > 3.0 then
						ESX.ShowNotification(_U('no_players'))
					else
						TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_cardealer', _U('car_dealer'), tonumber(data2.value))
					end
				end
			end, function (data2, menu2)
				menu2.close()
			end)

		elseif action == 'get_rented_vehicles' then
			OpenRentedVehiclesMenu()
		elseif action == 'set_vehicle_owner_sell' then

			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

			if closestPlayer == -1 or closestDistance > 3.0 then
				ESX.ShowNotification(_U('no_players'))
			else

				local newPlate     = GeneratePlate()
				local vehicleProps = ESX.Game.GetVehicleProperties(LastVehicles[#LastVehicles])
				local model        = CurrentVehicleData.model
				vehicleProps.plate = newPlate
				SetVehicleNumberPlateText(LastVehicles[#LastVehicles], newPlate)

				TriggerServerEvent('esx_vehicleshop:sellVehicle', model)
				TriggerServerEvent('esx_vehicleshop:addToList', GetPlayerServerId(closestPlayer), model, newPlate)

				if Config.EnableOwnedVehicles then
					TriggerServerEvent('esx_vehicleshop:setVehicleOwnedPlayerId', GetPlayerServerId(closestPlayer), vehicleProps)
					ESX.ShowNotification(_U('vehicle_set_owned', vehicleProps.plate, GetPlayerName(closestPlayer)))
				else
					ESX.ShowNotification(_U('vehicle_sold_to', vehicleProps.plate, GetPlayerName(closestPlayer)))
				end

			end

		elseif action == 'set_vehicle_owner_sell_society' then

			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

			if closestPlayer == -1 or closestDistance > 3.0 then
				ESX.ShowNotification(_U('no_players'))
			else
				ESX.TriggerServerCallback('esx:getOtherPlayerData', function (xPlayer)

					local newPlate     = GeneratePlate()
					local vehicleProps = ESX.Game.GetVehicleProperties(LastVehicles[#LastVehicles])
					local model        = CurrentVehicleData.model
					vehicleProps.plate = newPlate
					SetVehicleNumberPlateText(LastVehicles[#LastVehicles], newPlate)

					TriggerServerEvent('esx_vehicleshop:sellVehicle', model)
					TriggerServerEvent('esx_vehicleshop:addToList', GetPlayerServerId(closestPlayer), model, newPlate)

					if Config.EnableSocietyOwnedVehicles then
						TriggerServerEvent('esx_vehicleshop:setVehicleOwnedSociety', xPlayer.job.name, vehicleProps)
						ESX.ShowNotification(_U('vehicle_set_owned', vehicleProps.plate, GetPlayerName(closestPlayer)))
					else
						ESX.ShowNotification(_U('vehicle_sold_to', vehicleProps.plate, GetPlayerName(closestPlayer)))
					end

				end, GetPlayerServerId(closestPlayer))
			end

		elseif action == 'set_vehicle_owner_rent' then

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'set_vehicle_owner_rent_amount', {
				title = _U('rental_amount')
			}, function (data2, menu2)
				local amount = tonumber(data2.value)

				if amount == nil then
					ESX.ShowNotification(_U('invalid_amount'))
				else
					menu2.close()

					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

					if closestPlayer == -1 or closestDistance > 5.0 then
						ESX.ShowNotification(_U('no_players'))
					else
						
						local newPlate     = 'RENT' .. string.upper(ESX.GetRandomString(4))
						local vehicleProps = ESX.Game.GetVehicleProperties(LastVehicles[#LastVehicles])
						local model        = CurrentVehicleData.model
						vehicleProps.plate = newPlate
						SetVehicleNumberPlateText(LastVehicles[#LastVehicles], newPlate)

						TriggerServerEvent('esx_vehicleshop:rentVehicle', model, vehicleProps.plate, GetPlayerName(closestPlayer), CurrentVehicleData.price, amount, GetPlayerServerId(closestPlayer))

						if Config.EnableOwnedVehicles then
						TriggerServerEvent('esx_vehicleshop:setVehicleOwnedPlayerId', GetPlayerServerId(closestPlayer), vehicleProps)
						end

						ESX.ShowNotification(_U('vehicle_set_rented', vehicleProps.plate, GetPlayerName(closestPlayer)))

						TriggerServerEvent('esx_vehicleshop:setVehicleForAllPlayers', vehicleProps, Config.Zones.ShopInside.Pos.x, Config.Zones.ShopInside.Pos.y, Config.Zones.ShopInside.Pos.z, 5.0)
					end
				end
			end, function (data2, menu2)
				menu2.close()
			end)
		end

	end, function (data, menu)
		menu.close()

		CurrentAction     = 'reseller_menu'
		CurrentActionMsg  = _U('shop_menu')
		CurrentActionData = {}
	end)

end

function OpenPopVehicleMenu()
	ESX.TriggerServerCallback('esx_vehicleshop:getCommercialVehicles', function (vehicles)
		local elements = {}

		for i=1, #vehicles, 1 do
			table.insert(elements, {
				label = ('%s [MSRP <span style="color:green;">%s</span>]'):format(vehicles[i].name, _U('generic_shopitem', ESX.Math.GroupDigits(vehicles[i].price))),
				value = vehicles[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'commercial_vehicles',
		{
			title    = _U('vehicle_dealer'),
			align    = 'right',
			elements = elements
		}, function (data, menu)
			local model = data.current.value

			DeleteShopInsideVehicles()

			ESX.Game.SpawnVehicle(model, Config.Zones.ShopInside.Pos, Config.Zones.ShopInside.Heading, function (vehicle)
				table.insert(LastVehicles, vehicle)

				for i=1, #Vehicles, 1 do
					if model == Vehicles[i].model then
						CurrentVehicleData = Vehicles[i]
						break
					end
				end
			end)
		end, function (data, menu)
			menu.close()
		end)
	end)
end

function OpenRentedVehiclesMenu()
	ESX.TriggerServerCallback('esx_vehicleshop:getRentedVehicles', function (vehicles)
		local elements = {}

		for i=1, #vehicles, 1 do
			table.insert(elements, {
				label = ('%s: %s - <span style="color:orange;">%s</span>'):format(vehicles[i].playerName, vehicles[i].name, vehicles[i].plate),
				value = vehicles[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'rented_vehicles', {
			title    = _U('rent_vehicle'),
			align    = 'right',
			elements = elements
		}, nil, function (data, menu)
			menu.close()
		end)
	end)
end

function OpenBossActionsMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'reseller',{
		title    = _U('dealer_boss'),
		align    = 'right',
		elements = {
			{label = _U('boss_actions'), value = 'boss_actions'},
			{label = _U('boss_sold'), value = 'sold_vehicles'}
		}
	}, function (data, menu)
		if data.current.value == 'boss_actions' then
			TriggerEvent('esx_society:openBossMenu', 'cardealer', function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'sold_vehicles' then

			ESX.TriggerServerCallback('esx_vehicleshop:getSoldVehicles', function(customers)
				local elements = {
					head = { _U('customer_client'), _U('customer_model'), _U('customer_plate'), _U('customer_soldby'), _U('customer_date') },
					rows = {}
				}
		
				for i=1, #customers, 1 do
					table.insert(elements.rows, {
						data = customers[i],
						cols = {
							customers[i].client,
							customers[i].model,
							customers[i].plate,
							customers[i].soldby,
							customers[i].date
						}
					})
				end

				ESX.UI.Menu.Open('list', GetCurrentResourceName(), 'sold_vehicles', elements, function(data2, menu2)

				end, function(data2, menu2)
					menu2.close()
				end)
			end)
		end

	end, function (data, menu)
		menu.close()

		CurrentAction     = 'boss_actions_menu'
		CurrentActionMsg  = _U('shop_menu')
		CurrentActionData = {}
	end)
end


function OpenGetStocksMenu()
	ESX.TriggerServerCallback('esx_vehicleshop:getStockItems', function (items)
		local elements = {}

		for i=1, #items, 1 do
			table.insert(elements, {
				label = 'x' .. items[i].count .. ' ' .. items[i].label,
				value = items[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = _U('dealership_stock'),
			align    = 'right',
			elements = elements
		}, function (data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
				title = _U('amount')
			}, function (data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('quantity_invalid'))
				else
					TriggerServerEvent('esx_vehicleshop:getStockItem', itemName, count)
					menu2.close()
					menu.close()
					OpenGetStocksMenu()
				end
			end, function (data2, menu2)
				menu2.close()
			end)

		end, function (data, menu)
			menu.close()
		end)
	end)
end

function OpenPutStocksMenu()
	ESX.TriggerServerCallback('esx_vehicleshop:getPlayerInventory', function (inventory)
		local elements = {}

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type = 'item_standard',
					value = item.name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu',
		{
			title    = _U('inventory'),
			align    = 'right',
			elements = elements
		}, function (data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
				title = _U('amount')
			}, function (data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('quantity_invalid'))
				else
					TriggerServerEvent('esx_vehicleshop:putStockItems', itemName, count)
					menu2.close()
					menu.close()
					OpenPutStocksMenu()
				end

			end, function (data2, menu2)
				menu2.close()
			end)

		end, function (data, menu)
			menu.close()
		end)
	end)
end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function (job)
	ESX.PlayerData.job = job

	if Config.EnablePlayerManagement then
		if ESX.PlayerData.job.name == 'cardealer' then
			Config.Zones.ShopEntering.Type = 1

			if ESX.PlayerData.job.grade_name == 'boss' then
				Config.Zones.BossActions.Type = 1
			end

		else
			Config.Zones.ShopEntering.Type = -1
			Config.Zones.BossActions.Type  = -1
		end
	end
end)

AddEventHandler('esx_vehicleshop:hasEnteredMarker', function (zone)
	if zone == 'ShopEntering' then

		if Config.EnablePlayerManagement then
			if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'cardealer' then
				CurrentAction     = 'reseller_menu'
				CurrentActionMsg  = _U('shop_menu')
				CurrentActionData = {}
			end
		else
			CurrentAction     = 'shop_menu'
			CurrentActionMsg  = _U('shop_menu')
			CurrentActionData = {}
		end

	elseif zone == 'GiveBackVehicle' and Config.EnablePlayerManagement then

		local playerPed = PlayerPedId()

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed, false)

			CurrentAction     = 'give_back_vehicle'
			CurrentActionMsg  = _U('vehicle_menu')

			CurrentActionData = {
				vehicle = vehicle
			}
		end

	elseif zone == 'ResellVehicle' then

		local playerPed = PlayerPedId()

		if IsPedSittingInAnyVehicle(playerPed) then

			local vehicle     = GetVehiclePedIsIn(playerPed, false)
			local vehicleData, model, resellPrice, plate

			if GetPedInVehicleSeat(vehicle, -1) == playerPed then
				for i=1, #Vehicles, 1 do
					if GetHashKey(Vehicles[i].model) == GetEntityModel(vehicle) then
						vehicleData = Vehicles[i]
						break
					end
				end
	
				resellPrice = ESX.Math.Round(vehicleData.price / 100 * Config.ResellPercentage)
				model = GetEntityModel(vehicle)
				plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
	
				CurrentAction     = 'resell_vehicle'
				CurrentActionMsg  = _U('sell_menu', vehicleData.name, ESX.Math.GroupDigits(resellPrice))
	
				CurrentActionData = {
					vehicle = vehicle,
					label = vehicleData.name,
					price = resellPrice,
					model = model,
					plate = plate
				}
			end

		end

	elseif zone == 'BossActions' and Config.EnablePlayerManagement and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'cardealer' and ESX.PlayerData.job.grade_name == 'boss' then

		CurrentAction     = 'boss_actions_menu'
		CurrentActionMsg  = _U('shop_menu')
		CurrentActionData = {}

	end
end)

AddEventHandler('esx_vehicleshop:hasExitedMarker', function (zone)
	if not IsInShopMenu then
		ESX.UI.Menu.CloseAll()
	end

	CurrentAction = nil
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if IsInShopMenu then
			ESX.UI.Menu.CloseAll()

			DeleteShopInsideVehicles()

			local playerPed = PlayerPedId()

			FreezeEntityPosition(playerPed, false)
			SetEntityVisible(playerPed, true)
			SetEntityCoords(playerPed, Config.Zones.ShopEntering.Pos.x, Config.Zones.ShopEntering.Pos.y, Config.Zones.ShopEntering.Pos.z)
		end
	end
end)

-- Create Blips
Citizen.CreateThread(function ()
	local blip = AddBlipForCoord(Config.Zones.ShopEntering.Pos.x, Config.Zones.ShopEntering.Pos.y, Config.Zones.ShopEntering.Pos.z)

	SetBlipSprite (blip, 225)
	SetBlipDisplay(blip, 4)
	SetBlipColour(blip, 46)
	SetBlipScale  (blip, 0.8)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("CarDealer")
	EndTextCommandSetBlipName(blip)
end)

-- Display markers
Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)

		local coords = GetEntityCoords(PlayerPedId())

		for k,v in pairs(Config.Zones) do
			if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			end
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)

		local coords      = GetEntityCoords(PlayerPedId())
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(Config.Zones) do
			if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
				isInMarker  = true
				currentZone = k
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone                = currentZone
			TriggerEvent('esx_vehicleshop:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_vehicleshop:hasExitedMarker', LastZone)
		end
	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if CurrentAction == nil then
			Citizen.Wait(500)
		else

			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, Keys['E']) then
				if CurrentAction == 'shop_menu' then

					if Config.LicenseEnable then

						ESX.TriggerServerCallback('esx_license:checkLicense', function(hasDriversLicense)
							if hasDriversLicense then
								OpenShopMenu()
							else
								ESX.ShowNotification(_U('license_missing'))
							end
						end, GetPlayerServerId(PlayerId()), 'drive')

					else
						OpenShopMenu()
					end

				elseif CurrentAction == 'reseller_menu' then
					OpenResellerMenu()
				elseif CurrentAction == 'give_back_vehicle' then

					ESX.TriggerServerCallback('esx_vehicleshop:giveBackVehicle', function(isRentedVehicle)
						if isRentedVehicle then
							ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
							ESX.ShowNotification(_U('delivered'))
						else
							ESX.ShowNotification(_U('not_rental'))
						end
					end, ESX.Math.Trim(GetVehicleNumberPlateText(CurrentActionData.vehicle)))

				elseif CurrentAction == 'resell_vehicle' then

					ESX.TriggerServerCallback('esx_vehicleshop:resellVehicle', function(vehicleSold)

						if vehicleSold then
							ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
							ESX.ShowNotification(_U('vehicle_sold_for', CurrentActionData.label, ESX.Math.GroupDigits(CurrentActionData.price)))
						else
							ESX.ShowNotification(_U('not_yours'))
						end

					end, CurrentActionData.plate, CurrentActionData.model)

				elseif CurrentAction == 'boss_actions_menu' then
					OpenBossActionsMenu()
				end

				CurrentAction = nil
			end
		end
	end
end)

Citizen.CreateThread(function()
	RequestIpl('shr_int') -- Load walls and floor

	local interiorID = 7170
	LoadInterior(interiorID)
	EnableInteriorProp(interiorID, 'csr_beforeMission') -- Load large window
	RefreshInterior(interiorID)
end)

function drawLoadingText(text, red, green, blue, alpha)
	SetTextFont(4)
	SetTextProportional(0)
	SetTextScale(0.0, 0.5)
	SetTextColour(red, green, blue, alpha)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)

	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(0.5, 0.5)
end