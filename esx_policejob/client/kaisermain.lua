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

ESX                           = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	
	Citizen.Wait(5000)
	TriggerServerEvent('esx_policejob:forceBlip')
end)

function LicensePolice(society)
	ESX.TriggerServerCallback('esx_society:getEmployeeslic', function(employees)
		local elements = nil
		local identifier = ''

			elements = {
				head = {"Pracownik", "SWAT", "OCEAN", "AIR", "SEU2", "SEU", "Akcje"},
				rows = {}
			}

		

			for i=1, #employees, 1 do
				local licki = {}
				if employees[i].licensess.swat == true then
					licki[1] = '✔️'
				else
					licki[1] = "❌"
				end
				if employees[i].licensess.ocean == true then
					licki[2] = '✔️'
				else
					licki[2] = "❌"
				end
				if employees[i].licensess.air == true then
					licki[3] = '✔️'
				else
					licki[3] = "❌"
				end
				if employees[i].licensess.seuoffroad == true then
					licki[4] = '✔️'
				else
					licki[4] = "❌"
				end
				if employees[i].licensess.seu == true then
					licki[5] = '✔️'
				else
					licki[5] = "❌"
				end				
					
				table.insert(elements.rows, {
					data = employees[i],
					cols = {
						employees[i].name,
						licki[1],
						licki[2],
						licki[3],
						licki[4],
						licki[5],
						'{{' .. "Nadaj Licencję" .. '|give}} {{' .. "Odbierz Licencję" .. '|take}}'
					}
				})
			end


		ESX.UI.Menu.Open('list', GetCurrentResourceName(), 'employee_list_' .. society, elements, function(data, menu)
			local employee = data.data

			if data.value == 'give' then
				menu.close()
					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'licka', {
						title = 'Licencje Jednostek'
					}, function(data2, menu2)
						local amount = data2.value
						local wartosc = ''
						if amount == nil then
							ESX.ShowNotification('Podaj nazwę licencji')
							return
						elseif amount == 'swat' then
							wartosc = 'police_swat'
						elseif amount == 'ocean' then
							wartosc = 'police_ocean' 
						elseif amount == 'air' then
							wartosc = 'police_air'
						elseif amount == 'seu2' then
							wartosc = 'police_seuoffroad'
						elseif amount == 'seu' then
							wartosc = 'police_seu'
						else
							ESX.ShowNotification('Spis prawdidłowych lecencji: swat, ocean, air, seu2, seu')
							return
						end
						
	
							TriggerServerEvent('esx_policejob:addlicense', employee.identifier, wartosc)
							ESX.ShowNotification('Licencja: '..amount)

						
						menu2.close()
						
					end, function(data2, menu2)
						menu2.close()
					end)
			elseif data.value == 'take' then
									menu.close()
					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'licka', {
						title = 'Licencje Jednostek'
					}, function(data3, menu3)
						local amount = data3.value
						local wartosc = ''
						
						if amount == nil then
							ESX.ShowNotification('Podaj nazwę licencji')
							return
						elseif amount == 'swat' then
							wartosc = 'police_swat'
						elseif amount == 'ocean' then
							wartosc = 'police_ocean' 
						elseif amount == 'air' then
							wartosc = 'police_air'
						elseif amount == 'seu2' then
							wartosc = 'police_seuoffroad'
						elseif amount == 'seu' then
							wartosc = 'police_seu'
						else
							ESX.ShowNotification('Nie podałeś prawidłowej nazwy licencji<br>Spis prawdidłowych lecencji:<br>1. swat<br>2. ocean<br>3. air<br>4. seuoffroad<br>5. seu')
							return
						end
						
							TriggerServerEvent('esx_policejob:removelicense', employee.identifier, wartosc)
							ESX.ShowNotification('Licencja: '..amount)
						
						menu3.close()

				
					end, function(data3, menu3)
						menu3.close()
					end)
			end
		end, function(data, menu)
			menu.close()
		end)

	end, 'police', society)

end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local Gracz = GetPlayerPed(-1)
		local PozycjaGracza = GetEntityCoords(Gracz)
		local Dystans = GetDistanceBetweenCoords(PozycjaGracza, -1096.23, -850.23, 4.88, true)
		local Dystans2 = GetDistanceBetweenCoords(PozycjaGracza, -1096.23, -850.23, 10.28, true)
		local Dystans3 = GetDistanceBetweenCoords(PozycjaGracza, -1096.23, -850.23, 13.69, true)
		local Dystans4 = GetDistanceBetweenCoords(PozycjaGracza, -1096.23, -850.23, 19.0, true)
		local Dystans5 = GetDistanceBetweenCoords(PozycjaGracza, -1096.23, -850.23, 23.04, true)
		local Dystans6 = GetDistanceBetweenCoords(PozycjaGracza, -1096.23, -850.23, 26.83, true)
		local Dystans7 = GetDistanceBetweenCoords(PozycjaGracza, -1096.23, -850.23, 30.76, true)
		local Dystans8 = GetDistanceBetweenCoords(PozycjaGracza, -1096.23, -850.23, 34.36, true)
		local Dystans9 = GetDistanceBetweenCoords(PozycjaGracza, -1096.23, -850.23, 38.24, true)
		if Dystans <= 10.0 then
			local PozycjaTekstu = {
				["x"] = -1096.23,
				["y"] = -850.23,
				["z"] = 4.88
			}
			ESX.Game.Utils.DrawText3D(PozycjaTekstu, "Użyj [~g~E~s~] aby użyć windy", 0.55, 1.5, "~b~WINDA", 0.7)
			if IsControlJustReleased(0, 38) and Dystans <= 1.5 then
				Tepaj()
			end
		end
		if Dystans2 <= 6.0 then
			local PozycjaTekstu2 = {
				["x"] = -1096.23,
				["y"] = -850.23,
				["z"] = 10.28
			}
			ESX.Game.Utils.DrawText3D(PozycjaTekstu2, "Użyj [~g~E~s~] aby użyć windy", 0.55, 1.5, "~b~WINDA", 0.7)
			if IsControlJustReleased(0, 38) and Dystans2 <= 1.5 then
				Tepaj()
			end
		end
		if Dystans3 <= 6.0 then
			local PozycjaTekstu3 = {
				["x"] = -1096.23,
				["y"] = -850.23,
				["z"] = 13.69
			}
			ESX.Game.Utils.DrawText3D(PozycjaTekstu3, "Użyj [~g~E~s~] aby użyć windy", 0.55, 1.5, "~b~WINDA", 0.7)
			if IsControlJustReleased(0, 38) and Dystans3 <= 1.5 then
				Tepaj()
			end
		end
		if Dystans4 <= 6.0 then
			local PozycjaTekstu4 = {
				["x"] = -1096.23,
				["y"] = -850.23,
				["z"] = 19.0
			}
			ESX.Game.Utils.DrawText3D(PozycjaTekstu4, "Użyj [~g~E~s~] aby użyć windy", 0.55, 1.5, "~b~WINDA", 0.7)
			if IsControlJustReleased(0, 38) and Dystans4 <= 1.5 then
				Tepaj()
			end
		end
		if Dystans5 <= 6.0 then
			local PozycjaTekstu5 = {
				["x"] = -1096.23,
				["y"] = -850.23,
				["z"] = 23.04
			}
			ESX.Game.Utils.DrawText3D(PozycjaTekstu5, "Użyj [~g~E~s~] aby użyć windy", 0.55, 1.5, "~b~WINDA", 0.7)
			if IsControlJustReleased(0, 38) and Dystans5 <= 1.5 then
				Tepaj()
			end
		end
		if Dystans6 <= 6.0 then
			local PozycjaTekstu6 = {
				["x"] = -1096.23,
				["y"] = -850.23,
				["z"] = 26.83
			}
			ESX.Game.Utils.DrawText3D(PozycjaTekstu6, "Użyj [~g~E~s~] aby użyć windy", 0.55, 1.5, "~b~WINDA", 0.7)
			if IsControlJustReleased(0, 38) and Dystans6 <= 1.5 then
				Tepaj()
			end
		end
		if Dystans7 <= 6.0 then
			local PozycjaTekstu7 = {
				["x"] = -1096.23,
				["y"] = -850.23,
				["z"] = 30.73
			}
			ESX.Game.Utils.DrawText3D(PozycjaTekstu7, "Użyj [~g~E~s~] aby użyć windy", 0.55, 1.5, "~b~WINDA", 0.7)
			if IsControlJustReleased(0, 38) and Dystans7 <= 1.5 then
				Tepaj()
			end
		end
		if Dystans8 <= 6.0 then
			local PozycjaTekstu8 = {
				["x"] = -1096.23,
				["y"] = -850.23,
				["z"] = 34.36
			}
			ESX.Game.Utils.DrawText3D(PozycjaTekstu8, "Użyj [~g~E~s~] aby użyć windy", 0.55, 1.5, "~b~WINDA", 0.7)
			if IsControlJustReleased(0, 38) and Dystans8 <= 1.5 then
				Tepaj()
			end
		end
		if Dystans9 <= 6.0 then
			local PozycjaTekstu9 = {
				["x"] = -1096.23,
				["y"] = -850.23,
				["z"] = 38.24
			}
			ESX.Game.Utils.DrawText3D(PozycjaTekstu9, "Użyj [~g~E~s~] aby użyć windy", 0.55, 1.5, "~b~WINDA", 0.7)
			if IsControlJustReleased(0, 38) and Dystans9 <= 1.5 then
				Tepaj()
			end
		end
	end
end)


function Tepaj()

	local elements = {
			{label = "Dach", value = '1'},
			{label = "Biuro szefa (V piętro)", value = '2'},
			{label = "Biuro operacyjne (IV piętro)", value = '3'},
			{label = "Siłownia (III piętro)", value = '4'},
			{label = "Kawiarnia (II piętro)", value = '5'},
			{label = "Lobby (I piętro)", value = '6'},
		}


		if PlayerData.job ~= nil and (PlayerData.job.name == 'police' or PlayerData.job.name == 'offpolice') then
		table.insert(elements, {label = "Szatnia (-III Piętro)", value = '7'})
		table.insert(elements, {label = "Laboratorium (-II Piętro)", value = '8'})
		table.insert(elements, {label = "Garaż dolny (-I Piętro)", value = '9'})
	  end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Winda',
	{
		title		= "Winda",
		align		= 'bottom-right',
		elements = elements
	}, function(data, menu)
		if data.current.value == '1' then
		Teleporcik(PlayerPedId(), {x = -1096.23, y = -850.23, z = 38.24})
		menu.close()
		elseif data.current.value == '2' then
		Teleporcik(PlayerPedId(), {x = -1096.23, y = -850.23, z = 34.36})
		menu.close()
		elseif data.current.value == '3' then
		Teleporcik(PlayerPedId(), {x = -1096.23, y = -850.23, z = 30.76})
		menu.close()
		elseif data.current.value == '4' then
		Teleporcik(PlayerPedId(), {x = -1096.23, y = -850.23, z = 26.83})
		menu.close()
		elseif data.current.value == '5' then
		Teleporcik(PlayerPedId(), {x = -1096.23, y = -850.23, z = 23.04})
		menu.close()
		elseif data.current.value == '6' then
		Teleporcik(PlayerPedId(), {x = -1096.23, y = -850.23, z = 19.0})
		menu.close()
		elseif data.current.value == '7' then
		Teleporcik(PlayerPedId(), {x = -1096.23, y = -850.23, z = 13.69})
		menu.close()
		elseif data.current.value == '8' then
		Teleporcik(PlayerPedId(), {x = -1096.23, y = -850.23, z = 10.28})
		menu.close()
		elseif data.current.value == '9' then
		Teleporcik(PlayerPedId(), {x = -1096.23, y = -850.23, z = 4.88})
		menu.close()
		end

	end, function(data, menu)
		menu.close()
	end)

end

function Teleporcik(entity, coords)
	Citizen.CreateThread(function()
		DoScreenFadeOut(500)

		while not IsScreenFadedOut() do
			Citizen.Wait(0)
		end

		ESX.Game.Teleport(entity, coords, function()
			DoScreenFadeIn(500)
		end)
	end)
end


-- Function for 3D text:
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

function KeyboardInput(textEntry, inputText, maxLength)
    AddTextEntry('FMMC_KEY_TIP1', textEntry)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", inputText, "", "", "", maxLength)

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        return result
    else
        Citizen.Wait(500)
        return nil
    end
end

OutLaw = {
	GunshotAlert = true,
	ThieftAlert = true,

	GunshotOnlyCities = false,
	MeleeOnlyCities = false,

	AlertFade = 180,
	GunpowderTimer = 5,
    
	AllowedWeapons = {
		["WEAPON_STUNGUN"] = true,
		["WEAPON_SNOWBALL"] = true,
		["WEAPON_BALL"] = true,
		["WEAPON_FLARE"] = true,
		["WEAPON_STICKYBOMB"] = true,
		["WEAPON_FIREEXTINGUISHER"] = true,
		["WEAPON_PETROLCAN"] = true,
		["GADGET_PARACHUTE"] = true,
		["WEAPON_SNSPISTOL_MK2"] = "COMPONENT_AT_PI_SUPP_02",
		["WEAPON_VINTAGEPISTOL"] = "COMPONENT_AT_PI_SUPP",
		["WEAPON_PISTOL"] = "COMPONENT_AT_PI_SUPP_02",
		["WEAPON_PISTOL_MK2"] = "COMPONENT_AT_PI_SUPP_02",
		["WEAPON_COMBATPISTOL"] = "COMPONENT_AT_PI_SUPP",
		["WEAPON_HEAVYPISTOL"] = "COMPONENT_AT_PI_SUPP",
		["WEAPON_PUMPSHOTGUN"] = "COMPONENT_AT_SR_SUPP",
		["WEAPON_PUMPSHOTGUN_MK2"] = "COMPONENT_AT_SR_SUPP_03",
		["WEAPON_BULLPUPSHOTGUN"] = "COMPONENT_AT_AR_SUPP_02",
		["WEAPON_MICROSMG"] = "COMPONENT_AT_AR_SUPP_02",
		["WEAPON_SMG"] = "COMPONENT_AT_PI_SUPP",
		["WEAPON_SMG_MK2"] = "COMPONENT_AT_PI_SUPP",
		["WEAPON_COMBATPDW"] = true,
		["WEAPON_ASSAULTSMG"] = "COMPONENT_AT_AR_SUPP_02",
		["WEAPON_ASSAULTRIFLE"] = "COMPONENT_AT_AR_SUPP_02",
		["WEAPON_CARBINERIFLE"] = "COMPONENT_AT_AR_SUPP",
		["WEAPON_MARKSMANRIFLE"] = "COMPONENT_AT_AR_SUPP",
		["WEAPON_SNIPERRIFLE"] = "COMPONENT_AT_AR_SUPP_02",
		["WEAPON_1911PISTOL"] = "COMPONENT_AT_PI_SUPP"
	}
}

-- STRZAŁY 
RegisterNetEvent('esx_jb_outlawalert:notifyShots')
AddEventHandler('esx_jb_outlawalert:notifyShots', function(coords, text, isPolice)
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
    	local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
		SetBlipSprite(blip, 432)
		SetBlipColour(blip, (isPolice and 3 or 76))
		SetBlipAlpha(blip, 250)
    	SetBlipAsShortRange(blip, 0)
    
    	BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('# Strzały ' .. (isPolice and "policyjne" or "cywilne"))
    	EndTextCommandSetBlipName(blip)
    
    	TriggerEvent("chatMessage", '^0[^3Centrala^0]', { 0, 0, 0 }, text)
    	Citizen.CreateThread(function()
        	local alpha = 250 
        	while true do 
            	Citizen.Wait(OutLaw.AlertFade * 4)
            	SetBlipAlpha(blip, alpha)

            	alpha = alpha - 1
            	if alpha == 0 then 
                	RemoveBlip(blip)
                	break
            	end
       		end
		end)
	end
end)

--[[ KRADZIEZ POJAZDU 
RegisterNetEvent('esx_jb_outlawalert:notifyThief')
AddEventHandler('esx_jb_outlawalert:notifyThief', function(coords, text)
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
		local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
		SetBlipSprite(blip, 229)
		SetBlipColour(blip, 5)
		SetBlipAlpha(blip, 250)
		SetBlipAsShortRange(blip, 1)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('# Uprowadzenie pojazdu')
		EndTextCommandSetBlipName(blip)

		TriggerEvent("chatMessage", '^0[^3Centrala^0]', { 0, 0, 0 }, text)
		Citizen.CreateThread(function()
			local alpha = 250
			while true do
				Citizen.Wait(Config.AlertFade * 4)
				SetBlipAlpha(blip, alpha)

				alpha = alpha - 1
				if alpha == 0 then
					RemoveBlip(blip)
					break
				end
			end
		end)
	end
end)]]

local shotTimer = 0
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		if shotTimer > 0 and not IsPedDeadOrDying(PlayerPedId()) then
			shotTimer = shotTimer - 100
			if shotTimer <= 0 then
				DecorSetBool(PlayerPedId(), "Gunpowder", false)
				shotTimer = 0
			end
		end
	end
end)


-- STRZAŁY 
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local ped = PlayerPedId()
		if DoesEntityExist(ped) then
			if not DecorIsRegisteredAsType("Gunpowder", 2) then
				DecorRegister("Gunpowder", 2)
				DecorSetBool(ped, "Gunpowder", false)
			end

			if IsPedShooting(ped) then
				if shotTimer == 0 then
					DecorSetBool(ped, "Gunpowder", true)
				end

				local weapon, supress = GetSelectedPedWeapon(ped), nil
				for w, c in pairs(OutLaw.AllowedWeapons) do
					if weapon == GetHashKey(w) then
						if c == true or HasPedGotWeaponComponent(ped, GetHashKey(w), GetHashKey(c)) then
							supress = (c == true)
							break
						end
					end
				end

				if supress ~= true then
					shotTimer = OutLaw.GunpowderTimer * 60000
					if OutLaw.GunshotAlert then
						local coords = GetEntityCoords(ped)
						if CheckArea(coords, OutLaw.GunshotOnlyCities, (supress == false and 10 or 120)) then
							local isPolice = PlayerData.job and PlayerData.job.name == 'police'
							local str = "^" .. (isPolice and "4" or "8") .. "Uwaga, strzały" .. (isPolice and " policyjne" or "")

							local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, coords.x, coords.y, coords.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
							if s1 ~= 0 and s2 ~= 0 then
								str = str .. " przy ^0" .. GetStreetNameFromHashKey(s1) .. "^" .. (isPolice and "4" or "8") .. " na skrzyżowaniu z ^0" .. GetStreetNameFromHashKey(s2)
							elseif s1 ~= 0 then
								str = str .. " przy ^0" .. GetStreetNameFromHashKey(s1)
							end

							TriggerServerEvent('esx_jb_outlawalert:notifyShots', {x = coords.x, y = coords.y, z = coords.y}, str, isPolice)
							Citizen.Wait(5000)
						end
					end
				end
			end
		end
	end
end)

-- KRADZIEŻ POJAZDU 
Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		if IsPedTryingToEnterALockedVehicle(GetPlayerPed(-1)) or IsPedJacking(GetPlayerPed(-1)) then
			Wait(5000)
			local str = "^3Urpowadzenie pojazdu" 
			if DoesEntityExist(vehicle) then
				vehicle = GetEntityModel(vehicle)

				local coords = GetEntityCoords(ped, true)
				TriggerEvent('esx_vehicleshop:getVehicles', function(base)
					local name = GetDisplayNameFromVehicleModel(vehicle)
					if name ~= 'CARNOTFOUND' then				
						local found = false
						for _, veh in ipairs(base) do
							if (veh.game:len() > 0 and veh.game == name) or veh.model == name then
								name = veh.name
								found = true
								break
							end
						end

						if not found then
							local label = GetLabelText(name)
							if label ~= "NULL" then
								name = label
							end
						end

						str = str .. ' ^0' .. name .. '^3'
					end

					local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, coords.x, coords.y, coords.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
					if s1 ~= 0 and s2 ~= 0 then
						str = str .. " przy ^0" .. GetStreetNameFromHashKey(s1) .. "^3 na skrzyżowaniu z ^0" .. GetStreetNameFromHashKey(s2)
					elseif s1 ~= 0 then
						str = str .. " przy ^0" .. GetStreetNameFromHashKey(s1)
					end

					TriggerServerEvent('esx_jb_outlawalert:notifyThief', {x = coords.x, y = coords.y, z = coords.y}, str)
				end)
			else
				local coords = GetEntityCoords(ped, true)

				local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, coords.x, coords.y, coords.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
				if s1 ~= 0 and s2 ~= 0 then
					str = str .. " przy ^0" .. GetStreetNameFromHashKey(s1) .. "^3 na skrzyżowaniu z ^0" .. GetStreetNameFromHashKey(s2)
				elseif s1 ~= 0 then
					str = str .. " przy ^0" .. GetStreetNameFromHashKey(s1)
				end

				TriggerServerEvent('esx_jb_outlawalert:notifyThief', {x = coords.x, y = coords.y, z = coords.y}, str)
			end
		end
	end
end)


local list = {}
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)

		list = {}
		for _, pid in ipairs(GetActivePlayers()) do
			table.insert(list, GetPlayerPed(pid))
		end
	end
end)

function CheckArea(coords, should, dist)
	if not should then
		return true
	end

	local found = false
	for _, ped in ipairs(ESX.Game.GetPeds(list)) do
		local pedType = GetPedType(ped)
		if pedType ~= 28 and pedType ~= 27 and pedType ~= 6 then
			local pedCoords = GetEntityCoords(ped)
			if #(coords - pedCoords) < dist then
				return true
			end
		end
	end

	return false
end

