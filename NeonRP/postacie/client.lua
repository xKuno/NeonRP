local connected = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(5)
	end
end)


AddEventHandler("playerSpawned", function()
	if not connected then
		TriggerServerEvent("rocademption:playerConnected")
		connected = true
	end
end)
local loadingStatus = 0
local _in = Citizen.InvokeNative

-- function LoadNeonRP()
-- 	PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
-- 	local ped = PlayerPedId()
-- 	FreezeEntityPosition(ped, false)
-- 	SetEntityVisible(ped, true)
-- 	SetPlayerInvincible(PlayerId(), false)
-- 	StopAudioScene("MP_LEADERBOARD_SCENE")
-- 	DoScreenFadeOut(0)
-- 	ShutdownLoadingScreen()
-- 	ShutdownLoadingScreenNui()
-- 	loadingPosition = true
-- 	loadingStatus = 3
-- 	Citizen.Wait(1000)
-- 	DoScreenFadeIn(5500)
-- 	while IsScreenFadingIn() do
-- 		Citizen.Wait(0)
-- 	end
-- 	ESX.UI.HUD.SetDisplay(1.0)
-- 	TriggerEvent('chat:display', true)
-- 	TriggerEvent('chat:clear')
-- 	Citizen.Wait(1000)
-- end

-- AddEventHandler('WyspaRP:loading', function(cb)
-- 	cb(loadingStatus)
-- end)

-- RegisterNetEvent('esx:playerLoaded')
-- AddEventHandler('esx:playerLoaded', function(xPlayer)
-- 	print('[NeonRP] Postac zaladowana')
-- 	if not loadingPosition then
-- 		ESX.UI.HUD.SetDisplay(0.0)

-- 		local update = true
-- 		if xPlayer.loadPosition then
-- 			local t = type(xPlayer.loadPosition)
-- 			if t == 'table' or t == 'vec3' or t == 'vec4' then
-- 				update = false
-- 				loadingPosition = xPlayer.loadPosition
-- 			end
-- 		end

-- 		loadingStatus = 1
-- 		if update then
-- 			loadingPosition = {x = -1044.5974, y = -2749.9673, z = 20.4134}
-- 		end

-- 		local ped = PlayerPedId()
-- 		SetEntityVisible(ped, false)
-- 		SetPlayerInvincible(PlayerId(), true)

-- 		FreezeEntityPosition(ped, true)
-- 		print('[NeonRP] Przeniesiono do poczekalni')
-- 	end
-- end)

-- AddEventHandler('skinchanger:modelLoaded', function()
-- 	print('[NeonRP] Model zaladowany')
-- 	ModelLoaded()
-- end)

-- AddEventHandler('WyspaRP:passthrough', function()
-- 	print('[NeonRP] Nowy gracz, ladowanie')
-- 	ModelLoaded()
-- end)

-- function ModelLoaded()
-- 	if loadingStatus < 2 then
-- 		Citizen.CreateThreadNow(function()
-- 			print('[NeonRP] Oczekiwanie na zaladowanie postaci')
-- 			while not loadingPosition do
-- 				Citizen.Wait(0)
-- 			end

-- 			Citizen.Wait(1000)
-- 			loadingStatus = 2
-- 			SendLoadingScreenMessage(json.encode({allow = true}))
-- 			print('[NeonRP] Odblokowano wejscie (LPM)')
-- 		end)
-- 	end
-- end

-- Citizen.CreateThread(function()
-- 	SetManualShutdownLoadingScreenNui(true)
-- 	StartAudioScene("MP_LEADERBOARD_SCENE")
-- 	SendLoadingScreenMessage(json.encode({ready = true}))

-- 	TriggerEvent('chat:display', false)
-- 	while true do
-- 		Citizen.Wait(0)
-- 		if loadingStatus == 2 and IsControlJustPressed(0, 18) then
-- 			LoadNeonRP()
-- 			break
-- 		end
-- 	end
-- end)

-- RegisterCommand('play', function(source, args, raw)
-- 	if loadingStatus == 2 then
-- 		Citizen.CreateThreadNow(LoadNeonRP)
-- 	else
-- 		awayTimer = 0
-- 		if awayThread then
-- 			TerminateThread(awayThread)
-- 			awayThread = nil
-- 		end
-- 	end
-- end, false)
