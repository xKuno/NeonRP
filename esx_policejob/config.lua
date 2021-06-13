Config                            = {}

Config.DrawDistance               = 10.0
Config.MarkerType                 = 27
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- only turn this on if you are using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = true -- only turn this on if you are using esx_license

Config.EnableHandcuffTimer        = true -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.MaxInService               = -1
Config.Locale = 'pl'

Config.PoliceStations = {

   LSPD = {

		
		Blip = {
			Pos     = { x = -1076.24, y = -818.09, z = 20.09 }, 
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 38,
		},
		Blip = {
			Pos     = { x = 425.130, y = -979.558, z = 30.711 },
			Sprite  = 60,
			Display = 4,
			Scale   = 1.0,
			Colour  = 38,
		},

		-- https://wiki.fivem.net/wiki/Weapons
		AuthorizedWeapons = {
			{ name = 'WEAPON_NIGHTSTICK',       price = 50 },
			{ name = 'WEAPON_COMBATPISTOL',     price = 600 },
			{ name = 'WEAPON_STUNGUN',          price = 50 },
			{ name = 'WEAPON_FLASHLIGHT',       price = 50 },
			
			
		},

		Cloakrooms = {
			{ x = -1098.23, y = -831.21, z = 13.30 },
			{ x = 381.43, y = -1609.3, z = 28.5 },
			{ x = 617.63, y = 13.15, z = 81.83 },
			{ x = 615.63, y = 7.15, z = 81.83 },
			{ x = 1858.28, y = 3695.11, z = 33.30 },
			{ x = -453.78, y = 6013.33, z = 30.80 },
			{ x = 450.05, y = -992.98, z = 29.75 },


		},

		Armories = {
			{ x = -1106.40, y = -825.95, z = 13.50 },
			{ x = 370.0, y = -1597.95, z = 28.5 },
			{ x = 621.53, y = -18.80, z = 81.8 },
			{ x = 1862.58, y = 3689.43, z = 33.40 },
			{ x = -436.96, y = 5996.72, z = 30.85 },
			{ x = 451.86, y = -980.15, z = 30.00 },
			{ x = 1718.72, y = 2593.66, z = 44.75 },
		},

		Vehicles = {
			{
				Spawner    = { x = -1113.29, y = -842.97, z = 12.35 }, 
				SpawnPoint = { x = -1127.82, y = -840.46, z = 13.56 },
				Heading    = 128.88,
			},

			{
				Spawner    = { x = 377.54, y = -1630.95, z = 27.25 }, 
				SpawnPoint = { x = 390.11, y = -1621.3, z = 28.5 },
				Heading    = 144.28,
			},

			{
				Spawner    = { x = 1827.55, y = 3691.05, z = 33.40 },
				SpawnPoint = { x = 1829.48, y = 3695.27, z = 33.40},
				Heading    = 294.08,
			},
			{
				Spawner    = { x = -452.04, y = 6005.78, z = 31.30 },
				SpawnPoint = { x = -465.63, y = 6017.57, z = 30.75},
				Heading    = 311.60,
			},
			{
				Spawner    = { x = -1086.05, y = -849.27, z = 4.15 }, 
				SpawnPoint = { x = -1068.60, y = -857.38, z = 4.87},
				Heading    = 213.34,
			},
			{
				Spawner    = { x = 436.65, y = -996.81, z = 24.90 }, 
				SpawnPoint = { x = 433.53, y = -1014.57, z = 28.78},
				Heading    = 122.82,
			},
			{
				Spawner    = { x = 1691.49, y = 2613.57, z = 44.90 }, 
				SpawnPoint = { x = 1690.26, y = 2604.89, z = 45.56},
				Heading    = 266.79,
			},

			{
				Spawner    = { x = -1794.82, y= -992.56, z = 1.21 }, 
				SpawnPoint = { x=-1832.04, y=-1010.65, z=0.58},
				Heading    = 100.27,
			},
			{
				Spawner    = { x = 617.71, y= 22.56, z = 87.81 }, 
				SpawnPoint = { x=619.41, y=27.19, z=87.64},
				Heading    = 71.96,
			},
			{
				Spawner    = { x = 1866.71, y= 3688.56, z = 33.31 }, 
				SpawnPoint = { x=1870.47, y=3693.34, z=32.65},
				Heading    = 206.9,
			},
			{
				Spawner    = { x = -445.33, y= 6024.19, z = 30.54 }, 
				SpawnPoint = { x=-447.07, y=6033.65, z=30.39},
				Heading    = 298.86,
			},


		},

		Helicopters = {
			{
				Spawner    = { x = 466.477, y = -982.819, z = 42.691 },
				SpawnPoint = { x = 450.04, y = -981.14, z = 42.691 },
				Heading    = 0.0,
			},

			{
				Spawner    = { x = 378.31, y = -1597.16, z = 36.95 },
				SpawnPoint = { x = 450.04, y = -981.14, z = 42.691 },
				Heading    = 313.22,
			},

			{
				Spawner    = { x = -470.43, y = 5993.70, z = 31.33 },
				SpawnPoint = { x = -475.34, y = 5988.58, z = 31.34 },
				Heading    = 0.0,
			}


		},

		Boats = {
			{
				Spawner    = { x = 466.477, y = -982.819, z = 42.691 },
				SpawnPoint = { x = 450.04, y = -981.14, z = 42.691 },
				Heading    = 0.0,
			},
			{
				Spawner    = { x = -470.43, y = 5993.70, z = 31.33 },
				SpawnPoint = { x = -475.34, y = 5988.58, z = 31.34 },
				Heading    = 0.0,
			}


		},

		VehicleDeleters = {
			{ x = -1113.64, y = -830.05, z = 12.35 },
			{ x = 384.52, y = -1634.03, z = 27.5 },
			{ x = 462.74, y = -1019.18, z = 27.35}, 
			{ x = 1817.20, y = 3687.08, z = 33.40 },
			{ x = -466.32, y = 5997.11, z = 30.45 },
			{ x = 475.41, y = -1019.52, z = 27.15 },
			{ x = -1073.12, y = -845.81, z = 4.15 }, 
			{ x = 431.19, y = -996.88, z = 24.95 }, 
			{ x = 1669.63, y = 2599.37, z = 44.75 }, 
			{ x= -1787.40, y= -976.42, z= 1.07 },
			{ x= -435.17, y= 6031.73, z= 30.37 },
			{ x= 1864.02, y= 3682.33, z= 32.77 },
			{ x= 629.73, y= 23.18, z= 86.56 }
		},

		BossActions = {
			{ x = 447.97, y = -973.55, z = 29.93 },
			{ x = 629.13, y = -8.96, z = 81.80 },
			{ x = 1841.73, y = 3690.96, z = 33.40 },
			{ x = -448.98, y = 6012.64, z = 30.80 },
			{ x = -1113.36, y = -833.06, z = 33.40 }
		},

	},

}

-- https://wiki.fivem.net/wiki/Vehicles
Config.AuthorizedVehicles = {
	Shared = {
		

	},

	Cadet = {
		{
			model = 'esa',
			label = '---- CADET ----'
		},
		{
			model = 'cvpileg',
			label = 'Ford Victoria'
		},

	},

	DeputyTropper = {
		{
			model = 'esa',
			label = '---- DEPUTY TROPPER ----'
		},
		{
			model = 'cvpileg',
			label = 'Ford Victoria'
		},
		{
		   model = 'valorcap',
		   label = 'Ford Taurus'
	   },

   },



   Tropper1step2 = {
	{
		model = 'esa',
		label = '---- TROPPER 1 Step 2 ----'
	},
	{
		model = 'cvpileg',
		label = 'Ford Victoria'
	},
	{
	   model = 'valorcap',
	   label = 'Ford Taurus'
   },
	{
		model = 'policet',
		label = 'Transporter'
	},
	{
		model = 'jtdsprinter2',
		label = 'Mercedes Sprinter'
	},
	{
		model = 'victorialspd',
		label = 'Ford Victoria'
	},
	  {
		model = 'DodgeRam2016',
		label = 'Dodge Ram 2016'
	},
	{
		model = 'FordFusion2016',
		label = 'Ford Fusion 2016'
	},

},

Tropper1step3 = {

	{
		model = 'esa',
		label = '---- TROPPER 1 Step 3 ----'
	},
	{
		model = 'cvpileg',
		label = 'Ford Victoria'
	},
	{
	   model = 'valorcap',
	   label = 'Ford Taurus'
   },
	{
		model = 'policet',
		label = 'Transporter'
	},
	{
		model = 'jtdsprinter2',
		label = 'Mercedes Sprinter'
	},
	{
		model = 'victorialspd',
		label = 'Ford Victoria'
	},
	  {
		model = 'DodgeRam2016',
		label = 'Dodge Ram 2016'
	},
	{
		model = 'FordFusion2016',
		label = 'Ford Fusion 2016'
	},
	{
		model = 'valor14charg',
		label = 'Dodge Charger 2014'
	},

},

Tropper2step1 = {
	{
		model = 'esa',
		label = '---- TROPPER 2 Step 1 ----'
	},
	{
		model = 'cvpileg',
		label = 'Ford Victoria'
	},
	{
	   model = 'valorcap',
	   label = 'Ford Taurus'
   },
	{
		model = 'policet',
		label = 'Transporter'
	},
	{
		model = 'jtdsprinter2',
		label = 'Mercedes Sprinter'
	},
	{
		model = 'victorialspd',
		label = 'Ford Victoria'
	},
	  {
		model = 'DodgeRam2016',
		label = 'Dodge Ram 2016'
	},
	{
		model = 'FordFusion2016',
		label = 'Ford Fusion 2016'
	},
	{
		model = 'valor14charg',
		label = 'Dodge Charger 2014'
	},
	{
		model = 'MaibatsuSanchez',
		label = 'Sanchez'
	},

},

Tropper2step2 = {

	{
		model = 'esa',
		label = '---- TROPPER 2 Step 2 ----'
	},
	{
		model = 'cvpileg',
		label = 'Ford Victoria'
	},
	{
	   model = 'valorcap',
	   label = 'Ford Taurus'
   },
	{
		model = 'policet',
		label = 'Transporter'
	},
	{
		model = 'jtdsprinter2',
		label = 'Mercedes Sprinter'
	},
	{
		model = 'victorialspd',
		label = 'Ford Victoria'
	},
	  {
		model = 'DodgeRam2016',
		label = 'Dodge Ram 2016'
	},
	{
		model = 'FordFusion2016',
		label = 'Ford Fusion 2016'
	},
	{
		model = 'valor14charg',
		label = 'Dodge Charger 2014'
	},
	{
		model = 'MaibatsuSanchez',
		label = 'Sanchez'
	},
	{
		model = 'ChevroletSilverado2020',
		label = 'Chevrolet Silverado 2020'
	},
	{
		model = 'FordEverest2014',
		label = 'Ford Everest 2014'
	},
	
},
Tropper2step3 = {
	{
		model = 'esa',
		label = '---- TROPPER 2 Step 3 ----'
	},
	{
		model = 'cvpileg',
		label = 'Ford Victoria'
	},
	{
	   model = 'valorcap',
	   label = 'Ford Taurus'
   },
	{
		model = 'policet',
		label = 'Transporter'
	},
	{
		model = 'jtdsprinter2',
		label = 'Mercedes Sprinter'
	},
	{
		model = 'victorialspd',
		label = 'Ford Victoria'
	},
	  {
		model = 'DodgeRam2016',
		label = 'Dodge Ram 2016'
	},
	{
		model = 'FordFusion2016',
		label = 'Ford Fusion 2016'
	},
	{
		model = 'valor14charg',
		label = 'Dodge Charger 2014'
	},
	{
		model = 'MaibatsuSanchez',
		label = 'Sanchez'
	},
	{
		model = 'ChevroletSilverado2020',
		label = 'Chevrolet Silverado 2020'
	},
	{
		model = 'FordEverest2014',
		label = 'Ford Everest 2014'
	},
	{
		model = 'Fordf1502016',
		label = 'Ford F150 2016'
	},

	
},

Tropper3step1 = {
	{
		model = 'esa',
		label = '---- TROPPER 3 Step 1 ----'
	},
	{
		model = 'cvpileg',
		label = 'Ford Victoria'
	},
	{
	   model = 'valorcap',
	   label = 'Ford Taurus'
   },
	{
		model = 'policet',
		label = 'Transporter'
	},
	{
		model = 'jtdsprinter2',
		label = 'Mercedes Sprinter'
	},
	{
		model = 'victorialspd',
		label = 'Ford Victoria'
	},
	  {
		model = 'DodgeRam2016',
		label = 'Dodge Ram 2016'
	},
	{
		model = 'FordFusion2016',
		label = 'Ford Fusion 2016'
	},
	{
		model = 'valor14charg',
		label = 'Dodge Charger 2014'
	},
	{
		model = 'MaibatsuSanchez',
		label = 'Sanchez'
	},
	{
		model = 'ChevroletSilverado2020',
		label = 'Chevrolet Silverado 2020'
	},
	{
		model = 'FordEverest2014',
		label = 'Ford Everest 2014'
	},
	{
		model = 'Fordf1502016',
		label = 'Ford F150 2016'
	},
	{
		model = 'Fordf2502014',
		label = 'Ford F250 2014'
	},
	
},
Tropper3step2 = {
	{
		model = 'esa',
		label = '---- TROPPER 3 Step 2 ----'
	},
	{
		model = 'cvpileg',
		label = 'Ford Victoria'
	},
	{
	   model = 'valorcap',
	   label = 'Ford Taurus'
   },
	{
		model = 'policet',
		label = 'Transporter'
	},
	{
		model = 'jtdsprinter2',
		label = 'Mercedes Sprinter'
	},
	{
		model = 'victorialspd',
		label = 'Ford Victoria'
	},
	  {
		model = 'DodgeRam2016',
		label = 'Dodge Ram 2016'
	},
	{
		model = 'FordFusion2016',
		label = 'Ford Fusion 2016'
	},
	{
		model = 'valor14charg',
		label = 'Dodge Charger 2014'
	},
	{
		model = 'MaibatsuSanchez',
		label = 'Sanchez'
	},
	{
		model = 'ChevroletSilverado2020',
		label = 'Chevrolet Silverado 2020'
	},
	{
		model = 'FordEverest2014',
		label = 'Ford Everest 2014'
	},
	{
		model = 'Fordf1502016',
		label = 'Ford F150 2016'
	},
	{
		model = 'Fordf2502014',
		label = 'Ford F250 2014'
	},
	{
		model = 'KawasakiConcours2014_pd1',
		label = 'Kawasaki Concours 2014'
	},

	
},
Tropper3step3 = {
	{
		model = 'esa',
		label = '---- TROPPER 3 Step 3 ----'
	},
	{
		model = 'cvpileg',
		label = 'Ford Victoria'
	},
	{
	   model = 'valorcap',
	   label = 'Ford Taurus'
   },
	{
		model = 'policet',
		label = 'Transporter'
	},
	{
		model = 'jtdsprinter2',
		label = 'Mercedes Sprinter'
	},
	{
		model = 'victorialspd',
		label = 'Ford Victoria'
	},
	  {
		model = 'DodgeRam2016',
		label = 'Dodge Ram 2016'
	},
	{
		model = 'FordFusion2016',
		label = 'Ford Fusion 2016'
	},
	{
		model = 'valor14charg',
		label = 'Dodge Charger 2014'
	},
	{
		model = 'MaibatsuSanchez',
		label = 'Sanchez'
	},
	{
		model = 'ChevroletSilverado2020',
		label = 'Chevrolet Silverado 2020'
	},
	{
		model = 'FordEverest2014',
		label = 'Ford Everest 2014'
	},
	{
		model = 'Fordf1502016',
		label = 'Ford F150 2016'
	},
	{
		model = 'Fordf2502014',
		label = 'Ford F250 2014'
	},
	{
		model = 'KawasakiConcours2014_pd1',
		label = 'Kawasaki Concours 2014'
	},

	{
		model = 'FordExpedition2018',
		label = 'Ford Expedition 2018'
	},


	
},
Tropper3step4 = {
	{
		model = 'esa',
		label = '---- TROPPER 3 Step 4 ----'
	},
	{
		model = 'cvpileg',
		label = 'Ford Victoria'
	},
	{
	   model = 'valorcap',
	   label = 'Ford Taurus'
   },
	{
		model = 'policet',
		label = 'Transporter'
	},
	{
		model = 'jtdsprinter2',
		label = 'Mercedes Sprinter'
	},
	{
		model = 'victorialspd',
		label = 'Ford Victoria'
	},
	  {
		model = 'DodgeRam2016',
		label = 'Dodge Ram 2016'
	},
	{
		model = 'FordFusion2016',
		label = 'Ford Fusion 2016'
	},
	{
		model = 'valor14charg',
		label = 'Dodge Charger 2014'
	},
	{
		model = 'MaibatsuSanchez',
		label = 'Sanchez'
	},
	{
		model = 'ChevroletSilverado2020',
		label = 'Chevrolet Silverado 2020'
	},
	{
		model = 'FordEverest2014',
		label = 'Ford Everest 2014'
	},
	{
		model = 'Fordf1502016',
		label = 'Ford F150 2016'
	},
	{
		model = 'Fordf2502014',
		label = 'Ford F250 2014'
	},
	{
		model = 'KawasakiConcours2014_pd1',
		label = 'Kawasaki Concours 2014'
	},

	{
		model = 'FordExpedition2018',
		label = 'Ford Expedition 2018'
	},
	{
		model = '17zr2bb',
		label = 'Chevrolet Colorado'
	},

	
},
SeniorTropper = {
	{
		model = 'esa',
		label = '---- SENIOR TROPPER ----'
	},
	{
		model = 'cvpileg',
		label = 'Ford Victoria'
	},
	{
	   model = 'valorcap',
	   label = 'Ford Taurus'
   },
	{
		model = 'policet',
		label = 'Transporter'
	},
	{
		model = 'jtdsprinter2',
		label = 'Mercedes Sprinter'
	},
	{
		model = 'victorialspd',
		label = 'Ford Victoria'
	},
	  {
		model = 'DodgeRam2016',
		label = 'Dodge Ram 2016'
	},
	{
		model = 'FordFusion2016',
		label = 'Ford Fusion 2016'
	},
	{
		model = 'valor14charg',
		label = 'Dodge Charger 2014'
	},
	{
		model = 'MaibatsuSanchez',
		label = 'Sanchez'
	},
	{
		model = 'ChevroletSilverado2020',
		label = 'Chevrolet Silverado 2020'
	},
	{
		model = 'FordEverest2014',
		label = 'Ford Everest 2014'
	},
	{
		model = 'Fordf1502016',
		label = 'Ford F150 2016'
	},
	{
		model = 'Fordf2502014',
		label = 'Ford F250 2014'
	},
	{
		model = 'KawasakiConcours2014_pd1',
		label = 'Kawasaki Concours 2014'
	},

	{
		model = 'FordExpedition2018',
		label = 'Ford Expedition 2018'
	},
	{
		model = '17zr2bb',
		label = 'Chevrolet Colorado'
	},
	{
		model = 'FR',
		label = 'Chevrolet Tahoe 2019'
	},
	
},

SergeantI  = {
	{
		model = 'esa',
		label = '---- SERGANT I ----'
	},
	{
		model = 'cvpileg',
		label = 'Ford Victoria'
	},
	{
	   model = 'valorcap',
	   label = 'Ford Taurus'
   },
	{
		model = 'policet',
		label = 'Transporter'
	},
	{
		model = 'jtdsprinter2',
		label = 'Mercedes Sprinter'
	},
	{
		model = 'victorialspd',
		label = 'Ford Victoria'
	},
	  {
		model = 'DodgeRam2016',
		label = 'Dodge Ram 2016'
	},
	{
		model = 'FordFusion2016',
		label = 'Ford Fusion 2016'
	},
	{
		model = 'valor14charg',
		label = 'Dodge Charger 2014'
	},
	{
		model = 'MaibatsuSanchez',
		label = 'Sanchez'
	},
	{
		model = 'ChevroletSilverado2020',
		label = 'Chevrolet Silverado 2020'
	},
	{
		model = 'FordEverest2014',
		label = 'Ford Everest 2014'
	},
	{
		model = 'Fordf1502016',
		label = 'Ford F150 2016'
	},
	{
		model = 'Fordf2502014',
		label = 'Ford F250 2014'
	},
	{
		model = 'KawasakiConcours2014_pd1',
		label = 'Kawasaki Concours 2014'
	},

	{
		model = 'FordExpedition2018',
		label = 'Ford Expedition 2018'
	},
	{
		model = '17zr2bb',
		label = 'Chevrolet Colorado'
	},
	{
		model = 'FR',
		label = 'Chevrolet Tahoe 2019'
	},
	{
		model = 'jtd19tundra',
		label = 'Toyota Tundra'
	},

	
},
SergeantII = {
	{
		model = 'esa',
		label = '---- SERGANT II ----'
	},
	{
		model = 'cvpileg',
		label = 'Ford Victoria'
	},
	{
	   model = 'valorcap',
	   label = 'Ford Taurus'
   },
	{
		model = 'policet',
		label = 'Transporter'
	},
	{
		model = 'jtdsprinter2',
		label = 'Mercedes Sprinter'
	},
	{
		model = 'victorialspd',
		label = 'Ford Victoria'
	},
	  {
		model = 'DodgeRam2016',
		label = 'Dodge Ram 2016'
	},
	{
		model = 'FordFusion2016',
		label = 'Ford Fusion 2016'
	},
	{
		model = 'valor14charg',
		label = 'Dodge Charger 2014'
	},
	{
		model = 'MaibatsuSanchez',
		label = 'Sanchez'
	},
	{
		model = 'ChevroletSilverado2020',
		label = 'Chevrolet Silverado 2020'
	},
	{
		model = 'FordEverest2014',
		label = 'Ford Everest 2014'
	},
	{
		model = 'Fordf1502016',
		label = 'Ford F150 2016'
	},
	{
		model = 'Fordf2502014',
		label = 'Ford F250 2014'
	},
	{
		model = 'KawasakiConcours2014_pd1',
		label = 'Kawasaki Concours 2014'
	},

	{
		model = 'FordExpedition2018',
		label = 'Ford Expedition 2018'
	},
	{
		model = '17zr2bb',
		label = 'Chevrolet Colorado'
	},
	{
		model = 'FR',
		label = 'Chevrolet Tahoe 2019'
	},
	{
		model = 'jtd19tundra',
		label = 'Toyota Tundra'
	},
	{
		model = '18jeep',
		label = 'Jeep Trackhowk'
	},

},

SergeantIII = {
	{
		model = 'esa',
		label = '---- SERGANT III ----'
	},
	{
		model = 'cvpileg',
		label = 'Ford Victoria'
	},
	{
	   model = 'valorcap',
	   label = 'Ford Taurus'
   },
	{
		model = 'policet',
		label = 'Transporter'
	},
	{
		model = 'jtdsprinter2',
		label = 'Mercedes Sprinter'
	},
	{
		model = 'victorialspd',
		label = 'Ford Victoria'
	},
	  {
		model = 'DodgeRam2016',
		label = 'Dodge Ram 2016'
	},
	{
		model = 'FordFusion2016',
		label = 'Ford Fusion 2016'
	},
	{
		model = 'valor14charg',
		label = 'Dodge Charger 2014'
	},
	{
		model = 'MaibatsuSanchez',
		label = 'Sanchez'
	},
	{
		model = 'ChevroletSilverado2020',
		label = 'Chevrolet Silverado 2020'
	},
	{
		model = 'FordEverest2014',
		label = 'Ford Everest 2014'
	},
	{
		model = 'Fordf1502016',
		label = 'Ford F150 2016'
	},
	{
		model = 'Fordf2502014',
		label = 'Ford F250 2014'
	},
	{
		model = 'KawasakiConcours2014_pd1',
		label = 'Kawasaki Concours 2014'
	},

	{
		model = 'FordExpedition2018',
		label = 'Ford Expedition 2018'
	},
	{
		model = '17zr2bb',
		label = 'Chevrolet Colorado'
	},
	{
		model = 'FR',
		label = 'Chevrolet Tahoe 2019'
	},
	{
		model = 'jtd19tundra',
		label = 'Toyota Tundra'
	},
	{
		model = '18jeep',
		label = 'Jeep Trackhowk'
	},
	{
		model = 'durangoleo',
		label = 'Dodge Durango SRT'
	},
			
},


SeniorSergeant  = {
	{
		model = 'esa',
		label = '---- SENIOR SERGANT ----'
	},
	{
		model = 'cvpileg',
		label = 'Ford Victoria'
	},
	{
	   model = 'valorcap',
	   label = 'Ford Taurus'
   },
	{
		model = 'policet',
		label = 'Transporter'
	},
	{
		model = 'jtdsprinter2',
		label = 'Mercedes Sprinter'
	},
	{
		model = 'victorialspd',
		label = 'Ford Victoria'
	},
	  {
		model = 'DodgeRam2016',
		label = 'Dodge Ram 2016'
	},
	{
		model = 'FordFusion2016',
		label = 'Ford Fusion 2016'
	},
	{
		model = 'valor14charg',
		label = 'Dodge Charger 2014'
	},
	{
		model = 'MaibatsuSanchez',
		label = 'Sanchez'
	},
	{
		model = 'ChevroletSilverado2020',
		label = 'Chevrolet Silverado 2020'
	},
	{
		model = 'FordEverest2014',
		label = 'Ford Everest 2014'
	},
	{
		model = 'Fordf1502016',
		label = 'Ford F150 2016'
	},
	{
		model = 'Fordf2502014',
		label = 'Ford F250 2014'
	},
	{
		model = 'KawasakiConcours2014_pd1',
		label = 'Kawasaki Concours 2014'
	},

	{
		model = 'FordExpedition2018',
		label = 'Ford Expedition 2018'
	},
	{
		model = '17zr2bb',
		label = 'Chevrolet Colorado'
	},
	{
		model = 'FR',
		label = 'Chevrolet Tahoe 2019'
	},
	{
		model = 'jtd19tundra',
		label = 'Toyota Tundra'
	},
	{
		model = '18jeep',
		label = 'Trackhowk'
	},
	{
		model = 'durangoleo',
		label = 'Dodge Durango SRT'
	},
	{
		model = 'yamaha',
		label = 'Yamaha R1'
	},			
},
CapitanI = {

	{
		model = 'esa',
		label = '---- CAPITAN I ----'
	},
	{
		model = 'cvpileg',
		label = 'Ford Victoria'
	},
	{
	   model = 'valorcap',
	   label = 'Ford Taurus'
    },
	{
		model = 'policet',
		label = 'Transporter'
	},
	{
		model = 'jtdsprinter2',
		label = 'Mercedes Sprinter'
	},
	{
		model = 'victorialspd',
		label = 'Ford Victoria'
	},
	  {
		model = 'DodgeRam2016',
		label = 'Dodge Ram 2016'
	},
	{
		model = 'FordFusion2016',
		label = 'Ford Fusion 2016'
	},
	{
		model = 'valor14charg',
		label = 'Dodge Charger 2014'
	},
	{
		model = 'MaibatsuSanchez',
		label = 'Sanchez'
	},
	{
		model = 'ChevroletSilverado2020',
		label = 'Chevrolet Silverado 2020'
	},
	{
		model = 'FordEverest2014',
		label = 'Ford Everest 2014'
	},
	{
		model = 'Fordf1502016',
		label = 'Ford F150 2016'
	},
	{
		model = 'Fordf2502014',
		label = 'Ford F250 2014'
	},
	{
		model = 'KawasakiConcours2014_pd1',
		label = 'Kawasaki Concours 2014'
	},

	{
		model = 'FordExpedition2018',
		label = 'Ford Expedition 2018'
	},
	{
		model = '17zr2bb',
		label = 'Chevrolet Colorado'
	},
	{
		model = 'FR',
		label = 'Chevrolet Tahoe 2019'
	},
	{
		model = 'jtd19tundra',
		label = 'Toyota Tundra'
	},
	{
		model = '18jeep',
		label = 'Jeep Trackhowk'
	},
	{
		model = 'durangoleo',
		label = 'Dodge Durango SRT'
	},
	{
		model = 'yamaha',
		label = 'Yamaha R1'
	},
	{
		model = 'JeepCherokee2019',
		label = 'Jeep Cherokee 2019'
	},


},
CapitanII = {
	{
		model = 'esa',
		label = '---- CAPITAN II ----'
	},
	{
		model = 'cvpileg',
		label = 'Ford Victoria'
	},
	{
	   model = 'valorcap',
	   label = 'Ford Taurus'
    },
	{
		model = 'policet',
		label = 'Transporter'
	},
	{
		model = 'jtdsprinter2',
		label = 'Mercedes Sprinter'
	},
	{
		model = 'victorialspd',
		label = 'Ford Victoria'
	},
	  {
		model = 'DodgeRam2016',
		label = 'Dodge Ram 2016'
	},
	{
		model = 'FordFusion2016',
		label = 'Ford Fusion 2016'
	},
	{
		model = 'valor14charg',
		label = 'Dodge Charger 2014'
	},
	{
		model = 'MaibatsuSanchez',
		label = 'Sanchez'
	},
	{
		model = 'ChevroletSilverado2020',
		label = 'Chevrolet Silverado 2020'
	},
	{
		model = 'FordEverest2014',
		label = 'Ford Everest 2014'
	},
	{
		model = 'Fordf1502016',
		label = 'Ford F150 2016'
	},
	{
		model = 'Fordf2502014',
		label = 'Ford F250 2014'
	},
	{
		model = 'KawasakiConcours2014_pd1',
		label = 'Kawasaki Concours 2014'
	},

	{
		model = 'FordExpedition2018',
		label = 'Ford Expedition 2018'
	},
	{
		model = '17zr2bb',
		label = 'Chevrolet Colorado'
	},
	{
		model = 'FR',
		label = 'Chevrolet Tahoe 2019'
	},
	{
		model = 'jtd19tundra',
		label = 'Toyota Tundra'
	},
	{
		model = '18jeep',
		label = 'Jeep Trackhowk'
	},
	{
		model = 'durangoleo',
		label = 'Dodge Durango SRT'
	},
	{
		model = 'yamaha',
		label = 'Yamaha R1'
	},
	{
		model = 'JeepCherokee2019',
		label = 'Jeep Cherokee 2019'
	},

},
CapitanIII = {

	{
		model = 'esa',
		label = '---- CAPITAN III ----'
	},
	{
		model = 'cvpileg',
		label = 'Ford Victoria'
	},
	{
	   model = 'valorcap',
	   label = 'Ford Taurus'
    },
	{
		model = 'policet',
		label = 'Transporter'
	},
	{
		model = 'jtdsprinter2',
		label = 'Mercedes Sprinter'
	},
	{
		model = 'victorialspd',
		label = 'Ford Victoria'
	},
	  {
		model = 'DodgeRam2016',
		label = 'Dodge Ram 2016'
	},
	{
		model = 'FordFusion2016',
		label = 'Ford Fusion 2016'
	},
	{
		model = 'valor14charg',
		label = 'Dodge Charger 2014'
	},
	{
		model = 'MaibatsuSanchez',
		label = 'Sanchez'
	},
	{
		model = 'ChevroletSilverado2020',
		label = 'Chevrolet Silverado 2020'
	},
	{
		model = 'FordEverest2014',
		label = 'Ford Everest 2014'
	},
	{
		model = 'Fordf1502016',
		label = 'Ford F150 2016'
	},
	{
		model = 'Fordf2502014',
		label = 'Ford F250 2014'
	},
	{
		model = 'KawasakiConcours2014_pd1',
		label = 'Kawasaki Concours 2014'
	},

	{
		model = 'FordExpedition2018',
		label = 'Ford Expedition 2018'
	},
	{
		model = '17zr2bb',
		label = 'Chevrolet Colorado'
	},
	{
		model = 'FR',
		label = 'Chevrolet Tahoe 2019'
	},
	{
		model = 'jtd19tundra',
		label = 'Toyota Tundra'
	},
	{
		model = '18jeep',
		label = 'Jeep Trackhowk'
	},
	{
		model = 'durangoleo',
		label = 'Dodge Durango SRT'
	},
	{
		model = 'yamaha',
		label = 'Yamaha R1'
	},
	{
		model = 'JeepCherokee2019',
		label = 'Jeep Cherokee 2019'
	},
	{
		model = 'pd_bmwr',
		label = 'BMW M5'
	},


},

SeniorCapitan = {

	{
		model = 'esa',
		label = '---- SENIOR CAPITAN ----'
	},
	{
		model = 'cvpileg',
		label = 'Ford Victoria'
	},
	{
	   model = 'valorcap',
	   label = 'Ford Taurus'
    },
	{
		model = 'policet',
		label = 'Transporter'
	},
	{
		model = 'jtdsprinter2',
		label = 'Mercedes Sprinter'
	},
	{
		model = 'victorialspd',
		label = 'Ford Victoria'
	},
	  {
		model = 'DodgeRam2016',
		label = 'Dodge Ram 2016'
	},
	{
		model = 'FordFusion2016',
		label = 'Ford Fusion 2016'
	},
	{
		model = 'valor14charg',
		label = 'Dodge Charger 2014'
	},
	{
		model = 'MaibatsuSanchez',
		label = 'Sanchez'
	},
	{
		model = 'ChevroletSilverado2020',
		label = 'Chevrolet Silverado 2020'
	},
	{
		model = 'FordEverest2014',
		label = 'Ford Everest 2014'
	},
	{
		model = 'Fordf1502016',
		label = 'Ford F150 2016'
	},
	{
		model = 'Fordf2502014',
		label = 'Ford F250 2014'
	},
	{
		model = 'KawasakiConcours2014_pd1',
		label = 'Kawasaki Concours 2014'
	},

	{
		model = 'FordExpedition2018',
		label = 'Ford Expedition 2018'
	},
	{
		model = '17zr2bb',
		label = 'Chevrolet Colorado'
	},
	{
		model = 'FR',
		label = 'Chevrolet Tahoe 2019'
	},
	{
		model = 'jtd19tundra',
		label = 'Toyota Tundra'
	},
	{
		model = '18jeep',
		label = 'Jeep Trackhowk'
	},
	{
		model = 'durangoleo',
		label = 'Dodge Durango SRT'
	},
	{
		model = 'yamaha',
		label = 'Yamaha R1'
	},
	{
		model = 'JeepCherokee2019',
		label = 'Jeep Cherokee 2019'
	},
	{
		model = 'pd_bmwr',
		label = 'BMW M5'
	},	
},

boss = {
	{
		model = 'esa',
		label = '---- SENIOR CAPITAN ----'
	},
	{
		model = 'cvpileg',
		label = 'Ford Victoria'
	},
	{
	   model = 'valorcap',
	   label = 'Ford Taurus'
    },
	{
		model = 'policet',
		label = 'Transporter'
	},
	{
		model = 'jtdsprinter2',
		label = 'Mercedes Sprinter'
	},
	{
		model = 'victorialspd',
		label = 'Ford Victoria'
	},
	  {
		model = 'DodgeRam2016',
		label = 'Dodge Ram 2016'
	},
	{
		model = 'FordFusion2016',
		label = 'Ford Fusion 2016'
	},
	{
		model = 'valor14charg',
		label = 'Dodge Charger 2014'
	},
	{
		model = 'MaibatsuSanchez',
		label = 'Sanchez'
	},
	{
		model = 'ChevroletSilverado2020',
		label = 'Chevrolet Silverado 2020'
	},
	{
		model = 'FordEverest2014',
		label = 'Ford Everest 2014'
	},
	{
		model = 'Fordf1502016',
		label = 'Ford F150 2016'
	},
	{
		model = 'Fordf2502014',
		label = 'Ford F250 2014'
	},
	{
		model = 'KawasakiConcours2014_pd1',
		label = 'Kawasaki Concours 2014'
	},

	{
		model = 'FordExpedition2018',
		label = 'Ford Expedition 2018'
	},
	{
		model = '17zr2bb',
		label = 'Chevrolet Colorado'
	},
	{
		model = 'FR',
		label = 'Chevrolet Tahoe 2019'
	},
	{
		model = 'jtd19tundra',
		label = 'Toyota Tundra'
	},
	{
		model = '18jeep',
		label = 'Jeep Trackhowk'
	},
	{
		model = 'durangoleo',
		label = 'Dogde Durango SRT'
	},
	{
		model = 'yamaha',
		label = 'Yamaha R1'
	},
	{
		model = 'JeepCherokee2019',
		label = 'Jeep Cherokee 2019'
	},
	{
		model = 'pd_bmwr',
		label = 'BMW M5'
	},
	{
		model = 'esa',
		label = '---- Zarząd ----'
	},
	{
		model = 'rover',
		label = 'Range Rover'
	},
	{
		model = 'DodgeViper2018',
		label = 'Dodge Viper 2018'
	},
	{
		model = 'ngt19',
		label = 'Nissan GTR'
	},
	{
		model = 'pd_c8b',
		label = 'Chevrolet Cervette C8'
	},
},	
swat = {
	{
		model = 'esa',
		label = '---- SERT ----'
	},
	{
		model = 'pd_gwagon',
		label = 'Mercedes G-65'
	},		
	{
		model = 'pd_escalade',
		label = 'Cadilac Escalade'
	},
	{
		model = 'h1',
		label = 'Hummer h1'
	},		
},
seu  = {
	{
		model = 'esa',
		label = '---- SEU ----'
	},
	{
		model = 'FordFocus2018',
		label = 'Ford Focus 2018'
	},		
	{
		model = 'pd_tesla',
		label = 'Tesla Model S'
	},			
},
seuoffroad  = {
	{
		model = 'esa',
		label = '---- SEU2 ----'
	},
	{
		model = 'FordMustang2018',
		label = 'Ford Mustang 2018'
	},		
	{
		model = 'ChevroletCorvette2019ZR',
		label = 'Chevrolet Corvette 2019 ZR1'
	},	
	{
		model = 'ToyotaSupra2019',
		label = 'Toyota Supra 2019'
	},		
	{
		model = 'camaroBB',
		label = 'Chevrolet Camaro'
	},
	{
		model = 'DodgeChalanger2018',
		label = 'Dodge Chalanger 2018'
	},
	{
		model = 'hellcatRB',
		label = 'Dodge Charger SRT'
	},
},
}


-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
	cadet_Trooper_1_step_3 = {
		male = {
            ['tshirt_1'] = 85,  ['tshirt_2'] = 0,
            ['torso_1'] = 110,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 11,
            ['pants_1'] = 66,   ['pants_2'] = 0,
            ['shoes_1'] = 36,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 0,     ['ears_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 2

        },
	 	female = {
			['tshirt_1'] = 36,  ['tshirt_2'] = 1,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = 45,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	Trooper_2_step_1_Trooper_2_step_3 = {
		male = {
            ['tshirt_1'] = 85,  ['tshirt_2'] = 0,
            ['torso_1'] = 110,   ['torso_2'] = 1,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 11,
            ['pants_1'] = 66,   ['pants_2'] = 0,
            ['shoes_1'] = 36,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 0,     ['ears_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 2

        },
		female = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 26,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 26,
			['pants_1'] = 49,   ['pants_2'] = 0,
			['shoes_1'] = 40,   ['shoes_2'] = 9,
			['helmet_1'] = 13,  ['helmet_2'] = 2,
			['chain_1'] = 125,  ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	treningowy_wear = {
		male = {
			['tshirt_1'] = 55,  ['tshirt_2'] = 0,
            ['torso_1'] = 186,    ['torso_2'] = 1,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 35,               ['arms_2'] = 0,
            ['pants_1'] = 53,   ['pants_2'] = 0,
            ['shoes_1'] = 36,   ['shoes2'] = 0,
            ['helmet-1'] = 10,  ['helmet_2'] = 6,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = -1,    ['ears_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0,
            ['mask_1'] = 170,  ['mask_2'] = 0,

		},
		female = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 26,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 26,
			['pants_1'] = 49,   ['pants_2'] = 0,
			['shoes_1'] = 40,   ['shoes_2'] = 9,
			['helmet_1'] = 13,  ['helmet_2'] = 2,
			['chain_1'] = 125,  ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	motor_wear = {
		male = {
            ['tshirt_1'] = 119,  ['tshirt_2'] = 3,
            ['torso_1'] = 181,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 22,
            ['pants_1'] = 63,   ['pants_2'] = 0,
            ['shoes_1'] = 44,   ['shoes_2'] = 0,
            ['helmet_1'] = 17,  ['helmet_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 0,     ['ears_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 2

        },
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
			}
		},

	boss_wear = {
		male = {
			['tshirt_1'] = 105,  ['tshirt_2'] = 0,
			['torso_1'] = 108,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 30,
			['pants_1'] = 31,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 7,  ['helmet_2'] = 7,
			['chain_1'] = 125,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
	},

	zarzad = {
		male = {
            ['tshirt_1'] = 134,  ['tshirt_2'] = 0,
            ['torso_1'] = 109,   ['torso_2'] = 2,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 36,
            ['pants_1'] = 66,   ['pants_2'] = 0,
            ['shoes_1'] = 109,   ['shoes_2'] = 2,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 0,     ['ears_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 2

        },
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
			}
		},
		CTTF_wear = {
			male = {
				['tshirt_1'] = 108,  ['tshirt_2'] = 0,
				['torso_1'] = 141,   ['torso_2'] = 0,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 29,
				['pants_1'] = 65,   ['pants_2'] = 0,
				['shoes_1'] = 36,   ['shoes_2'] = 0,
				['helmet_1'] = 119,  ['helmet_2'] = 1,
				['chain_1'] = 0,    ['chain_2'] = 0,
				['ears_1'] = 0,     ['ears_2'] = 0,
				['bproof_1'] = 2,  ['bproof_2'] = 1
		
			},
			female = {
				['tshirt_1'] = 35,  ['tshirt_2'] = 0,
				['torso_1'] = 48,   ['torso_2'] = 0,
				['decals_1'] = 7,   ['decals_2'] = 3,
				['arms'] = 44,
				['pants_1'] = 34,   ['pants_2'] = 0,
				['shoes_1'] = 27,   ['shoes_2'] = 0,
				['helmet_1'] = -1,  ['helmet_2'] = 0,
				['chain_1'] = 0,    ['chain_2'] = 0,
				['ears_1'] = 2,     ['ears_2'] = 0
			}
		},
		pilothelki_wear = {
			male = {
				['tshirt_1'] = 15,  ['tshirt_2'] = 0,
				['torso_1'] = 132,   ['torso_2'] = 0,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 22,
				['pants_1'] = 64,   ['pants_2'] = 0,
				['shoes_1'] = 36,   ['shoes_2'] = 0,
				['helmet_1'] = 78,  ['helmet_2'] = 0,
				['chain_1'] = 2,    ['chain_2'] = 0,
				['ears_1'] = 0,     ['ears_2'] = 0,
				['mask_1'] = 84,     ['mask_2'] = 0,
				['bproof_1'] = 101,  ['bproof_2'] = 0
			},
			female = {
				['tshirt_1'] = 35,  ['tshirt_2'] = 0,
				['torso_1'] = 48,   ['torso_2'] = 0,
				['decals_1'] = 7,   ['decals_2'] = 3,
				['arms'] = 44,
				['pants_1'] = 34,   ['pants_2'] = 0,
				['shoes_1'] = 27,   ['shoes_2'] = 0,
				['helmet_1'] = -1,  ['helmet_2'] = 0,
				['chain_1'] = 0,    ['chain_2'] = 0,
				['ears_1'] = 2,     ['ears_2'] = 0
			}
		},
		Trooper_3_step_1_Trooper_3  = {
			male = {
				['tshirt_1'] = 85,  ['tshirt_2'] = 0,
				['torso_1'] = 109,   ['torso_2'] = 0,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 1,
				['pants_1'] = 66,   ['pants_2'] = 0,
				['shoes_1'] = 36,   ['shoes_2'] = 0,
				['helmet_1'] = -1,  ['helmet_2'] = 0,
				['chain_1'] = 0,    ['chain_2'] = 0,
				['ears_1'] = 0,     ['ears_2'] = 0,
				['bproof_1'] = 0,  ['bproof_2'] = 2
	
			},
			female = {
				['tshirt_1'] = 35,  ['tshirt_2'] = 0,
				['torso_1'] = 48,   ['torso_2'] = 0,
				['decals_1'] = 7,   ['decals_2'] = 3,
				['arms'] = 44,
				['pants_1'] = 34,   ['pants_2'] = 0,
				['shoes_1'] = 27,   ['shoes_2'] = 0,
				['helmet_1'] = -1,  ['helmet_2'] = 0,
				['chain_1'] = 0,    ['chain_2'] = 0,
				['ears_1'] = 2,     ['ears_2'] = 0
			}
		},	
		Senior_Trooper_DO_Senior_Sergeant = {
			male = {
				['tshirt_1'] = 134,  ['tshirt_2'] = 0,
				['torso_1'] = 131,   ['torso_2'] = 0,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 11,
				['pants_1'] = 90,   ['pants_2'] = 9,
				['shoes_1'] = 36,   ['shoes_2'] = 0,
				['helmet_1'] = -1,  ['helmet_2'] = 0,
				['chain_1'] = 0,    ['chain_2'] = 0,
				['ears_1'] = 0,     ['ears_2'] = 0,
				['bproof_1'] = 0,  ['bproof_2'] = 2
	
			},
			female = {
				['tshirt_1'] = 35,  ['tshirt_2'] = 0,
				['torso_1'] = 48,   ['torso_2'] = 0,
				['decals_1'] = 7,   ['decals_2'] = 3,
				['arms'] = 44,
				['pants_1'] = 34,   ['pants_2'] = 0,
				['shoes_1'] = 27,   ['shoes_2'] = 0,
				['helmet_1'] = -1,  ['helmet_2'] = 0,
				['chain_1'] = 0,    ['chain_2'] = 0,
				['ears_1'] = 2,     ['ears_2'] = 0
			}
		},
		capitan_1_senior_capitan = {
			male = {
			['tshirt_1'] = 85,  ['tshirt_2'] = 0,
			['torso_1'] = 109,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 36,
			['pants_1'] = 66,   ['pants_2'] = 0,
			['shoes_1'] = 109,   ['shoes_2'] = 2,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 2
	
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	SAST_1_wear = {
		male = {
			['bproof_1'] = 54,  ['bproof_2'] = 0
		},
		female = {
			['bproof_1'] = 3,  ['bproof_2'] = 0
		}
	},
	SAST_2_wear = {
		male = {
			['bproof_1'] = 9,  ['bproof_2'] = 0
		},
		female = {
			['bproof_1'] = 3,  ['bproof_2'] = 0
		}
	},
	CTTF_wear2 = {
		male = {
			['bproof_1'] = 2,  ['bproof_2'] = 1
		},
		female = {
			['bproof_1'] = 3,  ['bproof_2'] = 0
		}
	}
}
Config.Weapons = {
emka = {
label = "",
value = "",
ammo = 72,
},
drugaemka = {
label = "",
value = "",
ammo = 72,
},


}
