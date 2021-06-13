-- CONFIG --

-- Allow passengers to shoot
local passengerDriveBy = true

-- CODE --

Citizen.CreateThread(function()
	while true do
		Wait(70)
		SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
		playerPed = GetPlayerPed(-1)
		car = GetVehiclePedIsIn(playerPed, false)
		if car then
			if GetPedInVehicleSeat(car, -1) == playerPed then
				SetPlayerCanDoDriveBy(PlayerId(), false)
			elseif passengerDriveBy then
				SetPlayerCanDoDriveBy(PlayerId(), false)
			else
				SetPlayerCanDoDriveBy(PlayerId(), false)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(1)
	  -- List of pickup hashes (https://pastebin.com/8EuSv2r1)
	  RemoveAllPickupsOfType(0xDF711959) -- carbine rifle
	  RemoveAllPickupsOfType(0xF9AFB48F) -- pistol
	  RemoveAllPickupsOfType(0xA9355DCD) -- pumpshotgun
	end
end)