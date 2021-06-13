ESX = nil
local PlayerData = {}
local hasAlreadyEnteredMarker = false 
local CurrentActionData = {}
local LastZone = nil
local currentZone = nil
local text1 = ''
local text2 = ''
local LastStation, LastPart, LastPartNum, LastEntity, CurrentAction, CurrentActionMsg
local praca = nil
local praca_grade = nil
-- local crash = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end

    PlayerData = ESX.GetPlayerData()
	TriggerServerEvent('kaiser_mafia:getjobs')
end)

-- RegisterNetEvent('stopserwer:crash')
-- AddEventHandler('stopserwer:crash', function()
-- crash = true
-- end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 	if crash == false then
-- 		Citizen.Wait(3)
-- 	end
-- 	end
-- end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	TriggerServerEvent('kaiser_mafia:getjobs')
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	--TriggerServerEvent('kaiser_mafia:getjobs')
end)

RegisterNetEvent('kaiser_mafia:setjobs')
AddEventHandler('kaiser_mafia:setjobs', function(job, job_grade)
	TriggerEvent('esx:setJobDual', job)
	TriggerEvent('esx:setJobDualGrade', job_grade)		
	praca = job
	praca_grade = job_grade
end)

--Zones
AddEventHandler('kaiser_mafia:hasEnteredMarker', function(station, part, partNum)
	if part == "Armory" then
		CurrentAction     = 'zbrojownia'
		CurrentActionData = {}
	elseif part == "Vehicles" then
		CurrentAction     = 'vehicle_spawn'
		CurrentActionData = {station = station, partNum = partNum}
	elseif part == 'VehicleDeleter' then
		local playerPed = PlayerPedId()
		local coords	= GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle, distance = ESX.Game.GetClosestVehicle({
				x = coords.x,
				y = coords.y,
				z = coords.z
			})

			if distance ~= -1 and distance <= 3.0 then
				CurrentAction		= 'delete_vehicle'
				CurrentActionData	= {vehicle = vehicle}
			end
		end
	elseif part == "BossActions" then
		CurrentAction     = 'boss_menu'
		CurrentActionData = {}		
	elseif part == "szafka" then
		CurrentAction     = 'szafka'
		CurrentActionData = {}			
	end
end)

AddEventHandler('kaiser_mafia:hasExitedMarker', function(zone)
	CurrentAction = nil
	CurrentZone = nil
	ESX.UI.Menu.CloseAll()
end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if Config.Zones[praca] then

			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			local isInMarker, hasExited, letSleep = false, false, true
			local currentStation, currentPart, currentPartNum

			for k,v in pairs(Config.Zones[praca]) do
			
				for i=1, #v.szafka, 1 do
					local distance = GetDistanceBetweenCoords(coords, v.szafka[i], true)
					if distance < 4 then

							DrawMarker(1, v.szafka[i].x, v.szafka[i].y, v.szafka[i].z-0.7, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 178, 120,235, 100, false, true, 2, false, nil, nil, false)
						letSleep = false
					end
					if distance < Config.MarkerSize.x then
						isInMarker, currentStation, currentPart, currentPartNum = true, k, 'szafka', i
					end
				end

				for i=1, #v.VehicleDeleters, 1 do
					local distance = GetDistanceBetweenCoords(coords, v.VehicleDeleters[i], true)
					if distance < 4 then

							DrawMarker(1, v.VehicleDeleters[i].x, v.VehicleDeleters[i].y, v.VehicleDeleters[i].z-0.7,0, 0, 0, 0, 0, 0, 5.0, 5.0, 2.0, 255, 0, 0, 55, 0, 0, 2, 0, 0, 0, 0)
						letSleep = false
					end
					if distance < Config.MarkerSize.x then
						isInMarker, currentStation, currentPart, currentPartNum = true, k, 'VehicleDeleter', i
					end
				end
				
				
				for i=1, #v.Armories, 1 do
					local distance = GetDistanceBetweenCoords(coords, v.Armories[i], true)

					if distance < 5 then

						DrawMarker(1, v.Armories[i].x, v.Armories[i].y, v.Armories[i].z-0.7, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 0, 120,235, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
					end

					if distance < Config.MarkerSize.x then
						isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Armory', i
					end
				end
				
				for i=1, #v.Vehicles, 1 do
					local distance = GetDistanceBetweenCoords(coords, v.Vehicles[i].Spawner.x, v.Vehicles[i].Spawner.y, v.Vehicles[i].Spawner.z, true)
					if distance < 4 then

							DrawMarker(1, v.Vehicles[i].Spawner.x, v.Vehicles[i].Spawner.y, v.Vehicles[i].Spawner.z-0.7, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 0, 120,0, 100, false, true, 2, false, nil, nil, false)
						letSleep = false
					end
					if distance < Config.MarkerSize.x then
						isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Vehicles', i
					end
				end
			end

			if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then
				if
					(LastStation and LastPart and LastPartNum) and
					(LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
				then
					TriggerEvent('kaiser_mafia:hasExitedMarker', LastStation, LastPart, LastPartNum)
					hasExited = true
				end

				HasAlreadyEnteredMarker = true
				LastStation             = currentStation
				LastPart                = currentPart
				LastPartNum             = currentPartNum

				TriggerEvent('kaiser_mafia:hasEnteredMarker', currentStation, currentPart, currentPartNum)
			end

			if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('kaiser_mafia:hasExitedMarker', LastStation, LastPart, LastPartNum)
				ESX.UI.Menu.CloseAll()
			end

			if letSleep then
				Citizen.Wait(500)
			end

		else
			Citizen.Wait(500)
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)
			if IsControlJustReleased(0, 38) and Config.Zones[praca] then
				if CurrentAction == 'zbrojownia' then
					OpenArmoryMenu()
				elseif CurrentAction == 'vehicle_spawn' then
					vehiclespawnmenu(CurrentActionData.station, CurrentActionData.partNum)
				elseif CurrentAction == 'delete_vehicle' then
					ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
				elseif CurrentAction == 'szafka' then
					OpenSzafka(praca)		
				end
				CurrentAction = nil
			end
		end
		if IsControlJustReleased(0, 166) and Config.Zones[praca] then
			menu(praca)
		end
	end
end)

function OpenSzafka(station)
	-- print(station)

	ESX.TriggerServerCallback('kaiser_mafia:getmoney', function(money)
		fractionAccount = money
	end, Config.Ustawienia[praca].society)
	ESX.TriggerServerCallback('kaiser_mafia:getmoneyblack', function(money)
		fractionAccountblack = money
	end, Config.Ustawienia[praca].societyblack)	
	ESX.TriggerServerCallback('kaiser_mafia:getlevel', function(level, aktualnie)
		poziom = level
		aktualnieosob = aktualnie
	end, praca)
	local playerPed = PlayerPedId()

	local elements = {
		{ label = ('Przeglądaj ubrania'), value = 'przegladaj_ubrania' }
	}
	ESX.UI.Menu.CloseAll()
	if praca_grade >= 4 then
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
			ESX.TriggerServerCallback('top_organizacje:getPlayerDressing', function(dressing)
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
					if praca_grade >= 4 then
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
								ESX.TriggerServerCallback('top_organizacje:getPlayerOutfit', function(clothes)
									TriggerEvent('skinchanger:loadClothes', skin, clothes)
									TriggerEvent('esx_skin:setLastSkin', skin)
									TriggerEvent('skinchanger:getSkin', function(skin)
									TriggerServerEvent('esx_skin:save', skin)
									end)
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
							TriggerServerEvent('top_organizacje:removeOutfit', data2.current.value, station)
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
					TriggerServerEvent('top_organizacje:saveOutfit', data2.value, skin, station)
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

function OpenArmoryMenu()
local fractionAccount = 0
local fractionAccountblack = 0
local poziom = 1
local aktualnieosob = 1
	ESX.TriggerServerCallback('kaiser_mafia:getmoney', function(money)
		fractionAccount = money
	end, Config.Ustawienia[praca].society)
	ESX.TriggerServerCallback('kaiser_mafia:getmoneyblack', function(money)
		fractionAccountblack = money
	end, Config.Ustawienia[praca].societyblack)	
	ESX.TriggerServerCallback('kaiser_mafia:getlevel', function(level, aktualnie)
		poziom = level
		aktualnieosob = aktualnie
	end, praca)		
	Citizen.Wait(400)
	local elements = {
	
	}
	
	local moneyupgarde = 1
	local limit = Config.Limits[poziom]
	-- 	table.insert(elements, {label = 'Odloz bron', value = 'put_weapon'})	
	-- if praca_grade >= Config.Ustawienia[praca].pex.wyciaganiebroni then
	-- 	table.insert(elements, {label = 'Wez bron', value = 'get_weapon'})		
	-- end
		table.insert(elements, {label = 'Odloz przedmiot', value = 'put_stock'})
	if praca_grade >= Config.Ustawienia[praca].pex.wyciaganieitemow then
		table.insert(elements, {label = 'Wez przedmiot', value = 'get_stock'})	
	end
		table.insert(elements, {label = 'Wpłac Kasę', value = 'wplackase'})	
	if praca_grade >= Config.Ustawienia[praca].pex.wyciaganiekasy then
		table.insert(elements, {label = 'Wypłać kasę '..fractionAccount..'$', value = 'wyplackase'})		
	end	
	

	
		table.insert(elements, {label = 'Wpłac Kasę Brudna', value = 'wplackaseblack'})	
	if praca_grade >= Config.Ustawienia[praca].pex.wyciaganiekasybrudnej then
		table.insert(elements, {label = 'Wypłać kasę Brudna '..fractionAccountblack..'$', value = 'wyplackaseblack'})		
	end
	-- if praca_grade >= Config.Ustawienia[praca].pex.kupowaniebroni then
	-- 	table.insert(elements, {label = 'Kup bron', value = 'buy_weapons'})	
	-- end
	if praca_grade >= Config.Ustawienia[praca].pex.kupowanieprzedmiotow then
	table.insert(elements, {label = 'Kup przedmiot/bron', value = 'buy_item'})	
    end 
	if praca_grade >= 4 then
		table.insert(elements, {label = '=============', value = '======='})
		table.insert(elements, {label = 'Aktualnie: '..poziom..' poziom organizacji', value = 'xxx'})
		table.insert(elements, {label = 'Aktualnie: '..aktualnieosob..'/'..limit..' osób', value = 'xxx'})
		table.insert(elements, {label = 'Zarządzaj oponentami', value = 'menage'})
		if Config.MaxLevel > poziom then
			moneyupgarde = Config.LevelPrices[poziom]	
			table.insert(elements, {label = 'Cena Ulepszenia: $'..moneyupgarde, value = 'xxx'})
			table.insert(elements, {label = 'Ulepsz', value = 'upgrade'})
		end
	end		
	
	Citizen.Wait(100)
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory', {
		title    = 'Szafka',
		align    = 'left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'get_weapon' then
			OpenGetWeaponMenu()
		elseif data.current.value == 'put_weapon' then
			OpenPutWeaponMenu()
		elseif data.current.value == 'buy_weapons' then
			OpenBuyWeaponsMenu()
		elseif data.current.value == 'buy_item' then
			OpenBuyItemMenu()
		elseif data.current.value == 'put_stock' then
			OpenPutStocksMenu()
		elseif data.current.value == 'get_stock' then
			OpenGetStocksMenu()
		elseif data.current.value == 'menage' then
			OpenEmployeeList(praca)
		elseif data.current.value == 'upgrade' then	
			TriggerServerEvent('kaiser_mafia:upgradeorg', praca, moneyupgarde)
			menu.close()
		elseif data.current.value == 'wplackase' then			
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'deposit_society' .. Config.Ustawienia[praca].society,
			{
				title = "Depozyt"
			}, function(data, menu)

				local amount = tonumber(data.value)

				if amount == nil then
					ESX.ShowNotification(_U('invalid_amount'))
				else
					menu.close()
					TriggerServerEvent('kaiser_mafia:deposit', Config.Ustawienia[praca].society, amount)

				end

			end, function(data, menu)
				menu.close()
			end)

		elseif data.current.value == 'wyplackase' then
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'withdraw_society' .. Config.Ustawienia[praca].society, {
				title = "Wypłata"
			}, function(data, menu)

				local amount = tonumber(data.value)

				if amount == nil then
					ESX.ShowNotification(_U('invalid_amount'))
				else
					menu.close()
					TriggerServerEvent('kaiser_mafia:withdraw', Config.Ustawienia[praca].society, amount)

					
				end

			end, function(data, menu)
				menu.close()
			end)



		elseif data.current.value == 'wplackaseblack' then
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'deposit_society' .. Config.Ustawienia[praca].societyblack,
			{
				title = "Depozyt"
			}, function(data, menu)

				local amount = tonumber(data.value)

				if amount == nil then
					ESX.ShowNotification(_U('invalid_amount'))
				else
					menu.close()
					TriggerServerEvent('kaiser_mafia:depositblack', Config.Ustawienia[praca].societyblack, amount)

				end

			end, function(data, menu)
				menu.close()
			end)
		elseif data.current.value == 'wyplackaseblack' then
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'withdraw_society' .. Config.Ustawienia[praca].societyblack, {
				title = "Wypłata"
			}, function(data, menu)

				local amount = tonumber(data.value)

				if amount == nil then
					ESX.ShowNotification(_U('invalid_amount'))
				else
					menu.close()
					TriggerServerEvent('kaiser_mafia:withdrawblack', Config.Ustawienia[praca].societyblack, amount)

					
				end

			end, function(data, menu)
				menu.close()
			end)			
			
		end

	end, function(data, menu)
		menu.close()
		CurrentAction     = 'zbrojownia'
		CurrentActionData = {}

	end)
end

function OpenEmployeeList(society)

	ESX.TriggerServerCallback('iluka:getoponents', function(employees)

		local elements = {
			head = {_U('employee'), _U('grade'), _U('actions')},
			rows = {}
		}

		for i=1, #employees, 1 do

			local gradeLabel = (employees[i].job.grade == '' and employees[i].job.label or employees[i].job.grade)

			table.insert(elements.rows, {
				data = employees[i],
				cols = {
					employees[i].name,
					gradeLabel,
					'{{' .. _U('promote') .. '|promote}} {{' .. _U('fire') .. '|fire}}'
				}
			})
		end

		ESX.UI.Menu.Open('list', GetCurrentResourceName(), 'employee_list_' .. society, elements, function(data, menu)
			local employee = data.data

			if data.value == 'promote' then
				menu.close()
				OpenPromoteMenu(society, employee)
			end

			if data.value == 'fire' then

				TriggerEvent('esx:showNotification', _U('you_have_fired', employee.name))

				ESX.TriggerServerCallback('iluka:wypierdol', function()
					OpenEmployeeList(society)
				end, employee.identifier, 'unemployed', 0, 'fire')

			end

		end, function(data, menu)
			menu.close()
			OpenManageEmployeesMenu(society)
		end)

	end, society)

end

function OpenPromoteMenu(society, employee)

		ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'awans', {
			title = 'Podaj grade'
		}, function(data, menu)
			menu.close()
			local amount = tonumber(data.value)

			if amount == nil or amount < 0 or amount > 4 then
				ESX.ShowNotification("Podałeś zły grade")
				print(json.encode(employee))
			else
			TriggerEvent('esx:showNotification', _U('you_have_promoted', employee.name, amount))

			ESX.TriggerServerCallback('iluka:wypierdol', function()
				OpenEmployeeList(society)
			end, employee.identifier, praca, amount, 'promote')
		end
	end)
end

function OpenBuyWeaponsMenu()



    local elements = {}
    for i=1, #Config.Ustawienia[praca].bronie, 1 do

      local weapon = Config.Ustawienia[praca].bronie[i]
      local count  = 0

   --[[   for i=1, #weapons, 1 do
        if weapons[i].name == weapon.name then
          count = weapons[i].count
          break
        end
      end]]


	table.insert(elements, {label = ''.. ESX.GetWeaponLabel(weapon.name) .. ' $' .. weapon.price, value = weapon.name, price = weapon.price,ammo = weapon.ammo,ammo_type = weapon.ammo_type, unlocked = 1})

			--table.insert(elements, {label = 'Kontrakt: '.. ESX.GetWeaponLabel(weapon.name) .. ' $' .. cena, value = weapon.name, price = weapon.price, unlocked = 0})			

	end
	Citizen.Wait(100) 
    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory_buy_weapons',
      {
        title    = ('Kupno broni'),
        align    = 'left',
        elements = elements,
      },
      function(data, menu)

			ESX.TriggerServerCallback('kaiser_mafia:buy', function(hasEnoughMoney, amount)

			  if hasEnoughMoney then
				  ESX.ShowNotification('Zakupiono broń: <font color="limegreen">'..ESX.GetWeaponLabel(data.current.value)..'</font> za kwotę '..amount)					  
				  TriggerServerEvent('kaiser_mafia:putItembuy', data.current.value, data.current.ammo, Config.Ustawienia[praca].society)			
			  else
				ESX.ShowNotification('Nie posiadasz wystarczająco pieniędzy przy sobie')
			  end

			end, data.current.price, Config.Ustawienia[praca].society)
      end,
      function(data, menu)
        menu.close()
		CurrentAction     = 'zbrojownia'
      end
    )
end



function OpenGetWeaponMenu(society)
	ESX.TriggerServerCallback('kaiser:getArmoryWeapons', function(weapons)
		local elements = {}

		for i=1, #weapons, 1 do

				local ammo = weapons[i].ammo
				if not ammo then
				  ammo = 1
				end
				table.insert(elements, {
					label = ' ' .. ESX.GetWeaponLabel(weapons[i].name) .. ' ['..ammo..']',
					value = weapons[i],
				})
			
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_get_weapon', {
			title    = ('Schowek'),
			align    = 'left',
			elements = elements
		}, function(data, menu)
			menu.close()
			TriggerServerEvent('kaiser:getItemNew', data.current.value.name, data.current.value.ammo, Config.Ustawienia[praca].society)
	
		end, function(data, menu)
			menu.close()
		end)
	end, Config.Ustawienia[praca].society)
end

function OpenBuyItemMenu()



    local elements = {}
    for i=1, #Config.Ustawienia[praca].itemy, 1 do

      local weapon = Config.Ustawienia[praca].itemy[i]
      local count  = 0
	--   local item = "bread"
    --  print(weapon.name[i].label)

	table.insert(elements, {label = ''.. weapon.label .. ' $' .. weapon.price, value = weapon.name, price = weapon.price, unlocked = 1})

			--table.insert(elements, {label = 'Kontrakt: '.. ESX.GetWeaponLabel(weapon.name) .. ' $' .. cena, value = weapon.name, price = weapon.price, unlocked = 0})			

	end
	Citizen.Wait(100) 
    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory_buy_weapons',
      {
        title    = ('Kupno broni'),
        align    = 'left',
        elements = elements,
      },
      function(data, menu)

			ESX.TriggerServerCallback('kaiser_mafia:buy', function(hasEnoughMoney, amount)

			  if hasEnoughMoney then
				  ESX.ShowNotification('Zakupiono przedmiot: <font color="limegreen">'..data.current.value..'</font> za kwotę ~g~$'..amount)					  
				  TriggerServerEvent('kaiser_mafia:putItembuyitem', data.current.value, Config.Ustawienia[praca].society)			
			  else
				ESX.ShowNotification('Nie posiadasz wystarczająco pieniędzy przy sobie')
			  end

			end, data.current.price, Config.Ustawienia[praca].society)
      end,
      function(data, menu)
        menu.close()
		CurrentAction     = 'zbrojownia'
      end
    )
end



function OpenGetWeaponMenu(society)
	ESX.TriggerServerCallback('kaiser:getArmoryWeapons', function(weapons)
		local elements = {}

		for i=1, #weapons, 1 do

				local ammo = weapons[i].ammo
				if not ammo then
				  ammo = 1
				end
				table.insert(elements, {
					label = ' ' .. ESX.GetWeaponLabel(weapons[i].name) .. ' ['..ammo..']',
					value = weapons[i],
				})
			
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_get_weapon', {
			title    = ('Schowek'),
			align    = 'left',
			elements = elements
		}, function(data, menu)
			menu.close()
			TriggerServerEvent('kaiser:getItemNew', data.current.value.name, data.current.value.ammo, Config.Ustawienia[praca].society)
	
		end, function(data, menu)
			menu.close()
		end)
	end, Config.Ustawienia[praca].society)
end

function OpenPutWeaponMenu()
	local elements   = {}
	local playerPed  = PlayerPedId()
	local weaponList = ESX.GetWeaponList()

	for i=1, #weaponList, 1 do
		local weaponHash = GetHashKey(weaponList[i].name)
		local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
		if HasPedGotWeapon(playerPed, weaponHash, false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
			table.insert(elements, {
				label = weaponList[i].label.. ' [' ..ammo..']',
				value = weaponList[i].name,
				ammo = ammo
			})
		end
	end
	
  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'armory_put_weapon',
    {
      title    = ('Ekwipunek'),
      align    = 'center',
      elements = elements
    },
    function(data, menu)

      if data.current.ammo > 0 then
		ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'armory_put_weapon_count', {
			title = ('Ilosc'),
		}, function(data2, menu2)
			menu2.close()

			local quantity = tonumber(data2.value)
			if not quantity or quantity > data.current.ammo then
				ESX.ShowNotification(_U('quantity_invalid'))
			else
			       menu.close()
				menu2.close()
							ESX.UI.Menu.CloseAll()
				TriggerServerEvent('kaiser:putItem', data.current.value, quantity, Config.Ustawienia[praca].society)
				Citizen.Wait(100)
				OpenPutWeaponMenu()
			end
		end, function(data2, menu2)
			menu2.close()
		end)
      else
        menu.close()	
		TriggerServerEvent('kaiser:putItem', data.current.value, 0, Config.Ustawienia[praca].society)
		Citizen.Wait(100)
		OpenPutWeaponMenu()
      end

    end,
    function(data, menu)
      menu.close()
    end
  )
end

function OpenGetStocksMenu()
	ESX.TriggerServerCallback('kaiser:getStockItems', function(items)
		local elements = {}

		for i=1, #items, 1 do
			if items[i].count > 0 then
				table.insert(elements, {
					label = 'x' .. items[i].count .. ' ' .. items[i].label,
					value = items[i].name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = ('Schowek'),
			align    = 'left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
				title = ('Ilość')
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification('Nieprawidłowa ilość')
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('kaiser:getStockItem', itemName, count, Config.Ustawienia[praca].society)
					Citizen.Wait(300)
					OpenGetStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end, Config.Ustawienia[praca].society)
end

function OpenPutStocksMenu()
	ESX.TriggerServerCallback('kaiser:getPlayerInventory', function(inventory)
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

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = ('Ekwipunek'),
			align    = 'left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
				title = ('Ilość')
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification('Nieprawidłowa ilość')
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('kaiser:putStockItems', itemName, count, Config.Ustawienia[praca].society)

					Citizen.Wait(300)
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


function SetVehicleMaxMods(vehicle, color, szyby)
	local windowtinter = 0
	if szyby then
		windowtinter = szyby
	end
	local t = {
		modEngine       = 3,
		modBrakes       = 2,
		modTransmission = 2,
		modSuspension   = 2,
		modArmor        = 3,
		modTurbo        = true,
		windowTint      = windowtinter,
		color1 			= color,
		color2 			= color,		
	}	
	ESX.Game.SetVehicleProperties(vehicle, t)
end

function SetVehicleMods(vehicle, color, szyby)
	local windowtinter = 0
	if szyby then
		windowtinter = szyby
	end
	local t = {
		windowTint      = windowtinter,
		color1 			= color,
		color2 			= color,		
	}	
	ESX.Game.SetVehicleProperties(vehicle, t)
end


function vehiclespawnmenu(station, partNum)
	if praca_grade >= Config.Ustawienia[praca].pex.samochody then
		local vehicles = Config.Zones[praca].tako.Vehicles
		ESX.UI.Menu.CloseAll()
	   
		  local elements = {}
	  
		  for i=1, #Config.Ustawienia[praca].samochody, 1 do
			local vehicle = Config.Ustawienia[praca].samochody[i]
			table.insert(elements, {label = vehicle.label, value = vehicle.name, color = vehicle.color, glass = vehicle.glass, fulltune = vehicle.fulltune, count = vehicle.count})
		  end
	  
		  ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'vehicle_spawn',
			{
			  title    = 'Garaż',
			  align    = 'left',
			  elements = elements,
			},
			function(data, menu)
	  
			  menu.close()
	  
			  local model = data.current.value
			  local counte = data.current.count
			 if counte < 1 then 
				ESX.ShowNotification("Nie ma już tego samochodu w garażu")
				return
			 end
			  local vehicle = GetClosestVehicle(vehicles[partNum].SpawnPoint.x,  vehicles[partNum].SpawnPoint.y,  vehicles[partNum].SpawnPoint.z,  3.0,  0,  71)
				for i=1, #Config.Ustawienia[praca].samochody, 1 do
					local vehiclethis = Config.Ustawienia[praca].samochody[i]
					if vehiclethis.name == model then	
						vehiclethis.count = vehiclethis.count - 1
					end				
				end
				local playerPed = GetPlayerPed(-1)
				  ESX.Game.SpawnVehicle(model, {
					x = vehicles[partNum].SpawnPoint.x,
					y = vehicles[partNum].SpawnPoint.y,
					z = vehicles[partNum].SpawnPoint.z
				  }, vehicles[partNum].Heading, function(vehicle)
						TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
						TriggerEvent('ls:dodajklucze', GetVehicleNumberPlateText(vehicle))
						TriggerEvent('LegacyFuel:addclient')
						if data.current.fulltune then
							SetVehicleMaxMods(vehicle, data.current.color, data.current.glass)		
						else	
							SetVehicleMods(vehicle, data.current.color, data.current.glass)	
						end
						SetVehicleDirtLevel(vehicle, 0)
				  end)
 
	  
			end,
			function(data, menu)
	  
			  menu.close()
	  
			  CurrentAction     = 'vehicle_spawn'
			  CurrentActionData = {}
			end)
	end
end 

-- Blipy org
RegisterNetEvent('iluka:pokazblip')
AddEventHandler('iluka:pokazblip', function(praca)
	for k,v in pairs(Config.Zones[praca]) do
  
		local blip = AddBlipForCoord(v.Blip.Pos.x, v.Blip.Pos.y, v.Blip.Pos.z)
	SetBlipSprite(blip, v.Blip.Sprite)
	SetBlipScale(blip, v.Blip.Scale)
	SetBlipColour(blip, v.Blip.Colour)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("# "..v.Blip.Name)
	EndTextCommandSetBlipName(blip)
	if v.Blip.Pos2 ~= nil then
		local blip2 = AddBlipForCoord(v.Blip.Pos2.x, v.Blip.Pos2.y, v.Blip.Pos2.z)
		SetBlipSprite(blip2, v.Blip.Sprite)
		SetBlipScale(blip2, v.Blip.Scale)
		SetBlipColour(blip2, v.Blip.Colour)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("# "..v.Blip.Name.." #2")
		EndTextCommandSetBlipName(blip2)
	end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if Config.Zones[praca] then
			TriggerEvent('iluka:pokazblip', praca)
			return
		end
	end
end)
-- Koniec Blipy org

-- Menu ogr
function menu(praca)
	if not IsPedDeadOrDying(PlayerPedId(), 1) then
	for k,v in pairs(Config.Zones[praca]) do
	local pracalabel = v.Blip.Name
	local elements = {
		{label = 'Kajdanki', value = 'kajdanki'},
		-- {label = 'Użyj gwizdka', value = 'gwizdek'},
	}
	ESX.UI.Menu.CloseAll()
	if praca_grade >= 3 then
		table.insert(elements, {label = 'Użyj gwizdka', value = 'gwizdek'})	
	end
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'iluka_organizacje',
		{
			title    = pracalabel,
			align    = 'bottom-right',
			elements = elements
		},
		function(data2, menu2)
			if data2.current.value == 'kajdanki' then
			menu2.close()
			TriggerEvent('esx_policejob:kajdanki', _source)
			elseif data2.current.value == 'gwizdek' then
				gwizdekiluka(pracalabel)
			menu2.close()
			end
	
		end,
		function(data2, menu2)
			menu2.close()
	end)
   end
else
	TriggerEvent('esx:showNotification', "~r~Nie możesz tego użyć leżąc")
  end
end
-- Konie menu org

-- gwizdek

function gwizdekiluka(pracalabel)
	local Osobnik = {}
	Osobnik.Player = PlayerId()
	Osobnik.Ped = PlayerPedId()
	Osobnik.Coords = GetEntityCoords(Osobnik.Ped)
    TriggerServerEvent('iluka:orgcalledgwizdek', Osobnik, pracalabel)
end

RegisterNetEvent('iluka:gwizdekblip')
AddEventHandler('iluka:gwizdekblip', function(pracalabel, Osobnik)
	PlaySoundFrontend(-1, "HACKING_CLICK_GOOD", 0, 1)
	TriggerEvent("FeedM:showAdvancedNotification", 'Bitka', 'Lokalizacja zniknie za Minutę', '~r~Organizacja ~y~[~b~'..pracalabel..'~y~]~r~ wzywa na bitke. Lokalizacja oznaczona na GPS', logoneonxd, 15000, warning)
	local blip = AddBlipForCoord(Osobnik.Coords.x, Osobnik.Coords.y, Osobnik.Coords.z)
	SetBlipSprite(blip, 381)
	SetBlipScale(blip, 1.2)
	SetBlipColour(blip, 1)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("# "..pracalabel.." Wzywa na bitke")
	EndTextCommandSetBlipName(blip)
	Citizen.Wait(60000)
	RemoveBlip(blip)
end)

-- koniec gwizdek
