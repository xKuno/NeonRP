Citizen.CreateThread(function()
while true do
Citizen.Wait(1000)
		local playerPed = GetPlayerPed(-1)
		if  IsPedInAnyVehicle(playerPed) or exports['gcphone']:getMenuIsOpen(true) then
		DisplayRadar(true)
	else
	Wait(250)
	DisplayRadar(false) 
end 	
end
end)
