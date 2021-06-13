local shot = false
local check = false
local check2 = false
local count = 0

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local ped = GetPlayerPed( -1 )
		local weapon = GetSelectedPedWeapon(ped)
		HideHudComponentThisFrame(14)				
		if weapon == GetHashKey("WEAPON_FLAREGUN") then	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.25)
			end
		end
		
		if weapon == GetHashKey("WEAPON_SNSPISTOL") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.18)
			end
		end

		if weapon == GetHashKey("WEAPON_PISTOL") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)
			end
		end
		
		if weapon == GetHashKey("WEAPON_COMBATPISTOL") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.23)
			end
		end

		if weapon == GetHashKey("WEAPON_SNSPISTOL_MK2") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.21)
			end
		end
		
		if weapon == GetHashKey("WEAPON_APPISTOL") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.80)
			end
		end

		if weapon == GetHashKey("WEAPON_PISTOL_MK2") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.22)
			end
		end

		
		if weapon == GetHashKey("WEAPON_HEAVYPISTOL") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.36)
			end
		end
		
		if weapon == GetHashKey("WEAPON_VINTAGEPISTOL") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.27)
			end
		end
		if IsPlayerFreeAiming(PlayerId()) then
		    if GetFollowPedCamViewMode() == 4 and check == false then
			    check = false
			else
			    SetFollowPedCamViewMode(4)
			    check = true
			end
		else
			if check == true then
		        SetFollowPedCamViewMode(1)
				check = false
			end
		end
		if IsPedShooting(GetPlayerPed(-1)) and shot == false and GetFollowPedCamViewMode() ~= 4 then
			check2 = true
			shot = true			SetFollowPedCamViewMode(4)
		end
		
		if IsPedShooting(GetPlayerPed(-1)) and shot == true and GetFollowPedCamViewMode() == 4 then
			count = 0
		end
		
		if not IsPedShooting(GetPlayerPed(-1)) and shot == true then
		    count = count + 1
		end

        if not IsPedShooting(GetPlayerPed(-1)) and shot == true then
			if not IsPedShooting(GetPlayerPed(-1)) and shot == true and count > 20 then
		        if check2 == true then
				    check2 = false
					shot = false
					SetFollowPedCamViewMode(1)
				end
			end
		end	    
	end
end)

local recoils = {
	[453432689] = 0.0, -- PISTOL
	[3219281620] = 0.1, -- PISTOL MK2
	[1593441988] = 0.5, -- COMBAT PISTOL
	[584646201] = 0.5, -- AP PISTOL
	[2578377531] = 6.6, -- PISTOL .50
	[324215364] = 0.4, -- MICRO SMG
	[736523883] = 0.5, -- SMG
	[2024373456] = 0.5, -- SMG MK2
	[4024951519] = 0.3, -- ASSAULT SMG
	[3220176749] = 0.5, -- ASSAULT RIFLE
	[961495388] = 0.5, -- ASSAULT RIFLE MK2
	[2210333304] = 0.4, -- CARBINE RIFLE
	[4208062921] = 0.5, -- CARBINE RIFLE MK2
	[2937143193] = 0.5, -- ADVANCED RIFLE
	[2634544996] = 0.5, -- MG
	[2144741730] = 0.5, -- COMBAT MG
	[3686625920] = 0.5, -- COMBAT MG MK2
	[487013001] = 2.8, -- PUMP SHOTGUN
	[2017895192] = 2.9, -- SAWNOFF SHOTGUN
	[3800352039] = 2.7, -- ASSAULT SHOTGUN
	[2640438543] = 2.2, -- BULLPUP SHOTGUN
	[911657153] = 0.0, -- STUN GUN
	[100416529] = 6.5, -- SNIPER RIFLE
	[205991906] = 6.7, -- HEAVY SNIPER
	[177293209] = 6.7, -- HEAVY SNIPER MK2
	[856002082] = 1.2, -- REMOTE SNIPER
	[2726580491] = 1.0, -- GRENADE LAUNCHER
	[1305664598] = 1.0, -- GRENADE LAUNCHER SMOKE
	[2982836145] = 0.0, -- RPG
	[1752584910] = 0.0, -- STINGER
	[1119849093] = 0.11, -- MINIGUN
	[3218215474] = 15, -- SNS PISTOL
	[1627465347] = 0.1, -- GUSENBERG
	[3231910285] = 0.2, -- SPECIAL CARBINE
	[3523564046] = 0.5, -- HEAVY PISTOL
	[2132975508] = 0.2, -- BULLPUP RIFLE
	[137902532] = 0.4, -- VINTAGE PISTOL
	[2828843422] = 0.7, -- MUSKET
	[984333226] = 1.2, -- HEAVY SHOTGUN
	[3342088282] = 0.3, -- MARKSMAN RIFLE
	[1672152130] = 0, -- HOMING LAUNCHER
	[1198879012] = 0.9, -- FLARE GUN
	[171789620] = 0.2, -- COMBAT PDW
	[3696079510] = 4.9, -- MARKSMAN PISTOL
  	[1834241177] = 2.4, -- RAILGUN
	[3675956304] = 0.4, -- MACHINE PISTOL
	[3249783761] = 4.6, -- REVOLVER
	[4019527611] = 2.7, -- DOUBLE BARREL SHOTGUN
	[1649403952] = 0.8, -- COMPACT RIFLE
	[317205821] = 0.8, -- AUTO SHOTGUN
	[125959754] = 0.7, -- COMPACT LAUNCHER
	[3173288789] = 0.2, -- MINI SMG		
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2)
		if IsPedShooting(PlayerPedId()) and not IsPedDoingDriveby(PlayerPedId()) then
			local _,wep = GetCurrentPedWeapon(PlayerPedId())
			_,cAmmo = GetAmmoInClip(PlayerPedId(), wep)
			if recoils[wep] and recoils[wep] ~= 0 then
				tv = 0
				if GetFollowPedCamViewMode() ~= 4 then
					repeat 
						Wait(0)
						p = GetGameplayCamRelativePitch()
						SetGameplayCamRelativePitch(p+0.1, 0.2)
						tv = tv+0.1
					until tv >= recoils[wep]
				else
					repeat 
						Wait(0)
						p = GetGameplayCamRelativePitch()
						if recoils[wep] > 0.1 then
							SetGameplayCamRelativePitch(p+0.6, 1.2)
							tv = tv+0.6
						else
							SetGameplayCamRelativePitch(p+0.016, 0.333)
							tv = tv+0.1
						end
					until tv >= recoils[wep]
				end
				
			end
		end
	end
end)

local recoils = {
	[`WEAPON_STUNGUN`] = {0.1, 1.1}, -- STUN GUN
	[`WEAPON_FLAREGUN`] = {0.9, 1.9}, -- FLARE GUN

	[`WEAPON_SNSPISTOL`] = {3.2, 4.2}, -- SNS PISTOL
	[`WEAPON_SNSPISTOL_MK2`] = {2.7, 3.7}, -- SNS PISTOL MK2
	[`WEAPON_VINTAGEPISTOL`] = {3.0, 4.0}, -- VINTAGE PISTOL
	[`WEAPON_PISTOL`] = {4.2, 5.2}, -- PISTOL
	[`WEAPON_PISTOL_MK2`] = {4.2, 5.2}, -- PISTOL MK2
	[`WEAPON_DOUBLEACTION`] = {3.0, 3.5}, -- DOUBLE ACTION REVOLVER
	[`WEAPON_COMBATPISTOL`] = {3.5, 4.0}, -- COMBAT PISTOL
	[`WEAPON_HEAVYPISTOL`] = {2.6, 3.1}, -- HEAVY PISTOL
	[`WEAPON_PISTOL50`] = {2.9, 3.4}, -- 50 PISTOL

	[`WEAPON_DBSHOTGUN`] = {0.1, 0.6}, -- DOUBLE BARREL SHOTGUN
	[`WEAPON_SAWNOFFSHOTGUN`] = {2.1, 2.6}, -- SAWNOFF SHOTGUN
	[`WEAPON_PUMPSHOTGUN`] = {8.7, 10.2}, -- PUMP SHOTGUN
	[`WEAPON_PUMPSHOTGUN_MK2`] = {2.7, 3.2}, -- PUMP SHOTGUN MK2
	[`WEAPON_BULLPUPSHOTGUN`] = {1.5, 2.0}, -- BULLPUP SHOTGUN

	[`WEAPON_MICROSMG`] = {0.55, 0.87}, -- MICRO SMG (UZI)
	[`WEAPON_SMG`] = {0.55, 0.85}, -- SMG
	[`WEAPON_MINISMG`] = {0.05, 0.55}, -- MINISMG
	[`WEAPON_SMG_MK2`] = {0.15, 0.55}, -- SMG MK2
	[`WEAPON_ASSAULTSMG`] = {0.04, 0.54}, -- ASSAULT SMG
	[`WEAPON_COMBATPDW`] = {0.04, 0.54}, -- COMBAT PDW
	[`WEAPON_GUSENBERG`] = {0.075, 0.575}, -- GUSENBERG

	[`WEAPON_COMPACTRIFLE`] = {0.35, 0.45}, -- COMPACT RIFLE
	[`WEAPON_ASSAULTRIFLE`] = {0.35, 0.75}, -- ASSAULT RIFLE
	[`WEAPON_CARBINERIFLE`] = {0.40, 0.74}, -- CARBINE RIFLE

	[`WEAPON_MARKSMANRIFLE`] = {0.5, 1.0}, -- MARKSMAN RIFLE
	[`WEAPON_SNIPERRIFLE`] = {0.5, 1.0}, -- SNIPER RIFLE

	[`WEAPON_1911PISTOL`] = {4.0, 4.5} -- 1911 PISTOL
}

local effects = {
	[`WEAPON_STUNGUN`] = {0.01, 0.02}, -- STUN GUN
	[`WEAPON_FLAREGUN`] = {0.01, 0.02}, -- FLARE GUN

	[`WEAPON_SNSPISTOL`] = {0.08, 0.16}, -- SNS PISTOL
	[`WEAPON_SNSPISTOL_MK2`] = {0.07, 0.14}, -- SNS PISTOL MK2
	[`WEAPON_VINTAGEPISTOL`] = {0.08, 0.16}, -- VINTAGE PISTOL
	[`WEAPON_PISTOL`] = {0.10, 0.20}, -- PISTOL
	[`WEAPON_PISTOL_MK2`] = {0.11, 0.22}, -- PISTOL MK2
	[`WEAPON_DOUBLEACTION`] = {0.1, 0.2}, -- DOUBLE ACTION REVOLVER
	[`WEAPON_COMBATPISTOL`] = {0.1, 0.2}, -- COMBAT PISTOL
	[`WEAPON_HEAVYPISTOL`] = {0.1, 0.2}, -- HEAVY PISTOL
	[`WEAPON_PISTOL50`] = {0.1, 0.2}, -- 50 PISTOL

	[`WEAPON_DBSHOTGUN`] = {0.1, 0.2}, -- DOUBLE BARREL SHOTGUN
	[`WEAPON_SAWNOFFSHOTGUN`] = {0.095, 0.19}, -- SAWNOFF SHOTGUN
	[`WEAPON_PUMPSHOTGUN`] = {0.09, 0.18}, -- PUMP SHOTGUN
	[`WEAPON_PUMPSHOTGUN_MK2`] = {0.09, 0.18}, -- PUMP SHOTGUN MK2
	[`WEAPON_BULLPUPSHOTGUN`] = {0.085, 0.19}, -- BULLPUP SHOTGUN

	[`WEAPON_MICROSMG`] = {0.05, 0.1}, -- MICRO SMG (UZI)
	[`WEAPON_SMG`] = {0.04, 0.1}, -- SMG
	[`WEAPON_MINISMG`] = {0.04, 0.08}, -- MINISMG
	[`WEAPON_SMG_MK2`] = {0.04, 0.08}, -- SMG MK2
	[`WEAPON_ASSAULTSMG`] = {0.035, 0.07}, -- ASSAULT SMG
	[`WEAPON_COMBATPDW`] = {0.03, 0.06}, -- COMBAT PDW
	[`WEAPON_GUSENBERG`] = {0.035, 0.07}, -- GUSENBERG

	[`WEAPON_COMPACTRIFLE`] = {0.03, 0.08}, -- COMPACT RIFLE
	[`WEAPON_ASSAULTRIFLE`] = {0.023, 0.064}, -- ASSAULT RIFLE
	[`WEAPON_CARBINERIFLE`] = {0.03, 0.06}, -- CARBINE RIFLE

	[`WEAPON_MARKSMANRIFLE`] = {0.025, 0.05}, -- MARKSMAN RIFLE
	[`WEAPON_SNIPERRIFLE`] = {0.025, 0.05}, -- SNIPER RIFLE	

	[`WEAPON_1911PISTOL`] = {0.1, 0.2}, -- 1911 PISTOL
	[`WEAPON_FIREWORK`] = {0.5, 1.0} -- FIREWORKS
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		DisplayAmmoThisFrame(false)

		local ped = PlayerPedId()
		if DoesEntityExist(ped) then
			local status, weapon = GetCurrentPedWeapon(ped, true)
			if status == 1 then
				if weapon == `WEAPON_FIREEXTINGUISHER` then
					SetPedInfiniteAmmo(ped, true, `WEAPON_FIREEXTINGUISHER`)
				elseif IsPedShooting(ped) then
					local inVehicle = IsPedInAnyVehicle(ped, false)

					local recoil = recoils[weapon]
					if recoil and #recoil > 0 then
						local i, tv = (inVehicle and 2 or 1), 0
						if GetFollowPedCamViewMode() ~= 4 then
							repeat
								SetGameplayCamRelativePitch(GetGameplayCamRelativePitch() + 0.1, 0.2)
								tv = tv + 0.1
								Citizen.Wait(0)
							until tv >= recoil[i]
						else
							repeat
								local t = GetRandomFloatInRange(0.1, recoil[i])
								SetGameplayCamRelativePitch(GetGameplayCamRelativePitch() + t, (recoil[i] > 0.1 and 1.2 or 0.333))
								tv = tv + t
								Citizen.Wait(0)
							until tv >= recoil[i]
						end
					end

					local effect = effects[weapon]
					if effect and #effect > 0 then
						ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', (inVehicle and (effect[1] * 3) or effect[2]))
					end
				end
			end
		end
	end
end)


---NERF OBRAZEN
CreateThread(function() 
    while true do 
        Citizen.Wait(1) 
            N_0x4757f00bc6323cfe(GetHashKey('WEAPON_PISTOL'), 0.54)
            N_0x4757f00bc6323cfe(GetHashKey('WEAPON_UNARMED'), 0.55) 
            N_0x4757f00bc6323cfe(GetHashKey('WEAPON_COMBATPISTOL'), 0.72) 
            N_0x4757f00bc6323cfe(GetHashKey('WEAPON_PISTOL_MK2'), 0.48) 
            N_0x4757f00bc6323cfe(GetHashKey('WEAPON_SNSPISTOL_MK2'), 0.43)
            N_0x4757f00bc6323cfe(GetHashKey('WEAPON_HEAVYPISTOL'), 0.60) 
            N_0x4757f00bc6323cfe(GetHashKey('WEAPON_VINTAGEPISTOL'), 0.54) 
            N_0x4757f00bc6323cfe(GetHashKey('WEAPON_SNSPISTOL'), 0.45) 
    end 
end)