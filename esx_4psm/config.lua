Config                            = {}
--Widoczno�� marker�w (wszystikch)
Config.DrawDistance               = 30.0
--Zb�dne 
Config.EnablePlayerManagement     = false
Config.EnableSocietyOwnedVehicles = false
Config.MaxInService               = -1
Config.Locale                     = 'en'
--Markery Firmowe (szatnia,bossmenu)
Config.MarkerType                 = 1 --Rodzaj markeru firmowego
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 } --Wielko�� markeru firmowego
Config.MarkerColor                = { r = 102, g = 0, b = 102 } --Kolor markeru firmowego 

--Blipy
Config.Blipikon                   = 366  --Tutaj ustawiamy ikonke blip�w
Config.Blipwielkosc               = 0.8  --Tutaj ustawiamy wielko�� blip�w
Config.Blipkolor                  = 7 --Tutaj ustawiamy kolor blip�w

---Zarobki
Config.Wyplata1                   = 20000 --Tutaj ustawiamy minimaln� wyp�ate dla pracownika
Config.Wyplata2                   = 24000 --Tutaj ustawiamy maksymaln� wyp�at� dla pracownika
--Config.WypFirma1                  = 3999 --Tutaj ustawiamy minimanln� wyp�ate dla firmy
--Config.WypFirma2                  = 5000 --Tutaj ustawiamy maksymaln� wyp�ate dla firmy 

--Czasy Czynno�ci
Config.Czasprzebierania           = 2 --Tutaj ustawiamy czas animacji przebierania
Config.Czasmaterial               = 6000 --Tutaj ustawiamy czas zbierania materia�u
Config.Czasszycie                 = 6000 --Tutaj ustawiamy czas szycia 
Config.Czaspako                   = 6000 --Tutaj ustawiamy czas pakowania
Config.Czasoddam                  = 6000 --Tutaj ustawiamy czas sprzeda�y

Config.Zones = {

	Material = {
		Pos   = {x = 969.09, y = -2249.09, z = 30.0}, --Kordy zbierania materia�u 1214.63 -3290.06 4.5
		Size  = {x = 5.0, y = 5.0, z = 1.0}, --Wielko�� markeru zbierania materia�u 
		Color = {r = 204, g = 204, b = 0}, --Kolor markeru zbierania materia�u
		Name  = "Krawiec - #1 Zbior materialow", --Nazwa blipa
		Type  = 1
	},


	Szycie = {
		Pos   = {x = 713.08, y = -969.53, z = 29.8}, --Kordy szycia  713.08 -869.53 29.8
                Size  = {x = 6.0, y = 6.0, z = 1.0}, --Wielko�� markeru szycia
                Color = {r = 204, g = 204, b = 0}, --Kolor markeru szycia
		Name  = "Krawiec - #2 Szycie ubran", --Nazwa blipa
		Type  = 1
	},

	Pakowanie = {
		Pos   = {x = 706.62, y = -960.61, z = 29.8}, --Kordy pakowania  706.62 -960.61 29.8
		Size  = {x = 6.0, y = 6.0, z = 1.0}, --Wielko�c markeru pakowania
		Color = {r = 204, g = 204, b = 0}, -- Kolor markeru pakowania
		Name  = "Krawiec - #3 Pakowanie ubran do paczek", --Nazwa blipa
		Type  = 1
	},
	
	SellFarm = {
		Pos   = {x = 870.67, y = -2363.13, z = 29.5}, --Kordy oddawania  1199.53 -3307.71 4.5
		Size  = {x = 7.0, y = 7.0, z = 1.0}, --Wielko�� markeru oddawania
		Color = {r = 204, g = 204, b = 0}, --Kolor markeru oddawania
		Name  = "Krawiec - #4 Sprzedaz paczek z ubraniami", --Nazwa Blipa
		Type  = 1
	},

}

Config.PSM = {
	PSM = {
		Vehicles = {
			{
				Spawner    = { x = 977.29, y = -2220.67, z = 30.50 }, --1215.39 -3247.94 4.5
				SpawnPoint = { x = 971.04, y = -2220.98, z = 29.64 }, --1218.56 -3224.45 5.82 84.31
				Heading    = 177.31
			}
		},

		PsmActions = {
			{x = -960.64, y = -2742.88, z = 20.21},
		 },
	
		Cloakrooms = {
			{x = 977.54, y = -2226.96, z = 30.57}, --1213.67 -3303 4.5
		},

		VehicleDeleters = {
			{x = 964.58, y = -2221.12, z = 29.6}, --1233.6 -3240.63 4.5
		},
	}
}

Config.AuthorizedVehicles = {
	{
		grade = 0,
		model = 'XLS',     
		label = 'Auto służbowe - SUV' ,
	},
	{
		grade = 0,
		model = 'Asea',     
		label = 'Auto służbowe - Sedan',
	},
}

