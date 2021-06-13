local HUD = {
	
	Speed 			= 'kmh', -- kmh or mph

	DamageSystem 	= false, 

	SpeedIndicator 	= true,

	ParkIndicator 	= true,

	Top 			= false, -- ALL TOP PANAL ( oil, dsc, plate, fluid, ac )

	Plate 			= true, -- only if Top is false and you want to keep Plate Number

	ParkAndSpeed	= true, -- Dodatek robiony Przez Pante | Kolorowe i minimalistyczne Menu

}

local UI = { 

	x =  0.000 ,	-- Base Screen Coords 	+ 	 x
	y = -0.001 ,	-- Base Screen Coords 	+ 	-y

}

Citizen.CreateThread(function()
	while true do Citizen.Wait(5)


		local MyPed = PlayerPedId()

		if(IsPedInAnyVehicle(MyPed, false))then

			local MyPedVeh = GetVehiclePedIsIn(GetPlayerPed(-1),false)

				Speed = GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false)) * 3.6

					--drawRct(UI.x + 0.142, UI.y + 0.848, 0.0085, 0.022, 0,0,0,150)

	
						-- drawRct(UI.x + 0.1235, 	UI.y + 0.9443, 0.032,0.024,0,0,0,150)
						drawTxt(UI.x + 0.6215, 	UI.y + 1.437325, 1.0,1.0,0.44 , "~w~" .. math.ceil(Speed)..' ~q~km/h', 255, 255, 255, 255)					--KM NA GODZINE TUTAJ MASZ!!!

	
		end		
	end
end)

function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function drawRct(x,y,width,height,r,g,b,a)
	DrawRect(x + width/2, y + height/2, width, height, r, g, b, a)
end
