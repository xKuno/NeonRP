
local zones = {
	{ ['x'] = -207.916015625, ['y'] = -1014.8190917968, ['z'] = 29.767009735108}
}

local notifIn = false
local notifOut = false
local closestZone = 1

Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(5)
	end
	
	while true do
		Citizen.Wait(5)
		local player = GetPlayerPed(-1)
		local x,y,z = table.unpack(GetEntityCoords(player, true))
		local dist = Vdist(zones[closestZone].x, zones[closestZone].y, zones[closestZone].z, x, y, z)
	
		if dist <= 10.0 then  
			if not notifIn then	
				NetworkSetFriendlyFireOption(false)
				ClearPlayerWantedLevel(PlayerId())
				SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
				TriggerEvent("pNotify:SendNotification",{
					text = "<b style='color:#1E90FF'>Wchodzisz do bezpiecznej strefy</b>",
					type = "success",
					timeout = (500),
					layout = "bottomcenter",
					queue = "global"
				})
				notifIn = true
				notifOut = false
			end
		else
			if not notifOut then
				NetworkSetFriendlyFireOption(true)
				TriggerEvent("pNotify:SendNotification",{
					text = "<b style='color:#1E90FF'>Opuszczasz bezpieczna strefe</b>",
					type = "error",
					timeout = (500),
					layout = "bottomcenter",
					queue = "global"
				})
				notifOut = true
				notifIn = false
			end
		end
		if notifIn then
		DisableControlAction(2, 37, true) 
		DisablePlayerFiring(player,true) 
      	DisableControlAction(0, 106, true) 
		DisableControlAction(0, 45, true)
		DisableControlAction(0, 140, true)
		end
	end
end)