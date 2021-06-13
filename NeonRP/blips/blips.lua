
	local blips = {
		-- -- Wi�zienie
	 	-- {title="Wi�zienie", colour=75, id=188, x=1845.73, y=2585.8, z=45.66},
		-- Komisariaty
		{title="Komisariat", colour=3, id=60, x=1855.28, y=3683.2, z=34.26},
		{title="Komisariat", colour=3, id=60, x=428.98, y=-980.86, z=30.71},
		{title="Komisariat", colour=3, id=60, x=638.17, y=0.61, z=81.83},
		{title="Komisariat", colour=3, id=60, x=-1085.61, y=-831.29, z=5.48},
		{title="Marihuana", colour=52, id=140, x=2208.03, y=5601.61, z=60.83},
		-- -- Szpitale
		-- {title="Szpital", colour=0, id=489, x=310.03, y=-592.08, z=43.26},
		--{title="Szpital", colour=0, id=489, x=1837.8, y=3673.01, z=34.27},
		-- -- Urz�d Miasta
		-- --WeazelNews
		-- {title="Digital Den", colour=4, id=184, x=-654.0, y=-851.29, z=1.49},
		-- {title="Psycholog",colour=7, id=457,x =-1893.84, y =-563.18, z =10.7},
		--- Skup aut
		-- {title="Neon Cars", colour=8, id=326, x = -797.93, y = -220.95, z = 37.08},
		-- Stacje Benzynowe
		-- -- Winnica
		{title="Maze Bank",colour=7, id=108,x =-1315.40, y =-847.31, z =15.8},
		-- -- Kosciol
		{title="Kosciol",colour=21, id=305,x =-1685.1044, y =-292.7729, z =50.9418},
		---- Restauracja
		{title="Restauracja",colour=4, id=93,x =-1346.34, y =-1080.41, z =6.94},
		-- Jubiler
		{title="Salon Jubilerski",colour=77, id=617,x =-630.99, y = -237.32, z = 38.07},
		{title="Salon Jubilerski",colour=77, id=617,x =-630.99, y = -237.32, z = 38.07},
		-- Humane Labs
		{title="Humane Labs",colour=61, id=51,x = 3512.89, y = 3752.78, z = 30.11},--x = 118.01, y = -1728.07, z = 30.54
		-- TAXI
		-- {title="Narkotyki",colour=1, id=203,x = -363.12, y = 4333.81, z = 58.70},
		}

Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
	  SetBlipDisplay(info.blip, 4)
	  if info.id == 617 then
		  SetBlipScale(info.blip, 0.9)
	  else
		  SetBlipScale(info.blip, 0.8)
	  end
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)