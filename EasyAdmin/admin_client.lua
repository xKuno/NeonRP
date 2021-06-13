------------------------------------
------------------------------------
---- DONT TOUCH ANY OF THIS IF YOU DON'T KNOW WHAT YOU ARE DOING
---- THESE ARE **NOT** CONFIG VALUES, USE THE CONVARS IF YOU WANT TO CHANGE SOMETHING
------------------------------------
------------------------------------

players = {}
banlist = {}
cachedplayers = {}

RegisterNetEvent("EasyAdmin:adminresponse")
RegisterNetEvent("EasyAdmin:amiadmin")
RegisterNetEvent("EasyAdmin:fillBanlist")
RegisterNetEvent("EasyAdmin:requestSpectate")

RegisterNetEvent("EasyAdmin:SetSetting")
RegisterNetEvent("EasyAdmin:SetLanguage")

RegisterNetEvent("EasyAdmin:TeleportRequest")
RegisterNetEvent("EasyAdmin:SlapPlayer")
RegisterNetEvent("EasyAdmin:FreezePlayer")
RegisterNetEvent("EasyAdmin:CaptureScreenshot")
RegisterNetEvent("EasyAdmin:GetPlayerList")
RegisterNetEvent("EasyAdmin:GetInfinityPlayerList")
RegisterNetEvent("EasyAdmin:fillCachedPlayers")


AddEventHandler('EasyAdmin:adminresponse', function(response,permission)
	permissions[response] = permission
	if permission == true then
		isAdmin = true
	end
end)

AddEventHandler('EasyAdmin:SetSetting', function(setting,state)
	settings[setting] = state
end)

AddEventHandler('EasyAdmin:SetLanguage', function(newstrings)
	strings = newstrings
end)


AddEventHandler("EasyAdmin:fillBanlist", function(thebanlist)
	banlist = thebanlist
end)

AddEventHandler("EasyAdmin:fillCachedPlayers", function(thecached)
	if permissions.ban then
		cachedplayers = thecached
	end
end)

AddEventHandler("EasyAdmin:GetPlayerList", function(players)
	playerlist = players
end)

AddEventHandler("EasyAdmin:GetInfinityPlayerList", function(players)
	playerlist = players
end)

Citizen.CreateThread( function()
  while true do
    Citizen.Wait(0)
		if frozen then
			local localPlayerPedId = PlayerPedId()
			FreezeEntityPosition(localPlayerPedId, frozen)
			if IsPedInAnyVehicle(localPlayerPedId, true) then
				FreezeEntityPosition(GetVehiclePedIsIn(localPlayerPedId, false), frozen)
			end 
		end
  end
end)

AddEventHandler('EasyAdmin:requestSpectate', function(playerServerId, tgtCoords)
	local localPlayerPed = PlayerPedId()
	if ((not tgtCoords) or (tgtCoords.z == 0.0)) then tgtCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(playerServerId))) end
	if playerServerId == GetPlayerServerId(PlayerId()) then 
		if oldCoords then
			RequestCollisionAtCoord(oldCoords.x, oldCoords.y, oldCoords.z)
			Wait(500)
			SetEntityCoords(playerPed, oldCoords.x, oldCoords.y, oldCoords.z, 0, 0, 0, false)
			oldCoords=nil
		end
		spectatePlayer(GetPlayerPed(PlayerId()),GetPlayerFromServerId(PlayerId()),GetPlayerName(PlayerId()))
		frozen = false
		return 
	else
		if not oldCoords then
			oldCoords = GetEntityCoords(PlayerPedId())
		end
	end
	SetEntityCoords(localPlayerPed, tgtCoords.x, tgtCoords.y, tgtCoords.z - 10.0, 0, 0, 0, false)
	frozen = true
	stopSpectateUpdate = true
	local adminPed = localPlayerPed
	local playerId = GetPlayerFromServerId(playerServerId)
	repeat
		Wait(200)
		playerId = GetPlayerFromServerId(playerServerId)
	until ((GetPlayerPed(playerId) > 0) and (playerId ~= -1))
	spectatePlayer(GetPlayerPed(playerId),playerId,GetPlayerName(playerId))
	stopSpectateUpdate = false 
end)



Citizen.CreateThread( function()
	while true do
		Citizen.Wait(500)
		if drawInfo and not stopSpectateUpdate then
			local localPlayerPed = PlayerPedId()
			local targetPed = GetPlayerPed(drawTarget)
			local targetGod = GetPlayerInvincible(drawTarget)

			local tgtCoords = GetEntityCoords(targetPed)
			if tgtCoords and tgtCoords.x ~= 0 then
				SetEntityCoords(localPlayerPed, tgtCoords.x, tgtCoords.y, tgtCoords.z - 10.0, 0, 0, 0, false)
			end
		end
	end
end)


AddEventHandler('EasyAdmin:TeleportRequest', function(id, tgtCoords)
	if id then
		if (tgtCoords.x == 0.0 and tgtCoords.y == 0.0 and tgtCoords.z == 0.0) then
			local tgtPed = GetPlayerPed(GetPlayerFromServerId(id))
			tgtCoords = GetEntityCoords(tgtPed)
		end
		SetEntityCoords(PlayerPedId(), tgtCoords.x, tgtCoords.y, tgtCoords.z,0,0,0, false)
	else
		SetEntityCoords(PlayerPedId(), tgtCoords.x, tgtCoords.y, tgtCoords.z,0,0,0, false)
	end
end)

AddEventHandler('EasyAdmin:SlapPlayer', function(slapAmount)
	local ped = PlayerPedId()
	if slapAmount > GetEntityHealth(ped) then
		ApplyDamageToPed(ped, 5000, false, true,true)
	else
		ApplyDamageToPed(ped, slapAmount, false, true,true)
	end
end)


RegisterCommand("kick", function(source, args, rawCommand)
	local source=source
	local reason = ""
	for i,theArg in pairs(args) do
		if i ~= 1 then -- make sure we are not adding the kicked player as a reason
			reason = reason.." "..theArg
		end
	end
	if args[1] and tonumber(args[1]) then
		TriggerServerEvent("EasyAdmin:kickPlayer", tonumber(args[1]), reason)
	end
end, false)

-- RegisterCommand("ban", function(source, args, rawCommand)
-- 	if args[1] and tonumber(args[1]) then
-- 		local reason = ""
-- 		for i,theArg in pairs(args) do
-- 			if i ~= 1 then
-- 				reason = reason.." "..theArg
-- 			end
-- 		end
-- 		if args[1] and tonumber(args[1]) then
-- 			TriggerServerEvent("EasyAdmin:banPlayer", tonumber(args[1]), reason, false, GetPlayerName(args[1]))
-- 		end
-- 	end
-- end, false)

AddEventHandler('EasyAdmin:FreezePlayer', function(toggle)
	frozen = toggle
	FreezeEntityPosition(PlayerPedId(), frozen)
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		FreezeEntityPosition(GetVehiclePedIsIn(PlayerPedId(), false), frozen)
	end 
end)


AddEventHandler('EasyAdmin:CaptureScreenshot', function(toggle, url, field)
	exports['screenshot-basic']:requestScreenshotUpload(GetConvar("ea_screenshoturl", 'https://wew.wtf/upload.php'), GetConvar("ea_screenshotfield", 'files[]'), function(data)
			TriggerServerEvent("EasyAdmin:TookScreenshot", data)
	end)
end)

function spectatePlayer(targetPed,target,name)
	local playerPed = PlayerPedId() -- yourself
	enable = true
	if (target == PlayerId() or target == -1) then 
		enable = false
		print("Target Player is ourselves, disabling spectate.")
	end
	if(enable)then
			if targetPed == playerPed then
				Wait(500)
				targetPed = GetPlayerPed(target)
			end
			local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))

			RequestCollisionAtCoord(targetx,targety,targetz)
			NetworkSetInSpectatorMode(true, targetPed)
			OpenAdminActionMenu(target)
			DrawPlayerInfo(target)
			if not RedM then
				ShowNotification(string.format(GetLocalisedText("spectatingUser"), name))
			end
	else
			if oldCoords then
				RequestCollisionAtCoord(oldCoords.x, oldCoords.y, oldCoords.z)
				Wait(500)
				SetEntityCoords(playerPed, oldCoords.x, oldCoords.y, oldCoords.z, 0, 0, 0, false)
				oldCoords=nil
			end
			NetworkSetInSpectatorMode(false, targetPed)
			StopDrawPlayerInfo()
			if not RedM then
				ShowNotification(GetLocalisedText("stoppedSpectating"))
			end
			frozen = false

	end
end

function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(0,1)
end
RegisterNetEvent("EasyAdmin:showNotification")
AddEventHandler("EasyAdmin:showNotification", function(text, important)
	BeginTextCommandThefeedPost("STRING")
	AddTextComponentString(text)
	EndTextCommandThefeedPostTicker(important,0)
end)

function OpenAdminActionMenu(target)

    ESX.TriggerServerCallback('route68_spect:daneInnegoGracza', function(data)

      local jobLabel    = nil
      local sexLabel    = nil
      local sex         = nil
      local dobLabel    = nil
      local heightLabel = nil
      local idLabel     = nil
	  local Money		= 0
	  local Bank		= 0
	  local blackMoney	= 0
	  local Inventory	= nil

    for i=1, #data.accounts, 1 do
      if data.accounts[i].name == 'black_money' then
        blackMoney = data.accounts[i].money
      end
    end

	  if data.job.grade_label ~= nil and  data.job.grade_label ~= '' then
        jobLabel = 'Job : ' .. data.job.label .. ' - ' .. data.job.grade_label
      else
        jobLabel = 'Job : ' .. data.job.label
      end

      if data.sex ~= nil then
        if (data.sex == 'm') or (data.sex == 'M') then
          sex = 'Male'
        else
          sex = 'Female'
        end
        sexLabel = 'Płeć : ' .. sex
      else
        sexLabel = 'Płeć : Nieznana'
      end

	  if data.money ~= nil then
		Money = data.money
		else
		Money = 'No Data'
	  end

 	  if data.bank ~= nil then
		Bank = data.bank
		else
		Bank = 'No Data'
	  end

      if data.dob ~= nil then
        dobLabel = 'DOB : ' .. data.dob
      else
        dobLabel = 'DOB : Nieznzny'
      end

      if data.height ~= nil then
        heightLabel = 'Wzrost : ' .. data.height
      else
        heightLabel = 'Wzrost : Nieznzny'
      end

      if data.name ~= nil then
        idLabel = 'Steam ID : ' .. data.name
      else
        idLabel = 'Steam ID : Nieznzny'
      end

      local elements = {
        {label = 'Dane: ' .. data.firstname .. " " .. data.lastname, value = nil},
        {label = 'Gotówka: '.. data.money, value = nil},
        {label = 'Bank: '.. data.bank, value = nil},
        {label = 'Brudna Gotówka: '.. blackMoney, value = nil, itemType = 'item_account', amount = blackMoney},
		{label = jobLabel,    value = nil},
        {label = idLabel,     value = nil},
    }

    table.insert(elements, {label = '--- Ekwipunek ---', value = nil})

    for i=1, #data.inventory, 1 do
      if data.inventory[i].count > 0 then
        table.insert(elements, {
          label          = data.inventory[i].label .. ' x ' .. data.inventory[i].count,
          value          = nil,
          itemType       = 'item_standard',
          amount         = data.inventory[i].count,
        })
      end
    end

    table.insert(elements, {label = '--- Bronie ---', value = nil})

    for i=1, #data.weapons, 1 do
      table.insert(elements, {
        label          = ESX.GetWeaponLabel(data.weapons[i].name),
        value          = nil,
        itemType       = 'item_weapon',
        amount         = data.ammo,
      })
    end
      if data.licenses ~= nil then

        table.insert(elements, {label = '--- Licencje ---', value = nil})

        for i=1, #data.licenses, 1 do
          table.insert(elements, {label = data.licenses[i].label, value = nil})
        end

      end

      ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'citizen_interaction',
        {
          title    = 'Neon-Admin',
          align    = 'left',
          elements = elements,
        },
        function(data, menu)

        end,
        function(data, menu)
          menu.close()
        end
      )

    end, GetPlayerServerId(target))
end
