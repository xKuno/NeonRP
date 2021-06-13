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


local szansanaznalezienie = 10 -- szansa na znalezienie bursztynu (by wojtek.cfg XD) (japa wojtek)


-- NIE DOTYKAĆ
local hcap				  = false 


ESX = nil
local ustaw = false
Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)
--
RegisterNetEvent('freezeplayer')
AddEventHandler('freezeplayer', function(freeze)
	FreezeEntityPosition(PlayerPedId(), freeze)
end)
--
RegisterNetEvent('elowojtek')
AddEventHandler('elowojtek', function()
	Citizen.CreateThread(function()
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		local procent = 0
		local stan = 1
		local player = PlayerPedId()
		ustaw = true
		ClearPedTasks(ped)
		TriggerEvent('freezeplayer', true)
        TaskStartScenarioInPlace(GetPlayerPed(-1), "world_human_gardener_plant", 0, true)
		while procent <= 1000 do
			ESX.Game.Utils.DrawText3D(coords, "Szukanie ~o~bursztynów: ~w~" .. tonumber(procent * 0.1) ..'%', 0.4)
			Wait(0)
			procent = procent + 1
		end
		local wylosowano = math.random(1,100)
		if szansanaznalezienie < wylosowano then
		TriggerServerEvent('szukb', stan)
		TriggerEvent('esx:showNotification', '~g~Znalazłeś bursztyn')
		else
		TriggerEvent('esx:showNotification', '~r~Nie znalazłeś żadnych bursztynów')
		end
		ClearPedTasks(ped)
		TriggerEvent('freezeplayer', false)
		ustaw = false
	end)
end)
--
Citizen.CreateThread(function()
	while true do
		Wait(0)
    local coords = GetEntityCoords(PlayerPedId())
			if GetDistanceBetweenCoords(coords, -1580.27, -1209.21, 1.44, true) < 30 and ustaw == false then
				DrawText3DTest(-1580.27, -1209.21, 1.44, '~g~Zbieranie bursztynow', 0.3)
			end

			if GetDistanceBetweenCoords(coords, -1684.96, -1068.65, 13.1, true) < 30 and ustaw == false then
				DrawText3DTest(-1684.96, -1068.65, 13.1, '~g~Sprzedawanie bursztynów', 0.3)
			end

			if GetDistanceBetweenCoords(coords, -1802.27, -1205.74, 14.30, true) < 30 and ustaw == false then
				DrawText3DTest(-1802.27, -1205.74, 14.30, '~g~Szlifowanie bursztynów', 0.3)
			end

			if GetDistanceBetweenCoords(coords, -1526.74, -1183.33, 0.61, true) < 30 and ustaw == false then
				DrawText3DTest(-1526.74, -1183.33, 0.61, '~g~Mycie bursztynów', 0.3)
			end
			
  end
end)
--
RegisterNetEvent('sharley_bursztyny:opluk')
AddEventHandler('sharley_bursztyny:opluk', function()
	if hcap == false then
		hcap = true
	DoScreenFadeOut(800)
	Citizen.Wait(1000)
	StopScreenEffect('DeathFailOut')
	DoScreenFadeIn(800)
	TriggerServerEvent('sharley_bursztyny:oplukserver', source)
	Wait(500)
	if hcap == true then
		hcap = false
	end
	end
end)
--

--
function DrawText3DTest(x,y,z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	if onScreen then
			SetTextScale(0.2, 0.2)
			SetTextFont(0)
			SetTextProportional(1)
			-- SetTextScale(0.0, 0.55)
			SetTextColour(255, 255, 255, 255)
			SetTextDropshadow(0, 0, 0, 0, 55)
			SetTextEdge(2, 0, 0, 0, 150)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			SetTextCentre(1)
			AddTextComponentString(text)
			DrawText(_x,_y)
	end
end
--
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(-1580.27, -1209.21, 1.44)
	SetBlipSprite (blip, 587)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.6)
	SetBlipColour (blip, 44)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Praca dorywcza - Szukanie bursztynow')
	EndTextCommandSetBlipName(blip)

	local blip2 = AddBlipForCoord(-1526.74, -1183.33, 0.61)
	SetBlipSprite (blip2, 587)
	SetBlipDisplay(blip2, 4)
	SetBlipScale  (blip2, 0.6)
	SetBlipColour (blip2, 44)
	SetBlipAsShortRange(blip2, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Praca dorywcza - Mycie bursztynow')
	EndTextCommandSetBlipName(blip2)

	local blip3 = AddBlipForCoord(-1684.89, -1068.02, 13.152)
	SetBlipSprite (blip3, 587)
	SetBlipDisplay(blip3, 4)
	SetBlipScale  (blip3, 0.6)
	SetBlipColour (blip3, 44)
	SetBlipAsShortRange(blip3, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Praca dorywcza - Sprzedawanie bursztynow')
	EndTextCommandSetBlipName(blip3)

	local blip4 = AddBlipForCoord(-1800.77, -1205.79, 14.3)
	SetBlipSprite (blip4, 587)
	SetBlipDisplay(blip4, 4)
	SetBlipScale  (blip4, 0.6)
	SetBlipColour (blip4, 44)
	SetBlipAsShortRange(blip4, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Praca dorywcza - Szlifowanie bursztynów')
	EndTextCommandSetBlipName(blip4)
end)



--
RegisterNetEvent('sharley_bursztyny:sprzedaj')
AddEventHandler('sharley_bursztyny:sprzedaj', function()
if hcap == false then
		hcap = true
	ClearPedTasks(PlayerPedId())
	TriggerEvent('freezeplayer', true)
	DoScreenFadeOut(800)
	Citizen.Wait(1000)
	StopScreenEffect('DeathFailOut')
	DoScreenFadeIn(800)
	TriggerServerEvent('sharley_bursztyny:sprzedajserver', source)
	TriggerEvent('freezeplayer', false)
	Wait(500)
	if hcap == true then
		hcap = false
	end
end
end)
--
RegisterNetEvent('sharley_bursztyny:oszlifclient')
AddEventHandler('sharley_bursztyny:oszlifclient', function()
if hcap == false then
		hcap = true
	ClearPedTasks(PlayerPedId())
	TriggerEvent('freezeplayer', true)
	DoScreenFadeOut(800)
	Citizen.Wait(1000)
	StopScreenEffect('DeathFailOut')
	DoScreenFadeIn(800)
	TriggerServerEvent('sharley_bursztyny:oszlifserver', source)
	TriggerEvent('freezeplayer', false)
	Wait(500)
	if hcap == true then
		hcap = false
	end
end
end)
--
Citizen.CreateThread(function()
	while true do
		Wait(0)
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
				if GetDistanceBetweenCoords(coords, -1684.89, -1068.02, 13.152, true) < 3 then
					ESX.ShowHelpNotification('Wciśnij ~INPUT_CONTEXT~ aby ~g~sprzedać ~w~oszlifowane bursztyny')
					if IsControlJustReleased(0, Keys['E']) then
						TriggerEvent('sharley_bursztyny:sprzedaj')
					end
				end
				
				if GetDistanceBetweenCoords(coords, -1800.77, -1205.79, 14.3, true) < 3 then
					ESX.ShowHelpNotification('Wciśnij ~INPUT_CONTEXT~ aby ~g~oszlifować~w~ umyte bursztyny')
					if IsControlJustReleased(0, Keys['E']) then
						TriggerEvent('sharley_bursztyny:oszlifclient')
					end
				end

				if (GetDistanceBetweenCoords(coords, -1580.27, -1209.21, 1.44, true) < 3.0) and ustaw == false then
				ESX.ShowHelpNotification('Wciśnij ~INPUT_CONTEXT~ aby ~g~szukać ~w~bursztynów')
					if IsControlJustReleased(0, Keys['E']) then
						TriggerEvent('elowojtek')
					end
				end

				if (GetDistanceBetweenCoords(coords, -1526.74, -1183.33, 0.61, true) < 3.0) and ustaw == false then
					ESX.ShowHelpNotification('Wciśnij ~INPUT_CONTEXT~ aby ~g~opłukać ~w~bursztyny')
						if IsControlJustReleased(0, Keys['E']) then
							TriggerEvent('sharley_bursztyny:opluk')
						end
					end


  end
end)
