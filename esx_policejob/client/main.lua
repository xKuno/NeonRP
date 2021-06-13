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

local PlayerData              = {}
local HasAlreadyEnteredMarker = false
local LastStation             = nil
local LastPart                = nil
local LastPartNum             = nil
local LastEntity              = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local IsHandcuffed            = false
local HandcuffTimer           = nil
local IsDragged               = false
local CopPed                  = 0
local hasAlreadyJoined        = false
local blipsCops               = {}
local isDead                  = false
local CurrentTask             = {}
local swat = false
local ocean = false
local air = false
local seuoffroad = false
local seu = false
local odprzodu = false
local odtylu = false
ESX                           = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end

	Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()
	Citizen.Wait(2000)	
	ESX.TriggerServerCallback('esx_license:checkLicense', function(lickajest)
		if lickajest then
			swat = true
		else
			swat = false
		end
	end, GetPlayerServerId(PlayerId()), 'police_swat')	
	ESX.TriggerServerCallback('esx_license:checkLicense', function(lickajest)
		if lickajest then
			ocean = true
		else
			ocean = false
		end
	end, GetPlayerServerId(PlayerId()), 'police_ocean')	
	ESX.TriggerServerCallback('esx_license:checkLicense', function(lickajest)
		if lickajest then
			air = true
		else
			air = false
		end
	end, GetPlayerServerId(PlayerId()), 'police_air')	
	ESX.TriggerServerCallback('esx_license:checkLicense', function(lickajest)
		if lickajest then
			seuoffroad = true
		else
			seuoffroad = false
		end
	end, GetPlayerServerId(PlayerId()), 'police_seuoffroad')	
	ESX.TriggerServerCallback('esx_license:checkLicense', function(lickajest)
		if lickajest then
			seu = true
		else
			seu = false
		end
	end, GetPlayerServerId(PlayerId()), 'police_seu')		
end)

function SetVehicleMaxMods(vehicle)
	local props = {
		modEngine       = 4,
		modBrakes       = 3,
		modTransmission = 2,
		modSuspension   = 3,
		modTurbo        = true,
	}

	ESX.Game.SetVehicleProperties(vehicle, props)
end

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

function setUniform(job, playerPed)
  TriggerEvent('skinchanger:getSkin', function(skin)
    if skin.sex == 0 then
      if Config.Uniforms[job].male ~= nil then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
      else
        ESX.ShowNotification(_U('no_outfit'))
      end
      if job == 'CTTF_wear' or job == 'SAST_1_wear' or job == 'SAST_2_wear' then
        SetPedArmour(playerPed, 90)
      end
    else
      if Config.Uniforms[job].female ~= nil then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
      else
        ESX.ShowNotification(_U('no_outfit'))
      end
      if job == 'CTTF_wear' or job == 'SAST_1_wear' or job == 'SAST_2_wear' then
        SetPedArmour(playerPed, 90)
      end
    end

  end)
end

function OpenCloakroomMenu()

  local playerPed = PlayerPedId()

  local elements = {
    { label = _U('citizen_wear'), value = 'citizen_wear' },
    { label = '------ Kamizelki ------', value = 'esa' },
    { label = 'Kamizelka SAST 1', value = 'SAST_1_wear' },
    { label = 'Kamizelka SAST 2', value = 'SAST_2_wear' },
    { label = '------ Treningowe ------', value = 'esa' },
    { label = 'Strój treningowy', value = 'treningowy_wear' },
    { label = '------ Mundur ------', value = 'esa' },
  }

  if PlayerData.job.grade_name == 'Cadet' or PlayerData.job.grade_name == 'DeputyTropper' or PlayerData.job.grade_name == 'Tropper1step2' or PlayerData.job.grade_name == 'Tropper1step3' then
    table.insert(elements, {label = _U('police_wear'), value = 'cadet_Trooper_1_step_3'})
  end

  if PlayerData.job.grade_name == 'Tropper2step1' or PlayerData.job.grade_name == 'Tropper2step2' or PlayerData.job.grade_name == 'Tropper2step3' then
    table.insert(elements, {label = _U('police_wear'), value = 'Trooper_2_step_1_Trooper_2_step_3'})
    table.insert(elements, {label = 'Strój motocyklowy', value = 'motor_wear'})
  end

  if PlayerData.job.grade_name == 'Tropper3step1' or PlayerData.job.grade_name == 'Tropper3step2' or PlayerData.job.grade_name == 'Tropper3step3' then
    table.insert(elements, {label = _U('police_wear'), value = 'Trooper_3_step_1_Trooper_3'})
  end

  if PlayerData.job.grade_name == 'SeniorTropper' or PlayerData.job.grade_name == 'SergeantI' or PlayerData.job.grade_name == 'SergeantII' or PlayerData.job.grade_name == 'SergeantIII' or PlayerData.job.grade_name == 'SeniorSergeant' then
    table.insert(elements, {label = _U('police_wear'), value = 'Senior_Trooper_DO_Senior_Sergeant'})
  end


  if PlayerData.job.grade_name == 'CapitanI' or PlayerData.job.grade_name == 'CapitanII' or PlayerData.job.grade_name == 'CapitanIII' or PlayerData.job.grade_name == 'SeniorCapitan' then
    table.insert(elements, {label = _U('police_wear'), value = 'capitan_1_senior_capitan'})
  end

  if PlayerData.job.grade_name == 'sergeantII' then
    table.insert(elements, {label = _U('police_wear'), value = 'sergeant_wear'})
  end
  
    if PlayerData.job.grade_name == 'sergeantIII' then
    table.insert(elements, {label = _U('police_wear'), value = 'sergeant_wear'})
  end

  if PlayerData.job.grade_name == 'detektywI' then
    table.insert(elements, {label = _U('police_wear'), value = 'dzielnicowy_wear'})
  end

  if PlayerData.job.grade_name == 'detektywII' then
    table.insert(elements, {label = _U('police_wear'), value = 'zastepca_wear'})
  end
  
    if PlayerData.job.grade_name == 'detektywIII' then
    table.insert(elements, {label = _U('police_wear'), value = 'zastepca_wear'})
  end

    if PlayerData.job.grade_name == 'porucznikI' then
    table.insert(elements, {label = _U('police_wear'), value = 'lieutenant_wear'})
  end

    if PlayerData.job.grade_name == 'porucznikII' then
    table.insert(elements, {label = _U('police_wear'), value = 'lieutenant_wear'})
  end

    if PlayerData.job.grade_name == 'porucznikIII' then
    table.insert(elements, {label = _U('police_wear'), value = 'lieutenant_wear'})
  end

    if PlayerData.job.grade_name == 'kapitanI' then
    table.insert(elements, {label = _U('police_wear'), value = 'capitan_wear'})
  end

    if PlayerData.job.grade_name == 'kapitanII' then
    table.insert(elements, {label = _U('police_wear'), value = 'capitan_wear'})
  end

    if PlayerData.job.grade_name == 'vkomendant' then
    table.insert(elements, {label = _U('police_wear'), value = 'vkomendantkurwa_wear'})
  end

  if PlayerData.job.grade_name == 'komendant' then
    table.insert(elements, {label = _U('police_wear'), value = 'commandant_wear'})
  end

  if PlayerData.job.grade_name == 'Vszef' then
    table.insert(elements, {label = _U('police_wear'), value = 'szef_bsco'})
  end

  if PlayerData.job.grade_name == 'viceboss' then
    table.insert(elements, {label = _U('police_wear'), value = 'zastepca_wear'})
  end

  if PlayerData.job.grade_name == 'boss' then
    table.insert(elements, {label = 'Mundur #1', value = 'boss_wear'})
    table.insert(elements, {label = 'Mundur #2', value = 'zarzad'})
  end
  if seu then 
  
  end
  if swat then
    table.insert(elements, { label = '------ CTTF ------ ', value = 'esa' })
    table.insert(elements, { label = 'Kamizelka CTTF', value = 'CTTF_wear2' })
    table.insert(elements, { label = 'Strój CTTF', value = 'CTTF_wear' })
  end
  if ocean then
  
  end
  if air then
    table.insert(elements, { label = '------ AIR SUPPORT ------ ', value = 'esa' })
    table.insert(elements, { label = 'Strój pilota', value = 'pilothelki_wear' })
  end
  
  if seuoffroad then
  
  end

  if Config.EnableNonFreemodePeds then
    table.insert(elements, {label = _U('sheriff_wear'), value = 'sheriff_wear_freemode', maleModel = 's_m_y_sheriff_01', femaleModel = 's_f_y_sheriff_01'})
    table.insert(elements, {label = _U('lieutenant_wear'), value = 'lieutenant_wear_freemode', maleModel = 's_m_y_swat_01', femaleModel = 's_m_y_swat_01'})
    table.insert(elements, {label = _U('commandant_wear'), value = 'commandant_wear_freemode', maleModel = 's_m_y_swat_01', femaleModel = 's_m_y_swat_01'})
  end

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'cloakroom',
    {
      title    = _U('cloakroom'),
      align    = 'bottom-right',
      elements = elements,
    },
    function(data, menu)

      cleanPlayer(playerPed)

      if data.current.value == 'citizen_wear' then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
          TriggerEvent('skinchanger:loadSkin', skin)
        end)
      end

      if
        data.current.value == 'cadet_Trooper_1_step_3' or
        data.current.value == 'Trooper_2_step_1_Trooper_2_step_3' or
        data.current.value == 'treningowy_wear' or
        data.current.value == 'motor_wear' or
        data.current.value == 'zarzad' or
        data.current.value == 'pilothelki_wear' or
        data.current.value == 'Trooper_3_step_1_Trooper_3' or			
        data.current.value == 'Senior_Trooper_DO_Senior_Sergeant' or
        data.current.value == 'capitan_1_senior_capitan' or
        data.current.value == 'bullet_wear' or
        data.current.value == 'gilet_wear' or
	data.current.value == 'vszef_wear' or
	data.current.value == 'oficer_wear' or
	data.current.value == 'dzielnicowy_wear' or
	data.current.value == 'capitan_wear' or
        data.current.value == 'zastepca_wear' or
	data.current.value == 'swat_wear' or
  data.current.value == 'boss_wear' or
  data.current.value == 'CTTF_wear2' or
  data.current.value == 'SAST_1_wear' or
  data.current.value == 'SAST_2_wear' or
  data.current.value == 'CTTF_wear'
      then
        setUniform(data.current.value, playerPed)
      end

      if
        data.current.value == 'sheriff_wear_freemode' or
        data.current.value == 'lieutenant_wear_freemode' or
        data.current.value == 'commandant_wear_freemode'
      then
        local model = nil
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
          if skin.sex == 0 then
            model = GetHashKey(data.current.maleModel)
          else
            model = GetHashKey(data.current.femaleModel)
          end
        end)
      
        RequestModel(model)
        while not HasModelLoaded(model) do
          RequestModel(model)
          Citizen.Wait(1)
        end
      
        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)
      end

      CurrentAction     = 'menu_cloakroom'
      CurrentActionMsg  = _U('open_cloackroom')
      CurrentActionData = {}

    end,
    function(data, menu)
      menu.close()
      CurrentAction     = 'menu_cloakroom'
      CurrentActionMsg  = _U('open_cloackroom')
      CurrentActionData = {}
    end
  )
end

function OpenArmoryMenu(station)

  if Config.EnableArmoryManagement then

    local elements = {
      -- {label = _U('get_weapon'),     value = 'get_weapon'},
      -- {label = _U('put_weapon'),     value = 'put_weapon'},
      {label = _U('remove_object'),  value = 'get_stock'},
      {label = _U('deposit_object'), value = 'put_stock'},	  
      {label = "Weź Radio",  value = 'radio'},
      {label = "Weź GPS",  value = 'GPS'},
  }

    if PlayerData.job.grade_name == 'boss' or 
	PlayerData.job.grade_name == 'viceboss' or 
        PlayerData.job.grade_name == 'sheriff' or
	PlayerData.job.grade_name == 'Vszef' or 
	PlayerData.job.grade_name == 'komendant'  then
      table.insert(elements, {label = _U('buy_weapons'), value = 'buy_weapons'})
    end
	-- if swat then
  --     table.insert(elements, {label = "SWAT", value = 'swat'})		
	-- end

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory',
      {
        title    = _U('armory'),
        align    = 'bottom-right',
        elements = elements,
      },
      function(data, menu)
        if data.current.value == 'nadajson' then
          TriggerServerEvent('esx_policejob:giveItem', 'nadajson', 1)
        end
        if data.current.value == 'radio' then
          TriggerServerEvent('esx_policejob:giveItem', 'radio', 1)
        end		
        if data.current.value == 'GPS' then
          TriggerServerEvent('esx_policejob:giveItem', 'ggps', 1)
        end		
        -- if data.current.value == 'get_weapon' then
        --   OpenGetWeaponMenu()
        -- end

        -- if data.current.value == 'put_weapon' then
        --   OpenPutWeaponMenu()
        -- end

        if data.current.value == 'buy_weapons' then
          OpenBuyWeaponsMenu(station)
        end

        if data.current.value == 'put_stock' then
          OpenPutStocksMenu()
        end

        if data.current.value == 'get_stock' then
          OpenGetStocksMenu()
        end
      -- if data.current.value == 'swat' then
      --     SwatMenu()
      --   end
      end,
      function(data, menu)

        menu.close()

        CurrentAction     = 'menu_armory'
        CurrentActionMsg  = _U('open_armory')
        CurrentActionData = {station = station}
      end
    )

  else

    local elements = {}

    for i=1, #Config.PoliceStations[station].AuthorizedWeapons, 1 do
      local weapon = Config.PoliceStations[station].AuthorizedWeapons[i]
      table.insert(elements, {label = ESX.GetWeaponLabel(weapon.name), value = weapon.name})
    end
	if swat then
      table.insert(elements, {label = "SWAT", value = 'swat'})		
	end

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory',
      {
        title    = _U('armory'),
        align    = 'bottom-right',
        elements = elements,
      },
      function(data, menu)
        local weapon = data.current.value
		if data.current.value == 'swat' then
			SwatMenu()
		else
        TriggerServerEvent('esx_policejob:giveWeapon', weapon,  1000)		
		end

      end,
      function(data, menu)

        menu.close()

        CurrentAction     = 'menu_armory'
        CurrentActionMsg  = _U('open_armory')
        CurrentActionData = {station = station}

      end
    )

  end

end


-- function SwatMenu()

-- 		local elements = {

-- 		}
-- 		for k,v in pairs(Config.Weapons) do 
-- 			table.insert(elements, {
-- 				label = v.label,
-- 				value = v.value,
-- 				ammo = v.ammo,
-- 			})		
-- 		end

-- 		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'swat_get', {
-- 			title    = ('SWAT'),
-- 			align    = 'left',
-- 			elements = elements
-- 		}, function(data, menu)
-- 			menu.close()
			
-- 			if data.current.value ~= nil then
-- 				TriggerServerEvent('esx_policejob:giveWeapon', data.current.value)
-- 				SwatMenu()
-- 			end

-- 		end, function(data, menu)
-- 			menu.close()
-- 		end)
-- end

function OpenVehicleSpawnerMenu(station, partNum)

  local vehicles = Config.PoliceStations[station].Vehicles

  ESX.UI.Menu.CloseAll()

  if Config.EnableSocietyOwnedVehicles then

    local elements = {}

    ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(garageVehicles)

      for i=1, #garageVehicles, 1 do
        table.insert(elements, {label = GetDisplayNameFromVehicleModel(garageVehicles[i].model) .. ' [' .. garageVehicles[i].plate .. ']', value = garageVehicles[i]})
      end

      ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'vehicle_spawner',
        {
          title    = _U('vehicle_menu'),
          align    = 'bottom-right',
          elements = elements,
        },
        function(data, menu)

          menu.close()

          local vehicleProps = data.current.value

          ESX.Game.SpawnVehicle(vehicleProps.model, vehicles[partNum].SpawnPoint, 270.0, function(vehicle)
            ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
            local playerPed = PlayerPedId()
            TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
          end)

          TriggerServerEvent('esx_society:removeVehicleFromGarage', 'police', vehicleProps)

        end,
        function(data, menu)

          menu.close()

          CurrentAction     = 'menu_vehicle_spawner'
          CurrentActionMsg  = _U('vehicle_spawner')
          CurrentActionData = {station = station, partNum = partNum}

        end
      )

    end, 'police')

  else

	local elements = {}

	local sharedVehicles = Config.AuthorizedVehicles.Shared
	for i=1, #sharedVehicles, 1 do
		table.insert(elements, { label = sharedVehicles[i].label, model = sharedVehicles[i].model})
	end

	local authorizedVehicles = Config.AuthorizedVehicles[PlayerData.job.grade_name]
  if authorizedVehicles ~= nil then
	for i=1, #authorizedVehicles, 1 do
		table.insert(elements, { label = authorizedVehicles[i].label, model = authorizedVehicles[i].model})
	end
end
	
	if swat then
    print("siema")
		local licVehicles = Config.AuthorizedVehicles['swat']
		for i=1, #licVehicles, 1 do
			table.insert(elements, { label = licVehicles[i].label, model = licVehicles[i].model})
		end		
	end
	if seuoffroad then
		local licVehicles = Config.AuthorizedVehicles['seuoffroad']
		for i=1, #licVehicles, 1 do
			table.insert(elements, { label = licVehicles[i].label, model = licVehicles[i].model})
		end		
	end
	if seu then
		local licVehicles = Config.AuthorizedVehicles['seu']
		for i=1, #licVehicles, 1 do
			table.insert(elements, { label = licVehicles[i].label, model = licVehicles[i].model})
		end		
	end	
	if seu2 then
		local licVehicles = Config.AuthorizedVehicles['seu2']
		for i=1, #licVehicles, 1 do
			table.insert(elements, { label = licVehicles[i].label, model = licVehicles[i].model})
		end		
	end
  	

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'vehicle_spawner',
      {
        title    = _U('vehicle_menu'),
        align    = 'bottom-right',
        elements = elements,
      },
      function(data, menu)

        menu.close()

        local model = data.current.model

        local vehicle = GetClosestVehicle(vehicles[partNum].SpawnPoint.x,  vehicles[partNum].SpawnPoint.y,  vehicles[partNum].SpawnPoint.z,  3.0,  0,  71)

        if not DoesEntityExist(vehicle) then

          local playerPed = PlayerPedId()

          if Config.MaxInService == -1 then

            ESX.Game.SpawnVehicle(model, {
              x = vehicles[partNum].SpawnPoint.x,
              y = vehicles[partNum].SpawnPoint.y,
              z = vehicles[partNum].SpawnPoint.z
            }, vehicles[partNum].Heading, function(vehicle)
              TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
              SetVehicleMaxMods(vehicle)
            end)

          else

            ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)

              if canTakeService then

                ESX.Game.SpawnVehicle(model, {
                  x = vehicles[partNum].SpawnPoint.x,
                  y = vehicles[partNum].SpawnPoint.y,
                  z = vehicles[partNum].SpawnPoint.z
                }, vehicles[partNum].Heading, function(vehicle)
                  TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
                  SetVehicleMaxMods(vehicle)
                end)

              else
                ESX.ShowNotification(_U('service_max', inServiceCount, maxInService) .. inServiceCount .. '/' .. maxInService)
              end

            end, 'police')

          end

        else
          ESX.ShowNotification(_U('vehicle_out'))
        end

      end,
      function(data, menu)

        menu.close()

        CurrentAction     = 'menu_vehicle_spawner'
        CurrentActionMsg  = _U('vehicle_spawner')
        CurrentActionData = {station = station, partNum = partNum}

      end
    )

  end

end

function OpenPoliceActionsMenu()
	ESX.UI.Menu.CloseAll()
	local elements = {
			{label = _U('citizen_interaction'),	value = 'citizen_interaction'},
			{label = _U('vehicle_interaction'),	value = 'vehicle_interaction'},
			{label = _U('object_spawner'),		value = 'object_spawner'},		
		}
	ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'police_actions',
	{
		title    = 'Police',
		align    = 'bottom-right',
		elements = elements

	}, function(data, menu)
		if data.current.value == 'citizen_interaction' then
			local elements = {
				{label = _U('id_card'),			value = 'identity_card'},
				{label = _U('search'),			value = 'body_search'},
				{label = _U('zakuj'),		value = 'zakuj'},
				{label = _U('drag'),			value = 'drag'},
				{label = _U('put_in_vehicle'),	value = 'put_in_vehicle'},
				{label = _U('out_the_vehicle'),	value = 'out_the_vehicle'},
			}
		
			if Config.EnableLicenses then
				table.insert(elements, { label = _U('license_check'), value = 'license' })
			end
			
if PlayerData.job.grade_name == 'boss' or PlayerData.job.grade_name == 'viceboss' or PlayerData.job.grade_name == 'Vszef' or PlayerData.job.grade_name == 'komendant' or
PlayerData.job.grade_name == 'kapitanIII' or	PlayerData.job.grade_name == 'kapitanII' or PlayerData.job.grade_name == 'kapitanI' or PlayerData.job.grade_name == 'porucznikIII' or
PlayerData.job.grade_name == 'porucznikII' or PlayerData.job.grade_name == 'porucznikI' or PlayerData.job.grade_name == 'detektywIII' or PlayerData.job.grade_name == 'detektywII'
or PlayerData.job.grade_name == 'detektywI' or PlayerData.job.grade_name == 'sergeantII' or PlayerData.job.grade_name == 'sergeantI' or PlayerData.job.grade_name == 'officerIII' 
or PlayerData.job.grade_name == 'officerII' or PlayerData.job.grade_name == 'officerI' then
				table.insert(elements, { label = 'Nadaj licencję na broń', value = 'lickabron' })
        table.insert(elements, {label = 'Cofnij licencję na broń', value = 'revoke_license'})
        table.insert(elements, {label = 'Cofnij prawo jazdy',  value = 'revoke_prawko'})
        table.insert(elements, {label = "Prace spoleczne",	value = 'communityservice'})
			end
			ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'citizen_interaction',
			{
				title    = _U('citizen_interaction'),
				align    = 'bottom-right',
				elements = elements
			}, function(data2, menu2)
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 3.0 then
					local action = data2.current.value
          local idfrajeraess = GetPlayerServerId(closestPlayer)
					if action == 'identity_card' then
						OpenIdentityCardMenu(closestPlayer)
            local idfrajeraess = GetPlayerServerId(closestPlayer)
            TriggerServerEvent('3dme:shareDisplayMe', 'Patrzy na dowód [' ..idfrajeraess..']')
					elseif action == 'body_search' then
            local closestPed = GetPlayerPed(closestPlayer)
              if GetEntitySpeed(GetPlayerPed(-1)) > 0.5 or GetEntitySpeed(dupa) > 0.5 then
                ESX.ShowNotification('~r~Nie możesz tego robić w ruchu')
              else
                if (IsPedCuffed(closestPed) or DecorExistOn(closestPed, 'injured')) then
                  ESX.ShowNotification("~r~Obywatel musi być zakuty")
						OpenBodySearchMenu(closestPlayer)
            TriggerServerEvent('3dme:shareDisplayMe', 'Przeszukuje [' ..idfrajeraess..']')
          else
            ESX.ShowNotification("~r~Obywatel musi być zakuty")
              end
            end
					elseif action == 'zakuj' then
            if GetEntitySpeed(GetPlayerPed(-1)) > 0.5 or GetEntitySpeed(dupa) > 0.5 then
              ESX.ShowNotification('~r~Nie możesz zakuwać w ruchu')
            else
             animacjazakuciarozkuciaxd()
            Citizen.Wait(2000)
						TriggerServerEvent('esx_policejob:handcuffhype', GetPlayerServerId(closestPlayer))
          end
					elseif action == 'drag' then
            local closestPed = GetPlayerPed(closestPlayer)
              if GetEntitySpeed(GetPlayerPed(-1)) > 0.5 or GetEntitySpeed(dupa) > 0.5 then
                ESX.ShowNotification('~r~Nie możesz tego robić w ruchu')
              else
                if (IsPedCuffed(closestPed) or DecorExistOn(closestPed, 'injured')) then
                  ESX.ShowNotification("~r~Obywatel musi być zakuty")
						TriggerServerEvent('esx_policejob:drag', GetPlayerServerId(closestPlayer))
          else
            ESX.ShowNotification("~r~Obywatel musi być zakuty")
              end
            end
					elseif action == 'put_in_vehicle' then
						TriggerServerEvent('esx_policejob:putInVehicle', GetPlayerServerId(closestPlayer))
					elseif action == 'out_the_vehicle' then
						TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
					elseif action == 'license' then
						ShowPlayerLicense(closestPlayer)
          elseif action == 'lickabron' then
            TriggerServerEvent('route68_police_job:DajLicencjeNaBron', GetPlayerServerId(closestPlayer), 'weapon')
            print(GetPlayerServerId(player))
          elseif action == 'revoke_license' then
            TriggerServerEvent('route68_police_job:revoke_license', GetPlayerServerId(closestPlayer))
          elseif action == 'revoke_prawko' then

						  local elements = {
							  {label = 'Cofnij prawo jazdy (A)',	value = 'revoke_a'},
							  {label = 'Cofnij prawo jazdy (B)',	value = 'revoke_b'},
							  {label = 'Cofnij prawo jazdy (C)',	value = 'revoke_c'}
						  }

						  ESX.UI.Menu.Open(
						  'default', GetCurrentResourceName(), 'prawko',
						  {
							  title    = 'Prawo jazdy',
							  align    = 'left',
							  elements = elements
						  }, function(data3, menu3)
							  if data3.current.value == 'revoke_a' then
								  TriggerServerEvent('genesisprawko:revoke', GetPlayerServerId(closestPlayer), 'A')
							  elseif data3.current.value == 'revoke_b' then
								  TriggerServerEvent('genesisprawko:revoke', GetPlayerServerId(closestPlayer), 'B')
							  elseif data3.current.value == 'revoke_c' then
								  TriggerServerEvent('genesisprawko:revoke', GetPlayerServerId(closestPlayer), 'C')
							  end
						  end, function(data3, menu3)
							  menu3.close()
						  end)
            elseif action == 'communityservice' then
						  SendToCommunityService(GetPlayerServerId(closestPlayer))
					end

				else
					ESX.ShowNotification(_U('no_players_nearby'))
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'vehicle_interaction' then
			local elements = {}
			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			local vehicle   = ESX.Game.GetVehicleInDirection()
			
			if DoesEntityExist(vehicle) then
				table.insert(elements, {label = _U('pick_lock'),	value = 'hijack_vehicle'})
				table.insert(elements, {label = _U('impound'),		value = 'impound'})
			end
			
			--table.insert(elements, {label = _U('search_database'), value = 'search_database'})

			ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'vehicle_interaction',
			{
				title    = _U('vehicle_interaction'),
				align    = 'bottom-right',
				elements = elements
			}, function(data2, menu2)
				coords    = GetEntityCoords(playerPed)
				vehicle   = ESX.Game.GetVehicleInDirection()
				action    = data2.current.value
				
				if action == 'search_database' then
					LookupVehicle()
				elseif DoesEntityExist(vehicle) then
					local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
					if action == 'vehicle_infos' then
						OpenVehicleInfosMenu(vehicleData)
						
					elseif action == 'hijack_vehicle' then
						if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
							TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
							TriggerEvent('pogressBar:drawBar', 20000, 'Odblokowywanie pojazdu')
							Citizen.Wait(20000)
							ClearPedTasksImmediately(playerPed)

							SetVehicleDoorsLocked(vehicle, 1)
							SetVehicleDoorsLockedForAllPlayers(vehicle, false)
							ESX.ShowNotification(_U('vehicle_unlocked'))
						end
					elseif action == 'impound' then
					
						-- is the script busy?
						if CurrentTask.Busy then
							return
						end
						
						SetTextComponentFormat('STRING')
						AddTextComponentString(_U('impound_prompt'))
						DisplayHelpTextFromStringLabel(0, 0, 1, -1)
						
						TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
						
						CurrentTask.Busy = true
						CurrentTask.Task = ESX.SetTimeout(10000, function()
							ClearPedTasks(playerPed)
							ImpoundVehicle(vehicle)
							Citizen.Wait(100) -- sleep the entire script to let stuff sink back to reality
						end)
						
						-- keep track of that vehicle!
						Citizen.CreateThread(function()
							while CurrentTask.Busy do
								Citizen.Wait(1000)
							
								vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
								if not DoesEntityExist(vehicle) and CurrentTask.Busy then
									ESX.ShowNotification(_U('impound_canceled_moved'))
									ESX.ClearTimeout(CurrentTask.Task)
									ClearPedTasks(playerPed)
									CurrentTask.Busy = false
									break
								end
							end
						end)
					end
				else
					ESX.ShowNotification(_U('no_vehicles_nearby'))
				end

			end, function(data2, menu2)
				menu2.close()
			end
			)

		elseif data.current.value == 'object_spawner' then
			ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'citizen_interaction',
			{
				title    = _U('traffic_interaction'),
				align    = 'bottom-right',
				elements = {
					{label = _U('cone'),		value = 'prop_roadcone02a'},
					{label = _U('barrier'),		value = 'prop_barrier_work05'},
					{label = _U('spikestrips'),	value = 'p_ld_stinger_s'},
					{label = _U('box'),			value = 'prop_boxpile_07d'},
					{label = _U('cash'),		value = 'hei_prop_cash_crate_half_full'}
				}
			}, function(data2, menu2)
				local model     = data2.current.value
				local playerPed = PlayerPedId()
				local coords    = GetEntityCoords(playerPed)
				local forward   = GetEntityForwardVector(playerPed)
				local x, y, z   = table.unpack(coords + forward * 1.0)

				if model == 'prop_roadcone02a' then
					z = z - 2.0
				end

				ESX.Game.SpawnObject(model, {
					x = x,
					y = y,
					z = z
				}, function(obj)
					SetEntityHeading(obj, GetEntityHeading(playerPed))
					PlaceObjectOnGroundProperly(obj)
				end)

			end, function(data2, menu2)
				menu2.close()
			end)
		end

	end, function(data, menu)
		menu.close()
	end)
end


function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(1)
	end
end


function animacjazakuciarozkuciaxd()
	local ad = "mp_arresting"
	local anim = "a_uncuff"
	local player = PlayerPedId()

	if ( DoesEntityExist(player) and not IsEntityDead(player)) then
		loadAnimDict(ad)
		if (IsEntityPlayingAnim(player, ad, anim, 8)) then
			
			TaskPlayAnim(player, ad, "exit", 8.0, 3.0, 2000, 26, 1, 0, 0, 0)
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim(player, ad, anim, 8.0, 3.0, 2000, 26, 1, 0, 0, 0)
		end
	end
end

RegisterNetEvent('esx_policejob:handcuffhype')
AddEventHandler('esx_policejob:handcuffhype', function()
	IsHandcuffed    = not IsHandcuffed
	local playerPed = PlayerPedId()
  SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player

	CreateThread(function()
		if IsHandcuffed then
      local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
      local dupa = GetPlayerPed(closestPlayer)
      local xd11 = GetEntityHeading(GetPlayerPed(-1))
      local xd22 = GetEntityHeading(dupa)
      local roznica = math.abs(xd11 - xd22)



      if roznica > 90 then
			ClearPedTasks(playerPed)
			loadAnimDict('rcmme_amanda1')
  			TaskPlayAnim(playerPed, 'rcmme_amanda1', 'stand_loop_ama', 8.0, 3.0, -1, 50, 0, 0, 0, 0)
			kajdany = CreateObject(GetHashKey('p_cs_cuffs_02_s'), GetEntityCoords(PlayerPedId()), true)-- creates object
			AttachEntityToEntity(kajdany, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), -0.030, 0.0, 0.070, 110.0, 90.0, 100.0, 1, 0, 0, 0, 0, 1)
			TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "cuff", 0.5)

			SetEnableHandcuffs(playerPed, true)
  			DisablePlayerFiring(playerPed, true)

  			SetPedCanPlayGestureAnims(playerPed, true)

			odprzodu = true
  	



	
      elseif not FastHandcuffed then
			ClearPedTasks(playerPed)
			loadAnimDict('mp_arresting')
  			TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, 3.0, -1, 50, 0, 0, 0, 0)
			kajdany = CreateObject(GetHashKey('p_cs_cuffs_02_s'), GetEntityCoords(PlayerPedId()), true)-- creates object
			AttachEntityToEntity(kajdany, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), -0.030, 0.055, 0.028, 110.0, -22.5, 75.0, 1, 0, 0, 0, 0, 1)
			SetEnableHandcuffs(playerPed, true)
  			DisablePlayerFiring(playerPed, true)
			TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "cuff", 0.5)
  			SetPedCanPlayGestureAnims(playerPed, true)

			odtylu = true



      end
		else

			-- if Config.EnableHandcuffTimer and HandcuffTimer.Active then
				-- ESX.ClearTimeout(HandcuffTimer.Task)
			-- end
			ClearPedSecondaryTask(playerPed)
      ClearPedTasks(playerPed)
			SetEnableHandcuffs(playerPed, false)
			DisablePlayerFiring(playerPed, false)
			SetPedCanPlayGestureAnims(playerPed, true)
			FreezeEntityPosition(playerPed, false)
      TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "uncuff", 0.5)      
      DetachEntity(kajdany, 1, 1)
      DeleteObject(kajdany)
      ClearAllPedProps(playerPed)
			kajdany = nil
			odprzodu = false
			odtylu = false
			FastHandcuffed = false
			DetachEntity(playerPed, true, false)
			DisplayRadar(true)
		end
	end)

end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(10000)
    if IsHandcuffed then
      local playerPed = PlayerPedId()
      if odprzodu then
        loadAnimDict('rcmme_amanda1')
  			TaskPlayAnim(playerPed, 'rcmme_amanda1', 'stand_loop_ama', 8.0, 3.0, -1, 50, 0, 0, 0, 0)
        SetEnableHandcuffs(playerPed, true)
  			DisablePlayerFiring(playerPed, true)
  			SetPedCanPlayGestureAnims(playerPed, true)
      else
        loadAnimDict('mp_arresting')
  			TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, 3.0, -1, 50, 0, 0, 0, 0)
        SetEnableHandcuffs(playerPed, true)
  			DisablePlayerFiring(playerPed, true)
  			SetPedCanPlayGestureAnims(playerPed, true)
    end
  else
    Citizen.Wait(2500)
  end
  end
end)

function SendToCommunityService(player)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Prace spoleczne', {
		title = "Prace spoleczne",
	}, function (data2, menu)
		local community_services_count = tonumber(data2.value)

		if community_services_count == nil then
			ESX.ShowNotification('Nieprawidlowa liczba.')
		else
			TriggerServerEvent("esx_communityservice:Sendtojebacicimatkeiojcaifamilie", player, community_services_count)
			menu.close()
		end
	end, function (data2, menu)
		menu.close()
	end)
end

function OpenIdentityCardMenu(player)
  if Config.EnableESXIdentity then

    ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)

      local jobLabel    = nil
      local sexLabel    = nil
      local sex         = nil
      local dobLabel    = nil
      local heightLabel = nil
      local idLabel     = nil


      if data.sex ~= nil then
        if (data.sex == 'm') or (data.sex == 'M') then
          sex = 'Mężczyzna'
        else
          sex = 'Kobieta'
        end
        sexLabel = 'Płeć: ' .. sex
      else
        sexLabel = 'Płeć: Nieznana'
      end

      if data.dob ~= nil then
        dobLabel = 'Data urodzenia: ' .. data.dob
      else
        dobLabel = 'Data urodzenia: Nieznana'
      end

      if data.height ~= nil then
        heightLabel = 'Wzrost: ' .. data.height
      else
        heightLabel = 'Wzrost: Nieznany'
      end


      local elements = {
        {label = _U('name', data.firstname .. ' ' .. data.lastname), value = nil},
        {label = sexLabel,    value = nil},
        {label = dobLabel,    value = nil},
        {label = heightLabel, value = nil},
      }

      if data.drunk ~= nil then
        table.insert(elements, {label = _U('bac', data.drunk), value = nil})
      end

      if data.licenses ~= nil then

        table.insert(elements, {label = '--- Licenses ---', value = nil})

        for i=1, #data.licenses, 1 do
          table.insert(elements, {label = data.licenses[i].label, value = nil})
        end

      end

      ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'citizen_interaction',
        {
          title    = _U('citizen_interaction'),
          align    = 'bottom-right',
          elements = elements,
        },
        function(data, menu)

        end,
        function(data, menu)
          menu.close()
        end
      )

    end, GetPlayerServerId(player))

  else

    ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)

      local jobLabel = nil

      if data.job.grade_label ~= nil and  data.job.grade_label ~= '' then
        jobLabel = 'Job: ' .. data.job.label .. ' - ' .. data.job.grade_label
      else
        jobLabel = 'Job: ' .. data.job.label
      end

        local elements = {
          {label = _U('name') .. data.name, value = nil},
          {label = jobLabel,              value = nil},
        }

      if data.drunk ~= nil then
        table.insert(elements, {label = _U('bac') .. data.drunk .. '%', value = nil})
      end

      if data.licenses ~= nil then

        table.insert(elements, {label = '--- Licenses ---', value = nil})

        for i=1, #data.licenses, 1 do
          table.insert(elements, {label = data.licenses[i].label, value = nil})
        end

      end

      ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'citizen_interaction',
        {
          title    = _U('citizen_interaction'),
          align    = 'bottom-right',
          elements = elements,
        },
        function(data, menu)

        end,
        function(data, menu)
          menu.close()
        end
      )

    end, GetPlayerServerId(player))

  end

end

-- function OpenBodySearchMenu(player)
--   ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)
--     local elements = {}
--     local blackMoney = 0


--     for i=1, #data.accounts, 1 do
--       if data.accounts[i].name == 'black_money' then
--         blackMoney = data.accounts[i].money
--       end
--     end



--     table.insert(elements, {
--       label          = 'Zabierz ' .. blackMoney .. ' brudnej gotowki',
--       value          = 'black_money',
--       itemType       = 'item_account',
--       amount         = blackMoney
--     })



--     table.insert(elements, {label = '--- Bronie ---', value = nil})
-- 	for i=1, #data.weapons, 1 do
-- 		table.insert(elements, {
-- 			label    = ('Zabierz ' .. ESX.GetWeaponLabel(data.weapons[i].name) .. data.weapons[i].ammo),
-- 			value    = data.weapons[i].name,
-- 			itemType = 'item_weapon',
-- 			amount   = data.weapons[i].ammo
-- 		})
-- 	end

--     table.insert(elements, {label = ('--- Ekwipunek ---'), value = nil})
--     for i=1, #data.inventory, 1 do
--       if data.inventory[i].count > 0 then
--         table.insert(elements, {
--           label          = 'Zabierz ' .. data.inventory[i].count .. ' ' .. data.inventory[i].label,
--           value          = data.inventory[i].name,
--           itemType       = 'item_standard',
--           amount         = data.inventory[i].count,
--         })
--       end
--     end

--     ESX.UI.Menu.Open(
--       'default', GetCurrentResourceName(), 'body_search',
--       {
--         title    = 'Kajdanki',
--         align    = 'right',
--         elements = elements,
--       },
--       function(data, menu)

--         local itemType = data.current.itemType
--         local itemName = data.current.value
--         local amount   = data.current.amount
		
--         if data.current.value ~= nil then
-- 			TriggerServerEvent('esx_policejob:confiscatePlayerItem', GetPlayerServerId(player), itemType, itemName, amount)
-- 			ESX.UI.Menu.CloseAll()
--         end
--         OpenBodySearchMenu(player)
--       end,
--       function(data, menu)
--         menu.close()
--       end
--     )
--   end, GetPlayerServerId(player))
-- end


function OpenBodySearchMenu(target)
  local serverId = GetPlayerServerId(target)
  ESX.TriggerServerCallback('esx_policejob:checkSearch', function(cb)
      if cb == true then
          ESX.ShowAdvancedNotification("~r~Ta osoba jest już przeszukiwana!") 
      else
          ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)
              TriggerServerEvent('esx_policejob:isSearching', serverId)
      local elements = {}
              for i=1, #data.accounts, 1 do
                  if data.accounts[i].money > 0 then
                      if data.accounts[i].name == 'black_money' then
                          table.insert(elements, {
                              label    = '[Brudna Gotówka] $'..data.accounts[i].money,
                              value    = 'black_money',
                              type     = 'item_account',
                              amount   = data.accounts[i].money
                          })
                          break
                      end
                  end
              end

      -- if data.money > 0 then
      -- 		table.insert(elements, {
      -- 			label    = '[Gotówka] $'..ESX.Round(data.money),
      -- 			value    = 'money',
      -- 			type     = 'gotowka',
      -- 			amount   = data.money
      -- 		})
      -- 	end
      -- if data.money > 0 then
       --  	table.insert(elements, {
      --   	label    = 'pGotówka] $'..ESX.Round(data.money),
      --   	value    = 'money',
      --   	itemType = 'money',
      --   	amount   = data.money
        -- 	})
       -- end
              
              for i=1, #data.inventory, 1 do
                  if data.inventory[i].count > 0 then
                      table.insert(elements, {
                          label    = data.inventory[i].label .. " x" .. data.inventory[i].count,
                          value    = data.inventory[i].name,
                          type     = 'item_standard',
                          amount   = data.inventory[i].count
                      })
                  end
              end
      -- for i=1, #data.weapons, 1 do
      -- 	table.insert(elements, {
      -- 		label    = _U('confiscate_weapon', ESX.GetWeaponLabel(data.weapons[i].name), data.weapons[i].ammo),
      -- 		value    = data.weapons[i].name,
      -- 		itemType = 'item_weapon',
      -- 		amount   = data.weapons[i].ammo
      -- 	})
      -- end
      -- for i=1, #data.weapons, 1 do
      --    table.insert(elements, {
      --       label    = _U('confiscate_weapon', ESX.GetWeaponLabel(data.weapons[i].name), data.weapons[i].ammo),
      --       value    = data.weapons[i].name,
      --       type = 'item_weapon',
      --       amount   = data.weapons[i].ammo
      --     })
      --  end

              ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'body_search', {
                  title    = 'Przeszukaj',
                  align    = 'center',
                  elements = elements
              }, function(data, menu)
                  local itemType = data.current.type
                  local itemName = data.current.value
                  local amount   = data.current.amount
                  local playerCoords = GetEntityCoords(Citizen.InvokeNative(0x43A66C31C68491C0, -1))
                  local targetCoords = GetEntityCoords(Citizen.InvokeNative(0x43A66C31C68491C0, target))
                  -- if itemType == 'item_sim' then
                  --     ESX.TriggerServerCallback('esx_policejob:checkSearch2', function(cb)
                  --         if cb == true then
                  --             ESX.UI.Menu.CloseAll()
                  --             if #(playerCoords - targetCoords) <= 3.0 then
                  --                 procent(5, function()
                  --                     TriggerServerEvent('esx_policejob:isSearching', serverId, false)
                  --                     OpenBodySearchMenu(target)
                  --                 end)
                  --             end
                  --         else
        -- 			print('xD?')
                  --         end
                  --     end, serverId)
                  -- else
                      if data.current.value ~= nil then
            -- if itemType == 'item_weapon' then
            -- TriggerServerEvent('route68_police_job:confiscatePlayerItem', serverId, itemType, itemName, amount)
            -- print("essssssaaaa")
            -- else
                          ESX.TriggerServerCallback('esx_policejob:checkSearch2', function(cb)
                              if cb == true then
                                  ESX.UI.Menu.CloseAll()
                                  if #(playerCoords - targetCoords) <= 3.0 then
                                      TriggerServerEvent('esx_policejob:confiscatePlayerItem', serverId, itemType, itemName, amount)
                  -- print("nie esssa")
                                      procent(5, function()
                                          TriggerServerEvent('esx_policejob:isSearching', serverId, false)
                                          OpenBodySearchMenu(target)
                                      end)
                                  end
                              else
                                  print('xd?')
                              end
                          end, serverId)
                      -- end
                  end
              end, function(data, menu)
                  menu.close()
                  TriggerServerEvent('esx_policejob:isSearching', serverId, false)
              end)
          end, serverId)
      end
  end, serverId)
end

local timeLeft = nil
Citizen.CreateThread(function()
while true do
  Citizen.Wait(0)
  if timeLeft ~= nil then
    local coords = GetEntityCoords(PlayerPedId())	
    DrawText3D(coords.x, coords.y, coords.z + 0.1, timeLeft .. '~g~%', 0.4)
  end
end
end)

function DrawText3D(x, y, z, text, scale)
local onScreen, _x, _y = World3dToScreen2d(x, y, z)
local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

SetTextScale(scale, scale)
SetTextFont(4)
SetTextProportional(1)
SetTextEntry("STRING")
SetTextCentre(1)
SetTextColour(255, 255, 255, 255)
SetTextOutline()

AddTextComponentString(text)
DrawText(_x, _y)

local factor = (string.len(text)) / 270
DrawRect(_x, _y + 0.015, 0.005 + factor, 0.03, 31, 31, 31, 155)
end

function procent(time, cb)
if cb ~= nil then
  Citizen.CreateThread(function()
    timeLeft = 0
    repeat
      timeLeft = timeLeft + 1
      Citizen.Wait(time)
    until timeLeft == 100
    timeLeft = nil
    cb()
  end)
else
  timeLeft = 0
  repeat
    timeLeft = timeLeft + 1
    Citizen.Wait(time)
  until timeLeft == 100
  timeLeft = nil
end
end



function LookupVehicle()
	ESX.UI.Menu.Open(
	'dialog', GetCurrentResourceName(), 'lookup_vehicle',
	{
		title = _U('search_database_title'),
	}, function (data, menu)
		local length = string.len(data.value)
		if data.value == nil or length < 8 or length > 13 then
			ESX.ShowNotification(_U('search_database_error_invalid'))
		else
			ESX.TriggerServerCallback('esx_policejob:getVehicleFromPlate', function(owner, found)
				if found then
					ESX.ShowNotification(_U('search_database_found', owner))
				else
					ESX.ShowNotification(_U('search_database_error_not_found'))
				end
			end, data.value)
			menu.close()
		end
	end, function (data, menu)
		menu.close()
	end
	)
end

function ShowPlayerLicense(player)
	local elements = {}
	local targetName
	ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)
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
		
		ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'manage_license',
		{
			title    = _U('license_revoke'),
			align    = 'bottom-right',
			elements = elements,
		},
		function(data, menu)
			ESX.ShowNotification(_U('licence_you_revoked', data.current.label, targetName))
			TriggerServerEvent('esx_policejob:message', GetPlayerServerId(player), _U('license_revoked', data.current.label))
			
			TriggerServerEvent('esx_license:removeLicense', GetPlayerServerId(player), data.current.value)
			
			ESX.SetTimeout(300, function()
				ShowPlayerLicense(player)
			end)
		end,
		function(data, menu)
			menu.close()
		end
		)

	end, GetPlayerServerId(player))
end


function OpenVehicleInfosMenu(vehicleData)

  ESX.TriggerServerCallback('esx_policejob:getVehicleInfos', function(infos)

    local elements = {}

    table.insert(elements, {label = _U('plate', infos.plate), value = nil})

    if infos.owner == nil then
      table.insert(elements, {label = _U('owner_unknown'), value = nil})
    else
      table.insert(elements, {label = _U('owner', infos.owner), value = nil})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'vehicle_infos',
      {
        title    = _U('vehicle_info'),
        align    = 'bottom-right',
        elements = elements,
      },
      nil,
      function(data, menu)
        menu.close()
      end
    )

  end, vehicleData.plate)

end

function OpenGetWeaponMenu()

  ESX.TriggerServerCallback('esx_policejob:getArmoryWeapons', function(weapons)

    local elements = {}

    for i=1, #weapons, 1 do
      if weapons[i].count > 0 then
        table.insert(elements, {label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name), value = weapons[i].name})
      end
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory_get_weapon',
      {
        title    = _U('get_weapon_menu'),
        align    = 'bottom-right',
        elements = elements,
      },
      function(data, menu)

        menu.close()

        ESX.TriggerServerCallback('esx_policejob:removeArmoryWeapon', function()
          OpenGetWeaponMenu()
        end, data.current.value)

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

function OpenPutWeaponMenu()

  local elements   = {}
  local playerPed  = PlayerPedId()
  local weaponList = ESX.GetWeaponList()

  for i=1, #weaponList, 1 do

    local weaponHash = GetHashKey(weaponList[i].name)

    if HasPedGotWeapon(playerPed,  weaponHash,  false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
      --local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
      table.insert(elements, {label = weaponList[i].label, value = weaponList[i].name})
    end

  end

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'armory_put_weapon',
    {
      title    = _U('put_weapon_menu'),
      align    = 'bottom-right',
      elements = elements,
    },
    function(data, menu)

      menu.close()

      ESX.TriggerServerCallback('esx_policejob:addArmoryWeapon', function()
        OpenPutWeaponMenu()
      end, data.current.value, true)

    end,
    function(data, menu)
      menu.close()
    end
  )

end

function OpenBuyWeaponsMenu(station)

  ESX.TriggerServerCallback('esx_policejob:getArmoryWeapons', function(weapons)

    local elements = {}

    for i=1, #Config.PoliceStations[station].AuthorizedWeapons, 1 do

      local weapon = Config.PoliceStations[station].AuthorizedWeapons[i]
      local count  = 0

      for i=1, #weapons, 1 do
        if weapons[i].name == weapon.name then
          count = weapons[i].count
          break
        end
      end

      table.insert(elements, {label = 'x' .. count .. ' ' .. ESX.GetWeaponLabel(weapon.name) .. ' $' .. weapon.price, value = weapon.name, price = weapon.price})

    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory_buy_weapons',
      {
        title    = _U('buy_weapon_menu'),
        align    = 'bottom-right',
        elements = elements,
      },
      function(data, menu)

        ESX.TriggerServerCallback('esx_policejob:buy', function(hasEnoughMoney)

          if hasEnoughMoney then
            ESX.TriggerServerCallback('esx_policejob:addArmoryWeapon', function()
              OpenBuyWeaponsMenu(station)
            end, data.current.value, false)
          else
            ESX.ShowNotification(_U('not_enough_money'))
          end

        end, data.current.price)

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

function OpenGetStocksMenu()

  ESX.TriggerServerCallback('esx_policejob:getStockItems', function(items)


    local elements = {}

    for i=1, #items, 1 do
      table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'stocks_menu',
      {
        title    = _U('police_stock'),
		align    = 'bottom-right',
        elements = elements
      },
      function(data, menu)

        local itemName = data.current.value

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count',
          {
            title = _U('quantity')
          },
          function(data2, menu2)

            local count = tonumber(data2.value)

            if count == nil then
              ESX.ShowNotification(_U('quantity_invalid'))
            else
              menu2.close()
              menu.close()
              OpenGetStocksMenu()

              TriggerServerEvent('esx_policejob:getStockItem', itemName, count)
            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

function OpenPutStocksMenu()

  ESX.TriggerServerCallback('esx_policejob:getPlayerInventory', function(inventory)

    local elements = {}

    for i=1, #inventory.items, 1 do

      local item = inventory.items[i]

      if item.count > 0 then
        table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
      end

    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'stocks_menu',
      {
        title    = _U('inventory'),
		align    = 'bottom-right',
        elements = elements
      },
      function(data, menu)

        local itemName = data.current.value

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count',
          {
            title = _U('quantity')
          },
          function(data2, menu2)

            local count = tonumber(data2.value)

            if count == nil then
              ESX.ShowNotification(_U('quantity_invalid'))
            else
              menu2.close()
              menu.close()
              OpenPutStocksMenu()

              TriggerServerEvent('esx_policejob:putStockItems', itemName, count)
            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)

  local specialContact = {
    name       = 'Police',
    number     = 'police',
    base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyJpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNiAoV2luZG93cykiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6NDFGQTJDRkI0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6NDFGQTJDRkM0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDo0MUZBMkNGOTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDo0MUZBMkNGQTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PoW66EYAAAjGSURBVHjapJcLcFTVGcd/u3cfSXaTLEk2j80TCI8ECI9ABCyoiBqhBVQqVG2ppVKBQqUVgUl5OU7HKqNOHUHU0oHamZZWoGkVS6cWAR2JPJuAQBPy2ISEvLN57+v2u2E33e4k6Ngz85+9d++95/zP9/h/39GpqsqiRYsIGz8QZAq28/8PRfC+4HT4fMXFxeiH+GC54NeCbYLLATLpYe/ECx4VnBTsF0wWhM6lXY8VbBE0Ch4IzLcpfDFD2P1TgrdC7nMCZLRxQ9AkiAkQCn77DcH3BC2COoFRkCSIG2JzLwqiQi0RSmCD4JXbmNKh0+kc/X19tLtc9Ll9sk9ZS1yoU71YIk3xsbEx8QaDEc2ttxmaJSKC1ggSKBK8MKwTFQVXRzs3WzpJGjmZgvxcMpMtWIwqsjztvSrlzjYul56jp+46qSmJmMwR+P3+4aZ8TtCprRkk0DvUW7JjmV6lsqoKW/pU1q9YQOE4Nxkx4ladE7zd8ivuVmJQfXZKW5dx5EwPRw4fxNx2g5SUVLw+33AkzoRaQDP9SkFu6OKqz0uF8yaz7vsOL6ycQVLkcSg/BlWNsjuFoKE1knqDSl5aNnmPLmThrE0UvXqQqvJPyMrMGorEHwQfEha57/3P7mXS684GFjy8kreLppPUuBXfyd/ibeoS2kb0mWPANhJdYjb61AxUvx5PdT3+4y+Tb3mTd19ZSebE+VTXVGNQlHAC7w4VhH8TbA36vKq6ilnzlvPSunHw6Trc7XpZ14AyfgYeyz18crGN1Alz6e3qwNNQSv4dZox1h/BW9+O7eIaEsVv41Y4XeHJDG83Nl4mLTwzGhJYtx0PzNTjOB9KMTlc7Nkcem39YAGU7cbeBKVLMPGMVf296nMd2VbBq1wmizHoqqm/wrS1/Zf0+N19YN2PIu1fcIda4Vk66Zx/rVi+jo9eIX9wZGGcFXUMR6BHUa76/2ezioYcXMtpyAl91DSaTfDxlJbtLprHm2ecpObqPuTPzSNV9yKz4a4zJSuLo71/j8Q17ON69EmXiPIlNMe6FoyzOqWPW/MU03Lw5EFcyKghTrNDh7+/vw545mcJcWbTiGKpRdGPMXbx90sGmDaux6sXk+kimjU+BjnMkx3kYP34cXrFuZ+3nrHi6iDMt92JITcPjk3R3naRwZhpuNSqoD93DKaFVU7j2dhcF8+YzNlpErbIBTVh8toVccbaysPB+4pMcuPw25kwSsau7BIlmHpy3guaOPtISYyi/UkaJM5Lpc5agq5Xkcl6gIHkmqaMn0dtylcjIyPThCNyhaXyfR2W0I1our0v6qBii07ih5rDtGSOxNVdk1y4R2SR8jR/g7hQD9l1jUeY/WLJB5m39AlZN4GZyIQ1fFJNsEgt0duBIc5GRkcZF53mNwIzhXPDgQPoZIkiMkbTxtstDMVnmFA4cOsbz2/aKjSQjev4Mp9ZAg+hIpFhB3EH5Yal16+X+Kq3dGfxkzRY+KauBjBzREvGN0kNCTARu94AejBLMHorAQ7cEQMGs2cXvkWshYLDi6e9l728O8P1XW6hKeB2yv42q18tjj+iFTGoSi+X9jJM9RTxS9E+OHT0krhNiZqlbqraoT7RAU5bBGrEknEBhgJks7KXbLS8qERI0ErVqF/Y4K6NHZfLZB+/wzJvncacvFd91oXO3o/O40MfZKJOKu/rne+mRQByXM4lYreb1tUnkizVVA/0SpfpbWaCNBeEE5gb/UH19NLqEgDF+oNDQWcn41Cj0EXFEWqzkOIyYekslFkThsvMxpIyE2hIc6lXGZ6cPyK7Nnk5OipixRdxgUESAYmhq68VsGgy5CYKCUAJTg0+izApXne3CJFmUTwg4L3FProFxU+6krqmXu3MskkhSD2av41jLdzlnfFrSdCZxyqfMnppN6ZUa7pwt0h3fiK9DCt4IO9e7YqisvI7VYgmNv7mhBKKD/9psNi5dOMv5ZjukjsLdr0ffWsyTi6eSlfcA+dmiVyOXs+/sHNZu3M6PdxzgVO9GmDSHsSNqmTz/R6y6Xxqma4fwaS5Mn85n1ZE0Vl3CHBER3lUNEhiURpPJRFdTOcVnpUJnPIhR7cZXfoH5UYc5+E4RzRH3sfSnl9m2dSMjE+Tz9msse+o5dr7UwcQ5T3HwlWUkNuzG3dKFSTbsNs7m/Y8vExOlC29UWkMJlAxKoRQMR3IC7x85zOn6fHS50+U/2Untx2R1voinu5no+DQmz7yPXmMKZnsu0wrm0Oe3YhOVHdm8A09dBQYhTv4T7C+xUPrZh8Qn2MMr4qcDSRfoirWgKAvtgOpv1JI8Zi77X15G7L+fxeOUOiUFxZiULD5fSlNzNM62W+k1yq5gjajGX/ZHvOIyxd+Fkj+P092rWP/si0Qr7VisMaEWuCiYonXFwbAUTWWPYLV245NITnGkUXnpI9butLJn2y6iba+hlp7C09qBcvoN7FYL9mhxo1/y/LoEXK8Pv6qIC8WbBY/xr9YlPLf9dZT+OqKTUwfmDBm/GOw7ws4FWpuUP2gJEZvKqmocuXPZuWYJMzKuSsH+SNwh3bo0p6hao6HeEqwYEZ2M6aKWd3PwTCy7du/D0F1DsmzE6/WGLr5LsDF4LggnYBacCOboQLHQ3FFfR58SR+HCR1iQH8ukhA5s5o5AYZMwUqOp74nl8xvRHDlRTsnxYpJsUjtsceHt2C8Fm0MPJrphTkZvBc4It9RKLOFx91Pf0Igu0k7W2MmkOewS2QYJUJVWVz9VNbXUVVwkyuAmKTFJayrDo/4Jwe/CT0aGYTrWVYEeUfsgXssMRcpyenraQJa0VX9O3ZU+Ma1fax4xGxUsUVFkOUbcama1hf+7+LmA9juHWshwmwOE1iMmCFYEzg1jtIm1BaxW6wCGGoFdewPfvyE4ertTiv4rHC73B855dwp2a23bbd4tC1hvhOCbX7b4VyUQKhxrtSOaYKngasizvwi0RmOS4O1QZf2yYfiaR+73AvhTQEVf+rpn9/8IMAChKDrDzfsdIQAAAABJRU5ErkJggg=='
  }

  TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)

end)

AddEventHandler('esx_policejob:hasEnteredMarker', function(station, part, partNum)

  if part == 'Cloakroom' then
    CurrentAction     = 'menu_cloakroom'
    CurrentActionMsg  = _U('open_cloackroom')
    CurrentActionData = {}
  end

  if part == 'Armory' then
    CurrentAction     = 'menu_armory'
    CurrentActionMsg  = _U('open_armory')
    CurrentActionData = {station = station}
  end

  if part == 'VehicleSpawner' then
    CurrentAction     = 'menu_vehicle_spawner'
    CurrentActionMsg  = _U('vehicle_spawner')
    CurrentActionData = {station = station, partNum = partNum}
  end

  if part == 'HelicopterSpawner' then
	if air then
		local helicopters = Config.PoliceStations[station].Helicopters

		if not IsAnyVehicleNearPoint(helicopters[partNum].SpawnPoint.x, helicopters[partNum].SpawnPoint.y, helicopters[partNum].SpawnPoint.z,  3.0) then

		  ESX.Game.SpawnVehicle('polmav', {
			x = helicopters[partNum].SpawnPoint.x,
			y = helicopters[partNum].SpawnPoint.y,
			z = helicopters[partNum].SpawnPoint.z
		  }, helicopters[partNum].Heading, function(vehicle)
			SetVehicleModKit(vehicle, 0)
			SetVehicleLivery(vehicle, 0)
		  end)

		end
	end
  end
   if part == 'BoatSpawner' then
	if ocean then
		local boats = Config.PoliceStations[station].Boats

		if not IsAnyVehicleNearPoint(boats[partNum].SpawnPoint.x, boats[partNum].SpawnPoint.y, boats[partNum].SpawnPoint.z,  3.0) then

		  ESX.Game.SpawnVehicle('predator', {
			x = boats[partNum].SpawnPoint.x,
			y = boats[partNum].SpawnPoint.y,
			z = boats[partNum].SpawnPoint.z
		  }, boats[partNum].Heading, function(vehicle)
			SetVehicleModKit(vehicle, 0)
			SetVehicleLivery(vehicle, 0)
		  end)

		end
	end
  end
  if part == 'BoatSpawner' then
	if ocean then
		local boats = Config.PoliceStations[station].Boats

		if not IsAnyVehicleNearPoint(boats[partNum].SpawnPoint.x, boats[partNum].SpawnPoint.y, boats[partNum].SpawnPoint.z,  3.0) then

		  ESX.Game.SpawnVehicle('predator', {
			x = boats[partNum].SpawnPoint.x,
			y = boats[partNum].SpawnPoint.y,
			z = boats[partNum].SpawnPoint.z
		  }, boats[partNum].Heading, function(vehicle)
			SetVehicleModKit(vehicle, 0)
			SetVehicleLivery(vehicle, 0)
		  end)

		end
	end
  end
 

  if part == 'VehicleDeleter' then

    local playerPed = PlayerPedId()
    local coords    = GetEntityCoords(playerPed)

    if IsPedInAnyVehicle(playerPed,  false) then

      local vehicle = GetVehiclePedIsIn(playerPed, false)

      if DoesEntityExist(vehicle) then
        CurrentAction     = 'delete_vehicle'
        CurrentActionMsg  = _U('store_vehicle')
        CurrentActionData = {vehicle = vehicle}
      end

    end

  end

  if part == 'BossActions' then
    CurrentAction     = 'menu_boss_actions'
    CurrentActionMsg  = _U('open_bossmenu')
    CurrentActionData = {}
  end

end)

AddEventHandler('esx_policejob:hasExitedMarker', function(station, part, partNum)
  ESX.UI.Menu.CloseAll()
  CurrentAction = nil
end)

AddEventHandler('esx_policejob:hasEnteredEntityZone', function(entity)

  local playerPed = PlayerPedId()

  if PlayerData.job ~= nil and PlayerData.job.name == 'police' and not IsPedInAnyVehicle(playerPed, false) then
    CurrentAction     = 'remove_entity'
    CurrentActionMsg  = _U('remove_prop')
    CurrentActionData = {entity = entity}
  end

  if GetEntityModel(entity) == GetHashKey('p_ld_stinger_s') then

    local playerPed = PlayerPedId()
    local coords    = GetEntityCoords(playerPed)

    if IsPedInAnyVehicle(playerPed,  false) then

      local vehicle = GetVehiclePedIsIn(playerPed)

      for i=0, 7, 1 do
        SetVehicleTyreBurst(vehicle,  i,  true,  1000)
      end

    end

  end

end)

AddEventHandler('esx_policejob:hasExitedEntityZone', function(entity)

  if CurrentAction == 'remove_entity' then
    CurrentAction = nil
  end

end)

RegisterNetEvent('esx_policejob:zakuj')
AddEventHandler('esx_policejob:zakuj', function()
	IsHandcuffed    = not IsHandcuffed
	local playerPed = PlayerPedId()

	Citizen.CreateThread(function()
		if IsHandcuffed then

			RequestAnimDict('mp_arresting')
			while not HasAnimDictLoaded('mp_arresting') do
				Citizen.Wait(100)
			end

			TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)

			SetEnableHandcuffs(playerPed, true)
			DisablePlayerFiring(playerPed, true)
			SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
			SetPedCanPlayGestureAnims(playerPed, false)
			FreezeEntityPosition(playerPed, false)

			if Config.EnableHandcuffTimer then
				if HandcuffTimer then
					ESX.ClearTimeout(HandcuffTimer)
				end

				StartHandcuffTimer()
			end

		else

			if Config.EnableHandcuffTimer and HandcuffTimer then
				ESX.ClearTimeout(HandcuffTimer)
			end
			ClearPedSecondaryTask(playerPed)
			SetEnableHandcuffs(playerPed, false)
			DisablePlayerFiring(playerPed, false)
			SetPedCanPlayGestureAnims(playerPed, true)
			FreezeEntityPosition(playerPed, false)
		end
	end)

end)

AddEventHandler('esx_policejob:unrestrain', function()
	if IsHandcuffed then
		local playerPed = PlayerPedId()
		IsHandcuffed = false

		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		FreezeEntityPosition(playerPed, false)
	end
end)

RegisterNetEvent('esx_policejob:drag')
AddEventHandler('esx_policejob:drag', function(cop)
	IsDragged = not IsDragged
	CopPed = tonumber(cop)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsHandcuffed then
			if IsDragged then
				local ped = GetPlayerPed(GetPlayerFromServerId(CopPed))
				local myped = PlayerPedId()
				AttachEntityToEntity(myped, ped, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
			else
				DetachEntity(PlayerPedId(), true, false)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('esx_policejob:putInVehicle')
AddEventHandler('esx_policejob:putInVehicle', function()

  local playerPed = PlayerPedId()
  local coords    = GetEntityCoords(playerPed)

  if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

    local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)

    if DoesEntityExist(vehicle) then

      local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
      local freeSeat = nil

      for i=maxSeats - 1, 0, -1 do
        if IsVehicleSeatFree(vehicle, i) then
          freeSeat = i
          break
        end
      end

      if freeSeat ~= nil then
        TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
      end

    end

  end

end)

RegisterNetEvent('esx_policejob:OutVehicle')
AddEventHandler('esx_policejob:OutVehicle', function(t)
	local ped = GetPlayerPed(t)
	ClearPedTasksImmediately(ped)
	plyPos = GetEntityCoords(PlayerPedId(),  true)
	local xnew = plyPos.x+2
	local ynew = plyPos.y+2

	SetEntityCoords(PlayerPedId(), xnew, ynew, plyPos.z)
end)

-- zakuj
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    local playerPed = PlayerPedId()

    if IsHandcuffed then
      --DisableControlAction(0, 1, true) -- Disable pan
      --DisableControlAction(0, 2, true) -- Disable tilt
      DisableControlAction(0, 24, true) -- Attack
      DisableControlAction(0, 257, true) -- Attack 2
      DisableControlAction(0, 25, true) -- Aim
      DisableControlAction(0, 263, true) -- Melee Attack 1
      --DisableControlAction(0, Keys['W'], true) -- W
      --DisableControlAction(0, Keys['A'], true) -- A
      --DisableControlAction(0, 31, true) -- S (fault in Keys table!)
      --DisableControlAction(0, 30, true) -- D (fault in Keys table!)
      DisableControlAction(0, 344, true) -- Disable phone

      DisableControlAction(0, Keys['R'], true) -- Reload
      DisableControlAction(0, Keys['SPACE'], true) -- Jump
      DisableControlAction(0, Keys['Q'], true) -- Cover
      DisableControlAction(0, Keys['TAB'], true) -- Select Weapon
      DisableControlAction(0, Keys['F'], true) -- Also 'enter'?

      DisableControlAction(0, Keys['F2'], true) -- Inventory
      DisableControlAction(0, Keys['F1'], true) -- Telefon
      DisableControlAction(0, Keys['F3'], true) -- Animations
      DisableControlAction(0, Keys['F6'], true) -- Job

      DisableControlAction(0, Keys['V'], true) -- Disable changing view
      DisableControlAction(0, Keys['C'], true) -- Disable looking behind
      DisableControlAction(2, Keys['P'], true) -- Disable pause screen

      DisableControlAction(0, 59, true) -- Disable steering in vehicle
      DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
      DisableControlAction(0, 72, true) -- Disable reversing in vehicle

      DisableControlAction(2, Keys['LEFTCTRL'], true) -- Disable going stealth

      DisableControlAction(0, 47, true)  -- Disable weapon
      DisableControlAction(0, 264, true) -- Disable melee
      DisableControlAction(0, 257, true) -- Disable melee
      DisableControlAction(0, 140, true) -- Disable melee
      DisableControlAction(0, 141, true) -- Disable melee
      DisableControlAction(0, 142, true) -- Disable melee
      DisableControlAction(0, 143, true) -- Disable melee
      DisableControlAction(0, 75, true)  -- Disable exit vehicle
      DisableControlAction(27, 75, true) -- Disable exit vehicle
      ESX.UI.Menu.CloseAll()
      if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
        ESX.Streaming.RequestAnimDict('mp_arresting', function()
          TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
        end)
      end
    else
      Citizen.Wait(100)
    end
  end
end)

-- Display markers
Citizen.CreateThread(function()
  while true do

    Wait(0)
local lastsleep = true
local police = true
    if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
     police = false
      local playerPed = PlayerPedId()
      local coords    = GetEntityCoords(playerPed)

      for k,v in pairs(Config.PoliceStations) do

        for i=1, #v.Cloakrooms, 1 do
          if GetDistanceBetweenCoords(coords,  v.Cloakrooms[i].x,  v.Cloakrooms[i].y,  v.Cloakrooms[i].z,  true) < Config.DrawDistance then
            lastsleep = false
            DrawMarker(Config.MarkerType, v.Cloakrooms[i].x, v.Cloakrooms[i].y, v.Cloakrooms[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
          end
        end

        for i=1, #v.Armories, 1 do
          if GetDistanceBetweenCoords(coords,  v.Armories[i].x,  v.Armories[i].y,  v.Armories[i].z,  true) < Config.DrawDistance then
            lastsleep = false
            DrawMarker(Config.MarkerType, v.Armories[i].x, v.Armories[i].y, v.Armories[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
          end
        end

        for i=1, #v.Vehicles, 1 do
          if GetDistanceBetweenCoords(coords,  v.Vehicles[i].Spawner.x,  v.Vehicles[i].Spawner.y,  v.Vehicles[i].Spawner.z,  true) < Config.DrawDistance then
            lastsleep = false
            DrawMarker(Config.MarkerType, v.Vehicles[i].Spawner.x, v.Vehicles[i].Spawner.y, v.Vehicles[i].Spawner.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
          end
        end

        for i=1, #v.VehicleDeleters, 1 do
          if GetDistanceBetweenCoords(coords,  v.VehicleDeleters[i].x,  v.VehicleDeleters[i].y,  v.VehicleDeleters[i].z,  true) < Config.DrawDistance then
            lastsleep = false
            DrawMarker(Config.MarkerType, v.VehicleDeleters[i].x, v.VehicleDeleters[i].y, v.VehicleDeleters[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
          end
        end

        if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.name == 'police' and PlayerData.job.grade_name == 'boss'
	or
	PlayerData.job.grade_name == 'viceboss' or 
	PlayerData.job.grade_name == 'Vszef' or 
	PlayerData.job.grade_name == 'komendant'		then

          for i=1, #v.BossActions, 1 do
            if not v.BossActions[i].disabled and GetDistanceBetweenCoords(coords,  v.BossActions[i].x,  v.BossActions[i].y,  v.BossActions[i].z,  true) < Config.DrawDistance then
              lastsleep = false
              DrawMarker(Config.MarkerType, v.BossActions[i].x, v.BossActions[i].y, v.BossActions[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
            end
          end

        end

      end
    end
    if lastsleep then
      Citizen.Wait(400)
    end
    if police then
      Citizen.Wait(400)
    end
  end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()

  while true do

    Wait(0)
local lastsleep = true
local police = true
    if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
            police = false
      local playerPed      = PlayerPedId()
      local coords         = GetEntityCoords(playerPed)
      local isInMarker     = false
      local currentStation = nil
      local currentPart    = nil
      local currentPartNum = nil

      for k,v in pairs(Config.PoliceStations) do

        for i=1, #v.Cloakrooms, 1 do
          if GetDistanceBetweenCoords(coords,  v.Cloakrooms[i].x,  v.Cloakrooms[i].y,  v.Cloakrooms[i].z,  true) < Config.MarkerSize.x then
            lastsleep = true
            isInMarker     = true
            currentStation = k
            currentPart    = 'Cloakroom'
            currentPartNum = i
          end
        end

        for i=1, #v.Armories, 1 do
          if GetDistanceBetweenCoords(coords,  v.Armories[i].x,  v.Armories[i].y,  v.Armories[i].z,  true) < Config.MarkerSize.x then
            lastsleep = true
            isInMarker     = true
            currentStation = k
            currentPart    = 'Armory'
            currentPartNum = i
          end
        end

        for i=1, #v.Vehicles, 1 do

          if GetDistanceBetweenCoords(coords,  v.Vehicles[i].Spawner.x,  v.Vehicles[i].Spawner.y,  v.Vehicles[i].Spawner.z,  true) < Config.MarkerSize.x then
            lastsleep = true
            isInMarker     = true
            currentStation = k
            currentPart    = 'VehicleSpawner'
            currentPartNum = i
          end

          if GetDistanceBetweenCoords(coords,  v.Vehicles[i].SpawnPoint.x,  v.Vehicles[i].SpawnPoint.y,  v.Vehicles[i].SpawnPoint.z,  true) < Config.MarkerSize.x then
            lastsleep = true
            isInMarker     = true
            currentStation = k
            currentPart    = 'VehicleSpawnPoint'
            currentPartNum = i
          end

        end

        for i=1, #v.Helicopters, 1 do

          if GetDistanceBetweenCoords(coords,  v.Helicopters[i].Spawner.x,  v.Helicopters[i].Spawner.y,  v.Helicopters[i].Spawner.z,  true) < Config.MarkerSize.x then
            lastsleep = true
            isInMarker     = true
            currentStation = k
            currentPart    = 'HelicopterSpawner'
            currentPartNum = i
          end

          if GetDistanceBetweenCoords(coords,  v.Helicopters[i].SpawnPoint.x,  v.Helicopters[i].SpawnPoint.y,  v.Helicopters[i].SpawnPoint.z,  true) < Config.MarkerSize.x then
            lastsleep = true
            isInMarker     = true
            currentStation = k
            currentPart    = 'HelicopterSpawnPoint'
            currentPartNum = i
          end

        end
        for i=1, #v.Boats, 1 do

          if GetDistanceBetweenCoords(coords,  v.Boats[i].Spawner.x,  v.Boats[i].Spawner.y,  v.Boats[i].Spawner.z,  true) < Config.MarkerSize.x then
            lastsleep = true
            isInMarker     = true
            currentStation = k
            currentPart    = 'BoatsSpawner'
            currentPartNum = i
          end

          if GetDistanceBetweenCoords(coords,  v.Boats[i].SpawnPoint.x,  v.Boats[i].SpawnPoint.y,  v.Boats[i].SpawnPoint.z,  true) < Config.MarkerSize.x then
            lastsleep = true
            isInMarker     = true
            currentStation = k
            currentPart    = 'BoatsSpawnpoint'
            currentPartNum = i
          end

        end
        for i=1, #v.VehicleDeleters, 1 do
          if GetDistanceBetweenCoords(coords,  v.VehicleDeleters[i].x,  v.VehicleDeleters[i].y,  v.VehicleDeleters[i].z,  true) < Config.MarkerSize.x then
            lastsleep = true
            isInMarker     = true
            currentStation = k
            currentPart    = 'VehicleDeleter'
            currentPartNum = i
          end
        end

        if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.name == 'police' and PlayerData.job.grade_name == 'boss' 
	or
	PlayerData.job.grade_name == 'viceboss' or 
	PlayerData.job.grade_name == 'Vszef' or 
	PlayerData.job.grade_name == 'komendant'then

          for i=1, #v.BossActions, 1 do
            if GetDistanceBetweenCoords(coords,  v.BossActions[i].x,  v.BossActions[i].y,  v.BossActions[i].z,  true) < Config.MarkerSize.x then
              lastsleep = true
              isInMarker     = true
              currentStation = k
              currentPart    = 'BossActions'
              currentPartNum = i
            end
          end

        end

      end

      local hasExited = false

      if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum) ) then

        if
          (LastStation ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
          (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
        then
          TriggerEvent('esx_policejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
          hasExited = true
        end

        HasAlreadyEnteredMarker = true
        LastStation             = currentStation
        LastPart                = currentPart
        LastPartNum             = currentPartNum

        TriggerEvent('esx_policejob:hasEnteredMarker', currentStation, currentPart, currentPartNum)
      end

      if not hasExited and not isInMarker and HasAlreadyEnteredMarker then

        HasAlreadyEnteredMarker = false

        TriggerEvent('esx_policejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
      end

    end
    if lastsleep then
      Citizen.Wait(400)
    end
    if police then
      Citizen.Wait(400)
    end
  end
end)

-- Enter / Exit entity zone events
Citizen.CreateThread(function()

  local trackedEntities = {
    'prop_roadcone02a',
    'prop_barrier_work06a',
    'p_ld_stinger_s',
    'prop_boxpile_07d',
    'hei_prop_cash_crate_half_full'
  }

  while true do

    Citizen.Wait(1000)

    local playerPed = PlayerPedId()
    local coords    = GetEntityCoords(playerPed)
    local lastsleep = true
    local closestDistance = -1
    local closestEntity   = nil

    for i=1, #trackedEntities, 1 do

      local object = GetClosestObjectOfType(coords.x,  coords.y,  coords.z,  3.0,  GetHashKey(trackedEntities[i]), false, false, false)

      if DoesEntityExist(object) then

        local objCoords = GetEntityCoords(object)
        local distance  = GetDistanceBetweenCoords(coords.x,  coords.y,  coords.z,  objCoords.x,  objCoords.y,  objCoords.z,  true)

        if closestDistance == -1 or closestDistance > distance then
          lastsleep = false
          closestDistance = distance
          closestEntity   = object
        end

      end

    end

    if closestDistance ~= -1 and closestDistance <= 3.0 then

      if LastEntity ~= closestEntity then
        TriggerEvent('esx_policejob:hasEnteredEntityZone', closestEntity)
        LastEntity = closestEntity
      end

    else

      if LastEntity ~= nil then
        TriggerEvent('esx_policejob:hasExitedEntityZone', LastEntity)
        LastEntity = nil
      end

    end
    if lastsleep then
      Citizen.Wait(400)
    end
  end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)
local police = true
		if CurrentAction ~= nil then
			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)
if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
  police = false
			if IsControlJustReleased(0, Keys['E']) then

				if CurrentAction == 'menu_cloakroom' then
					OpenCloakroomMenu()
				elseif CurrentAction == 'menu_armory' then
					OpenArmoryMenu(CurrentActionData.station)
				elseif CurrentAction == 'menu_vehicle_spawner' then
					OpenVehicleSpawnerMenu(CurrentActionData.station, CurrentActionData.partNum)
				elseif CurrentAction == 'delete_vehicle' then
					if Config.EnableSocietyOwnedVehicles then
						local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
						TriggerServerEvent('esx_society:putVehicleInGarage', 'police', vehicleProps)
					else
						if GetEntityModel(vehicle) == GetHashKey('police') or
							GetEntityModel(vehicle) == GetHashKey('police2') or
							GetEntityModel(vehicle) == GetHashKey('police3') or
							GetEntityModel(vehicle) == GetHashKey('police4') or
							GetEntityModel(vehicle) == GetHashKey('policeb') or
							GetEntityModel(vehicle) == GetHashKey('policet')
						then
							TriggerServerEvent('esx_service:disableService', 'police')
						end
					end
					ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
				elseif CurrentAction == 'menu_boss_actions' then
					ESX.UI.Menu.CloseAll()
					TriggerEvent('lspd:zarzadzanie')
				elseif CurrentAction == 'remove_entity' then
					DeleteEntity(CurrentActionData.entity)
				end
				
				CurrentAction = nil
			end
		end -- CurrentAction end
    if police then
      Citizen.Wait(400)
    end
  end
		
    if PlayerData.job ~= nil and PlayerData.job.name == 'police' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'police_actions') then
		police = false
      if IsControlJustReleased(0, Keys['F6']) and not isDead then
			OpenPoliceActionsMenu()
		end
  end
		
		if IsControlJustReleased(0, Keys['E']) and CurrentTask.Busy then
			ESX.ShowNotification(_U('impound_canceled'))
			ESX.ClearTimeout(CurrentTask.Task)
			ClearPedTasks(PlayerPedId())
			
			CurrentTask.Busy = false
		end
	end
  if police then
    Citizen.Wait(400)
  end
end)

RegisterNetEvent('lspd:zarzadzanie')
AddEventHandler('lspd:zarzadzanie', function()
ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'gpsmen',
	{
		title    = 'Zarządzanie',
		align    = 'left',
		elements = {
			{label = 'Akcje szefa', value = '111'},
			{label = 'Zarządzaj licencjami', value = '222'},
		}
	},
	function(data2, menu2)
		if data2.current.value == '111' then
		menu2.close()
		ESX.UI.Menu.CloseAll()
					TriggerEvent('esx_society:openBossMenu', 'police', function(data, menu)
						menu.close()
						CurrentAction     = 'menu_boss_actions'
						CurrentActionMsg  = _U('open_bossmenu')
						CurrentActionData = {}
					end)
		elseif data2.current.value == '222' then
		menu2.close()
		LicensePolice('police')

		end

	end,
	function(data2, menu2)
		menu2.close()
end)
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
	TriggerEvent('esx_policejob:unrestrain')
	
	if not hasAlreadyJoined then
		TriggerServerEvent('esx_policejob:spawned')
	end
	hasAlreadyJoined = true
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_policejob:unrestrain')
	end
end)

-- zakuj timer, unrestrain the player after an certain amount of time
function StartHandcuffTimer()
	if Config.EnableHandcuffTimer and HandcuffTimer then
		ESX.ClearTimeout(HandcuffTimer)
	end

	HandcuffTimer = ESX.SetTimeout(Config.HandcuffTimer, function()
		ESX.ShowNotification(_U('unrestrained_timer'))
		TriggerEvent('esx_policejob:unrestrain')
	end)

	HandcuffTimer = nil
end

-- TODO
--   - return to garage if owned
--   - message owner that his vehicle has been impounded
function ImpoundVehicle(vehicle)
	--local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
	ESX.Game.DeleteVehicle(vehicle) 
	ESX.ShowNotification(_U('impound_successful'))
	CurrentTask.Busy = false
end

TriggerEvent('esx_jb_dj:enabledjbooth', true)


-- #####################
-- ###### DODATKI ######
-- #####################

local insideMarker = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coords, lastsleep = GetEntityCoords(PlayerPedId()), true
		local veh = GetVehiclePedIsIn(PlayerPedId(), false)
		local pedInVeh = IsPedInAnyVehicle(PlayerPedId(), true)
		local playerPed = GetPlayerPed(-1)
		local vehicle       = GetVehiclePedIsIn(playerPed)
		local health		= GetVehicleEngineHealth(vehicle)
		local police = true
		if ESX.PlayerData.job then
			if ESX.PlayerData.job.name == Config.PoliceDatabaseName then
        police = false
				for k,v in pairs(Config.ExtraZones) do
					for i = 1, #v.Pos, 1 do
						local distance = Vdist(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
						
						if (distance < 10.0) and insideMarker == false and pedInVeh then
							lastsleep = false
							DrawMarker(Config.PoliceExtraMarker, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z-0.97, 0.0, 0.0, 0.0, 0.0, 0, 0.0, Config.PoliceExtraMarkerScale.x, Config.PoliceExtraMarkerScale.y, Config.PoliceExtraMarkerScale.z, Config.PoliceExtraMarkerColor.r,Config.PoliceExtraMarkerColor.g,Config.PoliceExtraMarkerColor.b,Config.PoliceExtraMarkerColor.a, false, true, 2, true, false, false, false)
						end

						if (distance < 2.5 ) and insideMarker == false and pedInVeh then
							lastsleep = false
							DrawText3Ds(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, Config.ExtraDraw3DText)
							if IsControlJustPressed(0, Config.KeyToOpenExtraGarage) and GetVehicleClass(veh) == 18 then
								if health > Config.MinimumHealth then
								OpenMainMenu()
								insideMarker = true
								Citizen.Wait(500)
								else
									ESX.ShowNotification('~r~Pojazd musi być naprawiony')
								end
							end
						end
					end
				end
				if lastsleep then
					Citizen.Wait(400)
				end
			end
		end
    if police then
      Citizen.Wait(400)
    end
	end
end)

-- Police Color Main Menu:
function OpenMainColorMenu(colortype)
	local elements = {}
	for k,v in pairs(Config.Colors) do
		table.insert(elements, {
			label = v.label,
			value = v.value
		})
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'main_color_menu', {
		title    = Config.TitleColorType,
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		OpenColorMenu(data.current.type, data.current.value, colortype)
	end, function(data, menu)
		menu.close()
	end)
end

function DrawText3Ds(x,y,z, text)
  local onScreen,_x,_y=World3dToScreen2d(x,y,z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())

  SetTextScale(0.32, 0.32)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(255, 255, 255, 255)
  SetTextEntry("STRING")
  SetTextCentre(1)
  AddTextComponentString(text)
  DrawText(_x,_y)
  local factor = (string.len(text)) / 500
  DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
end

-- Police Color Menu:
function OpenColorMenu(type, value, colortype)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'extra_actions', {
		title    = Config.TitleValues,
		align    = 'top-left',
		elements = GetColors(value)
	}, function(data, menu)
		local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
		local pr,sec = GetVehicleColours(vehicle)
		if colortype == 'primary' then
			SetVehicleColours(vehicle, data.current.index, sec)
		elseif colortype == 'secondary' then
			SetVehicleColours(vehicle, pr, data.current.index)
		end
		
	end, function(data, menu)
		menu.close()
	end)
end

function OpenMainMenu()
	local elements = {
		{label = Config.LabelPrimaryCol,value = 'primary'},
		{label = Config.LabelSecondaryCol,value = 'secondary'},
		{label = Config.LabelExtra,value = 'Dodatek'},
		{label = Config.LabelLivery,value = 'Malowanie'}
	}
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'color_menu', {
		title    = Config.TitlePoliceExtra,
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'Dodatek' then
			OpenExtraMenu()
		elseif data.current.value == 'Malowanie' then
			OpenLiveryMenu()
		elseif data.current.value == 'primary' then
			OpenMainColorMenu('primary')
		elseif data.current.value == 'secondary' then
			OpenMainColorMenu('secondary')
		end
	end, function(data, menu)
		menu.close()
		insideMarker = false
	end)
end

function OpenExtraMenu()
	local elements = {}
	local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
	for id=0, 12 do
		if DoesExtraExist(vehicle, id) then
			local state = IsVehicleExtraTurnedOn(vehicle, id) 

			if state then
				table.insert(elements, {
					label = "Dodatek: "..id.." | "..('<span style="color:green;">%s</span>'):format("On"),
					value = id,
					state = not state
				})
			else
				table.insert(elements, {
					label = "Dodatek: "..id.." | "..('<span style="color:red;">%s</span>'):format("Off"),
					value = id,
					state = not state
				})
			end
		end
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'extra_actions', {
		title    = Config.TitlePoliceExtra,
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		SetVehicleExtra(vehicle, data.current.value, not data.current.state)
		local newData = data.current
		if data.current.state then
			newData.label = "Dodatek: "..data.current.value.." | "..('<span style="color:green;">%s</span>'):format("On")
		else
			newData.label = "Dodatek: "..data.current.value.." | "..('<span style="color:red;">%s</span>'):format("Off")
		end
		newData.state = not data.current.state

		menu.update({value = data.current.value}, newData)
		menu.refresh()
	end, function(data, menu)
		menu.close()
	end)
end

function OpenLiveryMenu()
	local elements = {}
	
	local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1))
	local liveryCount = GetVehicleLiveryCount(vehicle)
			
	for i = 1, liveryCount do
		local state = GetVehicleLivery(vehicle) 
		local text
		
		if state == i then
			text = "Malowanie: "..i.." | "..('<span style="color:green;">%s</span>'):format("On")
		else
			text = "Malowanie: "..i.." | "..('<span style="color:red;">%s</span>'):format("Off")
		end
		
		table.insert(elements, {
			label = text,
			value = i,
			state = not state
		}) 
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'livery_menu', {
		title    = Config.TitlePoliceLivery,
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		SetVehicleLivery(vehicle, data.current.value, not data.current.state)
		local newData = data.current
		if data.current.state then
			newData.label = "Malowanie: "..data.current.value.." | "..('<span style="color:green;">%s</span>'):format("On")
		else
			newData.label = "Malowanie: "..data.current.value.." | "..('<span style="color:red;">%s</span>'):format("Off")
		end
		newData.state = not data.current.state
		menu.update({value = data.current.value}, newData)
		menu.refresh()
		menu.close()	
	end, function(data, menu)
		menu.close()		
	end)
end

RegisterNetEvent('esx_policejob:kajdanki')
AddEventHandler('esx_policejob:kajdanki', function()
menu()
end)

-- function OpenPoliceActionsMenu()
-- 	ESX.UI.Menu.Open(
-- 	'default', GetCurrentResourceName(), 'police_actions',
-- 	{
-- 		title    = 'Police',
-- 		align    = 'bottom-right',
-- 		elements = elements

-- 	}, function(data, menu)
-- 		if data.current.value == 'citizen_interaction' then
-- 			local elements = {
-- 				{label = _U('id_card'),			value = 'identity_card'},
-- 				{label = _U('search'),			value = 'body_search'},
-- 				{label = _U('zakuj'),		value = 'zakuj'},
-- 				{label = _U('drag'),			value = 'drag'},
-- 				{label = _U('put_in_vehicle'),	value = 'put_in_vehicle'},
-- 				{label = _U('out_the_vehicle'),	value = 'out_the_vehicle'},
-- 			}
		
-- 			if Config.EnableLicenses then
-- 				table.insert(elements, { label = _U('license_check'), value = 'license' })
-- 			end
			
-- 			ESX.UI.Menu.Open(
-- 			'default', GetCurrentResourceName(), 'citizen_interaction',
-- 			{
-- 				title    = _U('citizen_interaction'),
-- 				align    = 'bottom-right',
-- 				elements = elements
-- 			}, function(data, menu)
-- 				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
-- 				if closestPlayer ~= -1 and closestDistance <= 3.0 then
-- 					local action = data2.current.value
--           local idfrajeraess = GetPlayerServerId(closestPlayer)
-- 					if action == 'identity_card' then
-- 						OpenIdentityCardMenu(closestPlayer)
--             local idfrajeraess = GetPlayerServerId(closestPlayer)
--             TriggerServerEvent('3dme:shareDisplayMe', 'Patrzy na dowód [' ..idfrajeraess..']')
-- 					elseif action == 'body_search' then
-- 						OpenBodySearchMenu(closestPlayer)
--             TriggerServerEvent('3dme:shareDisplayMe', 'Przeszukuje [' ..idfrajeraess..']')
-- 					elseif action == 'zakuj' then
--             if GetEntitySpeed(GetPlayerPed(-1)) > 0.5 or GetEntitySpeed(dupa) > 0.5 then
--               ESX.ShowNotification('~r~Nie możesz zakuwać w ruchu')
--             else
--              animacjazakuciarozkuciaxd()
--             Citizen.Wait(2000)
-- 						TriggerServerEvent('esx_policejob:handcuffhype', GetPlayerServerId(closestPlayer))
--           end
-- 					elseif action == 'drag' then
-- 						TriggerServerEvent('esx_policejob:drag', GetPlayerServerId(closestPlayer))
-- 					elseif action == 'put_in_vehicle' then
-- 						TriggerServerEvent('esx_policejob:putInVehicle', GetPlayerServerId(closestPlayer))
-- 					elseif action == 'out_the_vehicle' then
-- 						TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
-- 				else
-- 					ESX.ShowNotification(_U('no_players_nearby'))
-- 				end
-- 	end, function(data, menu)
-- 		menu.close()
-- 	end)
-- end

function menu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'police_actions',
	{
		title    = 'Kajdanki',
		align    = 'center',
		elements = {
			{label = 'Interakcje',	value = 'citizen_interaction'},
		}
	}, function(data, menu)

		if data.current.value == 'citizen_interaction' then
			local elements = {
				{label = _U('id_card'),			value = 'identity_card'},
				{label = _U('search'),			value = 'body_search'},
				{label = _U('zakuj'),		value = 'zakuj'},
				{label = _U('drag'),			value = 'drag'},
				{label = _U('put_in_vehicle'),	value = 'put_in_vehicle'},
				{label = _U('out_the_vehicle'),	value = 'out_the_vehicle'}
			}

			ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'citizen_interaction',
			{
				title    = 'Kajdanki',
				align    = 'center',
				elements = elements
			}, function(data2, menu2)
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 3.0 then
					local action = data2.current.value


          if action == 'identity_card' then
            OpenIdentityCardMenu(closestPlayer)
            local idfrajeraess = GetPlayerServerId(closestPlayer)
            TriggerServerEvent('3dme:shareDisplayMe', 'Patrzy na dowód [' ..idfrajeraess..']')
          elseif action == 'body_search' then
            local gracz = GetPlayerPed(closestPlayer)
            local idfrajeraess = GetPlayerServerId(closestPlayer)
            if IsPedCuffed(gracz) then
            OpenBodySearchMenu(closestPlayer)
            TriggerServerEvent('3dme:shareDisplayMe', 'Przeszukuje [' ..idfrajeraess..']')
            else
              ESX.ShowNotification("~w~Musisz zakuć osobę aby ją przeszukać.")
            end
          elseif action == 'zakuj' then
            if GetEntitySpeed(GetPlayerPed(-1)) > 0.5 or GetEntitySpeed(dupa) > 0.5 then
              ESX.ShowNotification('~r~Nie możesz zakuwać w ruchu')
            else
              animacjazakuciarozkuciaxd()
            Citizen.Wait(2000)
            TriggerServerEvent('esx_policejob:handcuffhype', GetPlayerServerId(closestPlayer))
          end
          elseif action == 'drag' then
            TriggerServerEvent('esx_policejob:drag', GetPlayerServerId(closestPlayer))
          elseif action == 'put_in_vehicle' then
            TriggerServerEvent('esx_policejob:putInVehicle', GetPlayerServerId(closestPlayer))
          elseif action == 'out_the_vehicle' then
            TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
					end
				else
					ESX.ShowNotification(_U('no_players_nearby'))
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end

	end, function(data, menu)
		menu.close()
	end)
end



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

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:dowod_pokazOdznake')
AddEventHandler('esx:dowod_pokazOdznake', function(id, imie, data, dodatek)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)
	if pid ~= -1 then
		local mugshot, mugshotStr = ESX.Game.GetPedMugshot(GetPlayerPed(pid))
		if pid == myId then
			PokazDokument(imie, data, dodatek, mugshotStr, 8, 9)
		elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 20.00 then
			PokazDokument(imie, data, dodatek, mugshotStr, 8, 9)
		end
		UnregisterPedheadshot(mugshot)
	end
end)

CreateThread(function()
    while true do
        Citizen.Wait(0)
        if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
            if IsControlJustReleased(0,74) and IsControlPressed(0,131) then
            TriggerServerEvent('iluka:pokaodznake', GetPlayerPed(-1))
            end
		else
			Citizen.Wait(2000)
        end
    end
end)

function PokazDokument(title, subject, msg, icon, iconType, color)
    SetNotificationTextEntry('STRING')
    SetNotificationBackgroundColor(color)
	AddTextComponentString(msg)
	SetNotificationMessage(icon, icon, false, iconType, title, subject)
	DrawNotification(false, false)
end

function jestzakuty()
	return IsHandcuffed
end