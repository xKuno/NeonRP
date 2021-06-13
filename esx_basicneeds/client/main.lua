ESX          = nil
local IsDead = false
local IsAnimated = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

AddEventHandler('esx_basicneeds:resetStatus', function()
	TriggerEvent('esx_status:set', 'hunger', 500000)
	TriggerEvent('esx_status:set', 'thirst', 500000)
end)

RegisterNetEvent('esx_basicneeds:healPlayer')
AddEventHandler('esx_basicneeds:healPlayer', function()
	-- restore hunger & thirst
	TriggerEvent('esx_status:set', 'hunger', 1000000)
	TriggerEvent('esx_status:set', 'thirst', 1000000)

	-- restore hp
	local playerPed = PlayerPedId()
	SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
end)

AddEventHandler('esx:onPlayerDeath', function()
	IsDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	if IsDead then
		TriggerEvent('esx_basicneeds:resetStatus')
	end

	IsDead = false
end)

AddEventHandler('esx_status:loaded', function(status)

	TriggerEvent('esx_status:registerStatus', 'hunger', 1000000, '#CFAD0F', function(status)
		return true
	end, function(status)
		status.remove(100)
	end)

	TriggerEvent('esx_status:registerStatus', 'thirst', 1000000, '#0C98F1', function(status)
		return true
	end, function(status)
		status.remove(75)
	end)

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1000)

			local playerPed  = PlayerPedId()
			local prevHealth = GetEntityHealth(playerPed)
			local health     = prevHealth

			TriggerEvent('esx_status:getStatus', 'hunger', function(status)
				if status.val == 0 then
					if prevHealth <= 150 then
						health = health - 5
					else
						health = health - 1
					end
				end
			end)

			TriggerEvent('esx_status:getStatus', 'thirst', function(status)
				if status.val == 0 then
					if prevHealth <= 150 then
						health = health - 5
					else
						health = health - 1
					end
				end
			end)

			if health ~= prevHealth then
				SetEntityHealth(playerPed, health)
			end
		end
	end)
end)

AddEventHandler('esx_basicneeds:isEating', function(cb)
	cb(IsAnimated)
end)

RegisterNetEvent('esx_basicneeds:onEat')
AddEventHandler('esx_basicneeds:onEat', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_sandwich_01'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.135, 0.02, 0.05, -30.0, -120.0, -60.0, 1, 1, 0, 1, 1, 1)

			ESX.Streaming.RequestAnimDict('mp_player_inteat@burger', function()
				TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 8.0, 3.0, -1, 51, 1, 0, 0, 0)

				Citizen.Wait(3000)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)
		end)

	end
end)

RegisterNetEvent('esx_basicneeds:onDrink')
AddEventHandler('esx_basicneeds:onDrink', function()
	if not IsAnimated then
		local playerPed  = PlayerPedId()
		local coords     = GetEntityCoords(playerPed)
		local boneIndex  = GetPedBoneIndex(playerPed, 18905)

		IsAnimated = true
		ESX.Game.SpawnObject('prop_ld_flow_bottle', {
			x = coords.x,
			y = coords.y,
			z = coords.z - 3
		}, function(object)
			RequestAnimDict('mp_player_intdrink')  
			while not HasAnimDictLoaded('mp_player_intdrink') do
				Citizen.Wait(0)
			end

			AttachEntityToEntity(object, playerPed, boneIndex, 0.09, -0.065, 0.045, -100.0, 0.0, -25.0, 1, 1, 0, 1, 1, 1)
			TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, -1, 48, 0.0, false, false, false)
			Citizen.Wait(4000)

	        IsAnimated = false
	        ClearPedSecondaryTask(playerPed)
			DeleteObject(object)
		end)
	end
end)

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

----- esx_panta:energetyk

RegisterNetEvent('esx_cigarett:startSmoke')
AddEventHandler('esx_cigarett:startSmoke', function(source)
	SmokeAnimation()
end)

function SmokeAnimation()
	local playerPed = GetPlayerPed(-1)
	
	Citizen.CreateThread(function()
		TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING", 0, true)        
		Notify("")      
	end)
end

function Notify(message,title)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    SetNotificationMessage("CHAR_LESTER_DEATHWISH", "CHAR_LESTER_DEATHWISH", true, 4, "~h~Palenie papierosów", "~h~~r~Szkodzi zdrowiu ")
	DrawNotification(false, true)
end


------------------------------------------------------------------------------------------

RegisterNetEvent('esx_panta:energetyk')
AddEventHandler('esx_panta:energetyk', function(source)
	NotifyEnergetyk("") 
end)

function NotifyEnergetyk(message,title)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    SetNotificationMessage("CHAR_MP_STRIPCLUB_PR", "CHAR_MP_STRIPCLUB_PR", true, 4, "~h~Wypito Energetyka", "~h~~y~Czujesz się rozbudzony")
	DrawNotification(false, true)
end



RegisterNetEvent('esx_panta:alko')
AddEventHandler('esx_panta:alko', function(source)
	NotifyAlko("") 
end)

function NotifyAlko(message,title)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    SetNotificationMessage("CHAR_MP_STRIPCLUB_PR", "CHAR_MP_STRIPCLUB_PR", true, 4, "~h~Napito sie Alkoholu", "~h~~p~Czujesz sie napierdolony")
	DrawNotification(false, true)
end

------------------------------------------------------------------------------------------

RegisterNetEvent('esx_panta:chleb')
AddEventHandler('esx_panta:chleb', function(source)
	NotifyChleb("") 
end)

function NotifyChleb(message,title)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    SetNotificationMessage("CHAR_MP_STRIPCLUB_PR", "CHAR_MP_STRIPCLUB_PR", true, 4, "~h~Zjedzono Jedzenie", "~h~~o~Czujesz się Masno Ni")
	DrawNotification(false, true)
end

------------------------------------------------------------------------------------------

RegisterNetEvent('esx_panta:water')
AddEventHandler('esx_panta:water', function(source)
	NotifyWater("") 
end)

function NotifyWater(message,title)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    SetNotificationMessage("CHAR_MP_STRIPCLUB_PR", "CHAR_MP_STRIPCLUB_PR", true, 4, "~h~Wypito Napój", "~h~~b~Czujesz sie orzeźwiono")
	DrawNotification(false, true)
end

------------------------------------------------------------------------------------------

RegisterNetEvent('esx_panta:none')
AddEventHandler('esx_panta:none', function(source)
	NotifyNone("") 
end)

function NotifyNone(message,title)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    SetNotificationMessage("CHAR_BLOCKED", "CHAR_BLOCKED", true, 4, "~h~Nieposiadasz Zapalniczki", "~h~~r~Kup Jedną w Sklepie")
	DrawNotification(false, true)
end