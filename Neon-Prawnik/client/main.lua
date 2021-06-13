local HasAlreadyEnteredMarker, OnJob, IsNearCustomer, CustomerIsEnteringVehicle, CustomerEnteredVehicle, IsDead, CurrentActionData = false, false, false, false, false, false, {}
local CurrentCustomer, CurrentCustomerBlip, DestinationBlip, targetCoords, LastZone, CurrentAction, CurrentActionMsg

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)


function OpenCloakroomMenu(station)
	local playerPed = PlayerPedId()

	local elements = {
		{ label = ('Przeglądaj ubrania'), value = 'przegladaj_ubrania' }
	}
	ESX.UI.Menu.CloseAll()
	if ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {
			label = ('<span style="color:yellowgreen;">Dodaj ubranie</span>'),
			value = 'zapisz_ubranie' 
		})
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title    = ('Ubrania'),
		align    = 'top',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'przegladaj_ubrania' then
			ESX.TriggerServerCallback('neon-adwokat:getPlayerDressing', function(dressing)
				elements = nil
				local elements = {}
				for i=1, #dressing, 1 do
					table.insert(elements, {
						label = dressing[i],
						value = i
					})
				end
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'wszystkie_ubrania', {
					title    = ('Ubrania'),
					align    = 'top',
					elements = elements
				}, function(data2, menu2)
				
					local elements2 = {
						{ label = ('Ubierz ubranie'), value = 'ubierz_sie' },
					}
					if ESX.PlayerData.job.grade_name == 'boss' then
						table.insert(elements2, {
							label = ('<span style="color:red;"><b>Usuń ubranie</b></span>'),
							value = 'usun_ubranie' 
						})
					end
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'edycja_ubran', {
					title    = ('Ubrania'),
					align    = 'top',
					elements = elements2
				}, function(data3, menu3)
						if data3.current.value == 'ubierz_sie' then
							TriggerEvent('skinchanger:getSkin', function(skin)
								ESX.TriggerServerCallback('neon-adwokat:getPlayerOutfit', function(clothes)
									TriggerEvent('skinchanger:loadClothes', skin, clothes)
									TriggerEvent('esx_skin:setLastSkin', skin)
									ESX.ShowNotification('~g~Pomyślnie zmieniłeś swój ubiór!')
									ClearPedBloodDamage(playerPed)
									ResetPedVisibleDamage(playerPed)
									ClearPedLastWeaponDamage(playerPed)
									ResetPedMovementClipset(playerPed, 0)
									TriggerEvent('skinchanger:getSkin', function(skin)
										TriggerServerEvent('esx_skin:save', skin)
									end)
								end, data2.current.value, station)
							end)
						end
						if data3.current.value == 'usun_ubranie' then
							TriggerServerEvent('neon-adwokat:removeOutfit', data2.current.value, station)
							ESX.ShowNotification('~r~Pomyślnie usunąłeś ubiór o nazwie: ~y~' .. data2.current.label)
						end
					end, function(data3, menu3)
						menu3.close()
						
						CurrentAction     = 'menu_cloakroom'
						CurrentActionMsg  = ('~y~Naciśnij ~INPUT_CONTEXT~ aby otworzyć przebieralnie.')
						CurrentActionData = {}
					end)
					
				end, function(data2, menu2)
					menu2.close()
					
					CurrentAction     = 'menu_cloakroom'
					CurrentActionMsg  = ('~y~Naciśnij ~INPUT_CONTEXT~ aby otworzyć przebieralnie.')
					CurrentActionData = {}
				end)
			end, station)
		end
		if data.current.value == 'zapisz_ubranie' then
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'nazwa_ubioru', {
				title = ('Nazwa ubioru')
			}, function(data2, menu2)
				ESX.UI.Menu.CloseAll()

				TriggerEvent('skinchanger:getSkin', function(skin)
					TriggerServerEvent('neon-adwokat:saveOutfit', data2.value, skin, station)
					ESX.ShowNotification('~g~Pomyślnie zapisano ubiór o nazwie: ~y~' .. data2.value)
				end)
				
				CurrentAction     = 'menu_cloakroom'
				CurrentActionMsg  = ('~y~Naciśnij ~INPUT_CONTEXT~ aby otworzyć przebieralnie.')
				CurrentActionData = {}
			end, function(data2, menu2)
				menu2.close()
				
				CurrentAction     = 'menu_cloakroom'
				CurrentActionMsg  = ('~y~Naciśnij ~INPUT_CONTEXT~ aby otworzyć przebieralnie.')
				CurrentActionData = {}
			end)
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = ('~y~Naciśnij ~INPUT_CONTEXT~ aby otworzyć przebieralnie.')
		CurrentActionData = {}
	end)
end

function OpenVehicleSpawnerMenu()
	ESX.UI.Menu.CloseAll()

	local elements = {}

	if Config.EnableSocietyOwnedVehicles then

		ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(vehicles)

			for i=1, #vehicles, 1 do
				table.insert(elements, {
					label = GetDisplayNameFromVehicleModel(vehicles[i].model) .. ' [' .. vehicles[i].plate .. ']',
					value = vehicles[i]
				})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner',
			{
				title    = _U('spawn_veh'),
				align    = 'top-left',
				elements = elements
			}, function(data, menu)
				if not ESX.Game.IsSpawnPointClear(Config.Zones.VehicleSpawnPoint.Pos, 5.0) then
					ESX.ShowNotification(_U('spawnpoint_blocked'))
					return
				end

				menu.close()

				local vehicleProps = data.current.value
				ESX.Game.SpawnVehicle(vehicleProps.model, Config.Zones.VehicleSpawnPoint.Pos, Config.Zones.VehicleSpawnPoint.Heading, function(vehicle)
					ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
					local playerPed = PlayerPedId()
					TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
				end)

				TriggerServerEvent('esx_society:removeVehicleFromGarage', 'avocat', vehicleProps)

			end, function(data, menu)
				CurrentAction     = 'vehicle_spawner'
				CurrentActionMsg  = _U('spawner_prompt')
				CurrentActionData = {}

				menu.close()
			end)
		end, 'avocat')

	else

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner',
		{
			title		= _U('spawn_veh'),
			align		= 'top-left',
			elements	= Config.AuthorizedVehicles
		}, function(data, menu)
			if not ESX.Game.IsSpawnPointClear(Config.Zones.VehicleSpawnPoint.Pos, 5.0) then
				ESX.ShowNotification(_U('spawnpoint_blocked'))
				return
			end

			menu.close()
			ESX.Game.SpawnVehicle(data.current.model, Config.Zones.VehicleSpawnPoint.Pos, Config.Zones.VehicleSpawnPoint.Heading, function(vehicle)
				local playerPed = PlayerPedId()
				TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			end)
		end, function(data, menu)
			CurrentAction     = 'vehicle_spawner'
			CurrentActionMsg  = _U('spawner_prompt')
			CurrentActionData = {}

			menu.close()
		end)
	end
end

function DeleteJobVehicle()
	local playerPed = PlayerPedId()

	if Config.EnableSocietyOwnedVehicles then
		local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
		TriggerServerEvent('esx_society:putVehicleInGarage', 'avocat', vehicleProps)
		ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
	else
		if Config.AuthorizedVehicles then
			ESX.Game.DeleteVehicle(CurrentActionData.vehicle)


		else
			ESX.ShowNotification(_U('only_avocat'))
		end
	end
end

function OpenavocatActionsMenu()
	local elements = {
		{label = _U('deposit_stock'), value = 'put_stock'},
		{label = _U('take_stock'), value = 'get_stock'}
	}

	if Config.EnablePlayerManagement and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'avocat_actions', {
		title    = 'Adwokat : Menu',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'put_stock' then
			OpenPutStocksMenu()
		elseif data.current.value == 'get_stock' then
			OpenGetStocksMenu()
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('esx_society:openBossMenu', 'avocat', function(data, menu)
				menu.close()
			end, { wash = false })
		end 

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'avocat_actions_menu'
		CurrentActionMsg  = _U('press_to_open')
		CurrentActionData = {}
	end)
end

-- function AvocatMenu()
-- 	ESX.UI.Menu.CloseAll()
-- 	ESX.UI.Menu.Open('default', GetCurrentResourceName(), '', {
-- 		title    = ('Adowkat'),
-- 		align    = 'center',
-- 		elements = {
-- 			{label = ('Faktura'),       value = 'billing'},
-- 			{label = ('Pokaż Licencje'),       value = 'pokaz_licke'}
-- 		}
-- 	}, function(data, menu)
-- 		if data.current.value == 'billing' then

-- 			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
-- 				title = ('Wartosc faktury')
-- 			}, function(data, menu)
-- 				local amount = tonumber(data.value)

-- 				if amount == nil or amount < 0 then
-- 					ESX.ShowNotification('Zła wartość')
-- 				else
-- 					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
-- 					if closestPlayer == -1 or closestDistance > 3.0 then
-- 						ESX.ShowNotification('Nie ma nikogo w pobliżu')
-- 					else
-- 						menu.close()
-- 						TriggerServerEvent('xk3ly-adwokat:sendBill', GetPlayerServerId(closestPlayer), amount)
-- 					end
-- 				end
-- 			end, function(data, menu)
-- 				menu.close()
-- 			end)
-- 		elseif data.current.value == 'pokaz_licke' then
-- 			TriggerServerEvent('iluka:pokalicke_advocatr')

-- 		-- end

-- 	end
-- 	end)
-- 	-- if IsControlJustReleased(1, 177) then
-- 		menu.close()
-- end


function AvocatMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), '', {
		title    = 'Adwokat',
		align    = 'center',
		elements = {
			{label = _U('billing'),   value = 'billing'},
			{label = ('Pokaż Licencje'),   value = 'pokaz_licke'}
	}}, function(data, menu)
		if data.current.value == 'billing' then
		ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
			title = ('Wartosc faktury')
		}, function(data, menu)
			local amount = tonumber(data.value)

			if amount == nil or amount < 0 then
				ESX.ShowNotification('Zła wartość')
			else
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer == -1 or closestDistance > 3.0 then
					ESX.ShowNotification('Nie ma nikogo w pobliżu')
				else
					menu.close()
					TriggerServerEvent('xk3ly-adwokat:sendBill', GetPlayerServerId(closestPlayer), amount)
				end
			end
		end, function(data, menu)
			menu.close()
		end)

		elseif data.current.value == 'pokaz_licke' then
			TriggerServerEvent('iluka:pokalicke_advocatr')
		elseif data.current.value == 'start_job' then
			if OnJob then
				StopavocatJob()
			else
				if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'avocat' then
					local playerPed = PlayerPedId()
					local vehicle   = GetVehiclePedIsIn(playerPed, false)

					if IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(vehicle, -1) == playerPed then
						if tonumber(ESX.PlayerData.job.grade) >= 3 then
							StartavocatJob()
						else
							if IsInAuthorizedVehicle() then
								StartavocatJob()
							else
								ESX.ShowNotification(_U('must_in_avocat'))
							end
						end
					else
						if tonumber(ESX.PlayerData.job.grade) >= 3 then
							ESX.ShowNotification(_U('must_in_vehicle'))
						else
							ESX.ShowNotification(_U('must_in_avocat'))
						end
					end
				end
			end
		end
	end, function(data, menu)
		menu.close()
	end)
end

function ShowPlayerLicense(player)
	local elements = {}
	local targetName
	ESX.TriggerServerCallback('esx_avocatjob:getOtherPlayerData', function(data)
		if data.licenses ~= nil then
			for i=1, #data.licenses, 1 do
				if data.licenses[i].label ~= nil and data.licenses[i].type ~= nil then
					table.insert(elements, {label = data.licenses[i].label, value = data.licenses[i].type})
				end
			end
		end
		
		if Config.EnableESXIdentity then
			targetName = data.firstname .. ' ' .. data.lastname
		else
			targetName = data.name
		end
		
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_license',
		{
			title    = _U('license_revoke'),
			align    = 'center',
			elements = elements,
		}, function(data, menu)
			ESX.ShowNotification(_U('licence_you_revoked', data.current.label, targetName))
			TriggerServerEvent('esx_avocatjob:message', GetPlayerServerId(player), _U('license_revoked', data.current.label))
			
			TriggerServerEvent('esx_license:removeLicense', GetPlayerServerId(player), data.current.value)
			
			ESX.SetTimeout(300, function()
				ShowPlayerLicense(player)
			end)
		end, function(data, menu)
			menu.close()
		end)

	end, GetPlayerServerId(player))
end

function OpenGetStocksMenu()
	ESX.TriggerServerCallback('esx_avocatjob:getStockItems', function(items)
		local elements = {}

		for i=1, #items, 1 do
			table.insert(elements, {
				label = 'x' .. items[i].count .. ' ' .. items[i].label,
				value = items[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = 'Adwokat Stock',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('quantity_invalid'))
				else
					menu2.close()
					menu.close()

					-- todo: refresh on callback
					TriggerServerEvent('esx_avocatjob:getStockItem', itemName, count)
					Citizen.Wait(1000)
					OpenGetStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenPutStocksMenu()
	ESX.TriggerServerCallback('esx_avocatjob:getPlayerInventory', function(inventory)

		local elements = {}

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type = 'item_standard', -- not used
					value = item.name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = _U('inventory'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('quantity_invalid'))
				else
					menu2.close()
					menu.close()

					-- todo: refresh on callback
					TriggerServerEvent('esx_avocatjob:putStockItems', itemName, count)
					Citizen.Wait(1000)
					OpenPutStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

AddEventHandler('esx_avocatjob:hasEnteredMarker', function(zone)
	if zone == 'VehicleSpawner' then
		CurrentAction     = 'vehicle_spawner'
		CurrentActionMsg  = _U('spawner_prompt')
		CurrentActionData = {}
	elseif zone == 'VehicleDeleter' then
		local playerPed = PlayerPedId()
		local vehicle   = GetVehiclePedIsIn(playerPed, false)

		if IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(vehicle, -1) == playerPed then
			CurrentAction     = 'delete_vehicle'
			CurrentActionMsg  = _U('store_veh')
			CurrentActionData = { vehicle = vehicle }
		end
	elseif zone == 'avocatActions' then
		CurrentAction     = 'avocat_actions_menu'
		CurrentActionMsg  = _U('press_to_open')
		CurrentActionData = {}
	elseif zone == 'Cloakroom' then
		CurrentAction     = 'cloakroom'
		CurrentActionMsg  = _U('cloakroom_prompt')
		CurrentActionData = {}
	end
end)

AddEventHandler('esx_avocatjob:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)


-- Create Blips
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.essa.essa.Pos.x, Config.essa.essa.Pos.y, Config.essa.essa.Pos.z)

	SetBlipSprite (blip, 205)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.8)
	SetBlipColour (blip, 43)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(_U('blip_avocat'))
	EndTextCommandSetBlipName(blip)
end)

-- Enter / Exit marker avocats, and draw markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'avocat' then
			local coords = GetEntityCoords(PlayerPedId())
			local isInMarker, letSleep, currentZone = false, true

			for k,v in pairs(Config.Zones) do
				local distance = GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true)

				if v.Type ~= -1 and distance < Config.DrawDistance then
					letSleep = false
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, false, 2, v.Rotate, nil, nil, false)
				end

				if distance < v.Size.x then
					isInMarker, currentZone = true, k
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker, LastZone = true, currentZone
				TriggerEvent('esx_avocatjob:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_avocatjob:hasExitedMarker', LastZone)
			end

			if letSleep then
				Citizen.Wait(500)
			end
		else
			Citizen.Wait(1000)
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if CurrentAction and not IsDead then
			ESX.ShowHelpNotification(CurrentActionMsg)
        	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'avocat' then
				if IsControlJustReleased(0, 38) then
					if CurrentAction == 'avocat_actions_menu' then
						OpenavocatActionsMenu()
					elseif CurrentAction == 'cloakroom' then
						OpenCloakroomMenu("avocat")
					elseif CurrentAction == 'vehicle_spawner' then
						OpenVehicleSpawnerMenu()
					elseif CurrentAction == 'delete_vehicle' then
						DeleteJobVehicle()
					end
					CurrentAction = nil
				end
			end
		-- else
		-- 	Citizen.Wait(2500)
        end
		if IsControlJustReleased(0, 167) and IsInputDisabled(0) and not IsDead and ESX.PlayerData.job and ESX.PlayerData.job.name == 'avocat' then
			AvocatMenu()
		end
	end
end)

AddEventHandler('esx:onPlayerDeath', function()
	IsDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	IsDead = false
end)


RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = _U('phone_avocat'),
		number     = 'avocat',
		base64Icon = 'data:image/png;base64,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',
	}
	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

--#####################
--##### ODZNAKI #######
--#####################

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	PlayerLoaded = true
	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:dowod_pokazlicke-adwokat')
AddEventHandler('esx:dowod_pokazlicke-adwokat', function(id, imie, data, dodatek)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)
	if pid ~= -1 then
		local mugshot, mugshotStr = ESX.Game.GetPedMugshot(GetPlayerPed(pid))
		if pid == myId then
			-- PokazDokument(imie, data, dodatek, mugshotStr, 22, 22)
			TriggerEvent("FeedM:showAdvancedNotification", imie, data, dodatek, mugshotStr, 15000, 'primary')
		elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 20.00 then
			TriggerEvent("FeedM:showAdvancedNotification", imie, data, dodatek, mugshotStr, 15000, 'primary')
		end
		UnregisterPedheadshot(mugshot)
	end
end)

-- function PokazDokument(title, subject, msg, icon, iconType, color)
--     SetNotificationTextEntry('STRING')
--     SetNotificationBackgroundColor(1)
-- 	AddTextComponentString(msg)
-- 	SetNotificationMessage(icon, icon, false, iconType, title, subject)
-- 	DrawNotification(false, false)
-- end