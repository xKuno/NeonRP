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


local IsJailed = false
local unjail = false
local JailTime = 0
local fastTimer = 0
local working = false
local jobNumber = nil
local isWorking = false
local jobDestination = nil
local CurrentAction = nil
local hasAlreadyEnteredMarker = false
local jobBlips = {}
local JailLocation = Config.JailLocation
local pracuje = true

ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(5)
	end
end)

function getJailStatus()
	return IsJailed
end
local i = 0
RegisterNetEvent('bestup_jailer:jail')
AddEventHandler('bestup_jailer:jail', function(jailTime)
	if IsJailed then -- don't allow multiple jails
		return
	end


	JailTime = jailTime
	local sourcePed = GetPlayerPed(-1)
	if DoesEntityExist(sourcePed) then
		Citizen.CreateThread(function()
		
			-- Assign jail skin to user
			TriggerEvent('skinchanger:getSkin', function(skin)
				if skin.sex == 0 then
					TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms['prison_wear'].male)
				else
					TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms['prison_wear'].female)
				end
			end)
			
			-- Clear player
			SetPedArmour(sourcePed, 0)
			ClearPedBloodDamage(sourcePed)
			ResetPedVisibleDamage(sourcePed)
			ClearPedLastWeaponDamage(sourcePed)
			ResetPedMovementClipset(sourcePed, 0)
			
			SetEntityCoords(sourcePed, JailLocation.x, JailLocation.y, JailLocation.z)
			IsJailed = true
			unjail = false
				while JailTime > 0 and not unjail do
					sourcePed = GetPlayerPed(-1)
					RemoveAllPedWeapons(sourcePed, true)
					if IsPedInAnyVehicle(sourcePed, false) then
						ClearPedTasksImmediately(sourcePed)
					end

					i = i + 1
					if i >= 60 then
						TriggerServerEvent('bestup_jailer:updateRemaining', JailTime)
						i = 0
					end
					Citizen.Wait(1000)


					-- Is the player trying to escape?
					if GetDistanceBetweenCoords(GetEntityCoords(sourcePed), JailLocation.x, JailLocation.y, JailLocation.z) > 130 then
						if not unjail then
							local rand = math.random(0,135)
							if rand == 1 then
								TriggerEvent('chat:addMessage', { args = { _U('straznik'), "Haha i tak nie uciekniesz" }, color = { 147, 196, 109 } })
									local playerPed = PlayerPedId()
									local playerPed = PlayerPedId()
									PedPosition		= GetEntityCoords(playerPed)
									
									local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }

									local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
									TriggerServerEvent('gunshotInProgressPoss', plyPos.x, plyPos.y, plyPos.z)
									unjail = true
									JailTime = 0
									fastTimer = 0
									IsJailed = false
							else
								SetEntityCoords(sourcePed, JailLocation.x, JailLocation.y, JailLocation.z)
								TriggerEvent('chat:addMessage', { args = { _U('straznik'), "Strażnik cie znalazł! wracasz do więzienia" }, color = { 147, 196, 109 } })
								TriggerEvent('chat:addMessage', { args = { _U('straznik'), "Spróbuj kolejny raz!" }, color = { 147, 196, 109 } })
							end
						end

					end
					
					JailTime = xx
				end
			if not unjail then
				-- jail time served
				-- print(JailTime)
				TriggerServerEvent('bestup_jailer:unjailTime', JailTime)
				SetEntityCoords(sourcePed, Config.JailBlip.x, Config.JailBlip.y, Config.JailBlip.z)
				IsJailed = false
				-- Change back the user skin
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)
			end
		end)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if JailTime > 0 and IsJailed then
			if fastTimer < 0 then
				fastTimer = JailTime
			end
			draw2dText(_U('remaining_msg', ESX.Round(fastTimer)), { 0.161, 0.855 } )
			fastTimer = fastTimer - 0.01
			xx = ESX.Round(fastTimer)
		else
			Citizen.Wait(1000)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsJailed then
			if not working then
				DisplayRadar(true)
				CreateJob()
			else
				DisplayRadar(true)
				local isInMarker = false
				local coords = GetEntityCoords(PlayerPedId())				
				if GetDistanceBetweenCoords(coords, jobDestination.Pos.x, jobDestination.Pos.y, jobDestination.Pos.z, true) < 30 then
					ESX.Game.Utils.DrawText3D({ ["x"] = jobDestination.Pos.x, ["y"] = jobDestination.Pos.y, ["z"] = jobDestination.Pos.z, ["h"] = 137.83 }, "[E] Aby ~g~pracować", 1.0)
					if GetDistanceBetweenCoords(coords, jobDestination.Pos.x, jobDestination.Pos.y, jobDestination.Pos.z, true) < 3 then
						ESX.ShowHelpNotification('Wcisnij ~INPUT_CONTEXT~ aby pracować')
						if IsControlJustReleased(0, 38) then
							if pracuje == true then
								pracuje = false
								StartWork()
								Citizen.Wait(9000)
								pracuje = true
							else
								ESX.ShowAdvancedNotification('Więzienie', 'Praca', 'Musisz poczekać chwile', 'CHAR_BLOCKED', 8)
							end
						end
					end
				end
			end			
		end
	end
end)

function CreateJob()
	local newJob
	repeat
		newJob = math.random(1, #Config.Jobs.List)
		Citizen.Wait(1)
	until newJob ~= jobNumber

	working = true
	jobNumber = newJob
	jobDestination = Config.Jobs.List[jobNumber]
	DisplayRadar(true)
	CreateBlip(jobDestination)
end

function CreateBlip(cords)
	if jobBlips['job'] ~= nil then
		RemoveBlip(jobBlips['job'])
	end

	jobBlips['job'] = AddBlipForCoord(cords.Pos.x, cords.Pos.y, cords.Pos.z)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Praca więzienna ' .. cords.Name)
	EndTextCommandSetBlipName(jobBlips['job'])
end


function StartWork()
    canwork = false
    isWorking = true
	local delay = math.random(5000, 10000)
	DisplayRadar(true)
    if Config.Notify == true then
        TriggerEvent("pNotify:SetQueueMax", "work", 2)
        TriggerEvent("pNotify:SendNotification", {
            text = "Zaczynasz pracować",
            type = "error",
            queue = "work",
            timeout = 5000,
            layout = "centerRight"
		})
    else
        ESX.ShowNotification('~g~Pracujesz...')
    end
    FreezeEntityPosition(PlayerPedId(), true)
 
    Citizen.CreateThread(function()
        Citizen.Wait(delay)
        isWorking = false
 
        local minusTime = math.random(15,30)
        JailTime = JailTime - minusTime
        TriggerServerEvent('bestup_jailer:updateRemaining', JailTime)
        fastTimer = fastTimer - minusTime
        if Config.Notify == true then
            TriggerEvent("pNotify:SetQueueMax", "work", 2)
            TriggerEvent("pNotify:SendNotification", {
                text = "Od twojej odsiadki odjęto " .. minusTime ..  " miesięcy!",
                type = "error",
                queue = "work",
                timeout = 5000,
                layout = "centerRight"
            })
		else
            ESX.ShowNotification('Od twojej odsiadki odjęto ~r~' .. minusTime .. '~w~ sekund!')
        end
        CreateJob()
        FreezeEntityPosition(PlayerPedId(), false)
        canwork = true
    end)
end

RegisterNetEvent('bestup_jailer:unjail')
AddEventHandler('bestup_jailer:unjail', function(source)
	unjail = true
	JailTime = 0
	fastTimer = 0
	IsJailed = false
	working = false
	SetCanAttackFriendly(sourcePed, true, false)
	NetworkSetFriendlyFireOption(true)
	RemoveBlip(jobBlips['job'])
	sourcePed = GetPlayerPed(-1)
	SetEntityCoords(sourcePed, Config.JailBlip.x, Config.JailBlip.y, Config.JailBlip.z)
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)
end)

-- Create Blips
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.JailBlip.x, Config.JailBlip.y, Config.JailBlip.z)
	SetBlipSprite (blip, 188)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.8)
	SetBlipColour (blip, 4)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString(_U('blip_name'))
	EndTextCommandSetBlipName(blip)
end)

function draw2dText(text, pos)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextScale(0.45, 0.45)
	SetTextColour(255, 255, 255, 255)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()

	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(table.unpack(pos))
end

-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(5)
--         local plyCoords = GetEntityCoords(GetPlayerPed(-1), false) 
--         local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, 1666.064, 2555.225, 45.563)

--         if dist <= 10.0 then
--             DrawMarker(25, 1666.064, 2555.225, 45.563-0.90, 0, 0, 0, 0, 0, 0, 1.301, 1.3001, 1.3001, 0, 205, 250, 200, 0, 0, 0, 0)
--         else
--             Citizen.Wait(1500)
--         end
--         if dist <= 2.0 then
--             DrawText3D(1666.064, 2555.225, 45.563, "~g~[E]~r~ Aby skorzystać z stołówki!")
--             if IsJailed then
--                 if IsControlJustPressed(0, Keys['E']) then
--                     TriggerServerEvent('esx_jailerinos:dajzarcie')
--                     Citizen.Wait(100)
--                 end
--             end
--         end
--     end
-- end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsJailed then
				local isInMarker = true
				local coords = GetEntityCoords(PlayerPedId())				
				if GetDistanceBetweenCoords(coords, 1666.064, 2555.225, 45.563, true) < 30 then
					ESX.Game.Utils.DrawText3D({ ["x"] = 1666.064, ["y"] = 2555.225, ["z"] = 45.563, ["h"] = 137.83 }, "[E] Aby skorzystać z stołówki!", 1.0)
					if GetDistanceBetweenCoords(coords, 1666.064, 2555.225, 45.563, true) < 3 then
						ESX.ShowHelpNotification('Wcisnij ~INPUT_CONTEXT~ Aby skorzystać z stołówki!')
						if IsControlJustReleased(0, 38) then
							TriggerServerEvent('esx_jailerinos:dajzarcie')
								ESX.ShowAdvancedNotification('Więzienie', 'Praca', 'Musisz poczekać chwile', 'CHAR_BLOCKED', 8)
							end

				end
			end			
		end
	end
end)

function round(x)
	return x >= 0 and math.floor(x + 0.5) or math.ceil(x - 0.5)
end
AddEventHandler('playerSpawned', function(spawn)
	if IsJailed then
		SetEntityCoords(GetPlayerPed(-1), JailLocation.x, JailLocation.y, JailLocation.z)
	else
		TriggerServerEvent('bestup_jailer:checkJail')
	end
end)

-- When script starts
Citizen.CreateThread(function()
	Citizen.Wait(0) -- wait for mysql-async to be ready, this should be enough time
	TriggerServerEvent('bestup_jailer:checkJail')
end)