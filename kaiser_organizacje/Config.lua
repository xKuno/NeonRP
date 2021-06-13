Config              = {}
Config.DrawDistance = 100.0
Config.MarkerSize                 = { x = 1.1, y = 1.1, z = 0.5 }
Config.Locale = 'pl'
--[[
Aby skrypt zadziałał musisz dodać do tabeli users w bazie danych 2 kolumny:
`org` oraz `org_grade`      
org jako VARCHAR, 255 znaków, default value 'unemployed'
org_grade jako int 11 znaków, default value 0



Jak tworzysz organizację nie zapomnij utworzyć w: 
addon_account: society_nazwaorganizacji, society_nazwaorganizacji_black
addon_inventory: society_nazwaorganizacji
datastore: society_nazwaorganizacji
te same dane wpisujesz w Ustawieniach poniżej

W tabeli kaiser_orgs musisz dodać organizację w name wpisujesz nazwę, a w level wpisujesz 1


Aby kogoś zatrudnić jako admin: /setdualjobadmin ID NAZWAORGANIZACIJ GRADE ------- setdualjobadmin 2 biali 4

Aby kogoś zatrudnić jako szef mając grade 4: /setdualjob ID nazwatwojejorganizacji GRADE
Aby kogoś zwolnić analognicznie /setdualjob ID unemployed 0






Kolory furek na:  https://wiki.rage.mp/index.php?title=Vehicle_Colors
Jak chcesz full ciemne szybki to glass = 1, bez przyciemniania glass = 0, glass = 2,3,4 to mniej ciemne
tunning = true daje tunning mechaniczny
]]

Config.MaxLevel = 5
Config.StartLevel = 0
Config.Limits = {5,10,15,20,99}   -- limity osob po kolei od 1 levela do 5
Config.LevelPrices = {5000,10000,15000,20000}   -- kasa za levelowanie po kolei na poczatek na 2 level potem na 3 etc.
Config.Prace = {
	"ogd",
	"brx",
	"ballasi",
    "biali",
	"ttc",
	"ccf",
	"cb",
	"wwa",
	"brx",
	"gkb",
	"tbf"
}

Config.Ustawienia = {
	['biali'] = {
		bronie = true,
		society = 'society_biali',				
		szafka = 'biali',
		societyblack = 'society_biali_black',
		bronie = {
			-- { name = 'weapon_pistol_mk2', price = 200000, unlocked = 1, ammo = 100 },						
		},
		itemy = {
			{ name = 'Suppressor', price = 50000, unlocked = 1, label = 'Tlumik' },
			{ name = 'clip', price = 1000, unlocked = 1, label = 'Magazynek' },
			{ name = 'blantgigant', price = 600000, unlocked = 1, label = 'Blancior Gigancior' },
			{ name = 'vintagepistol', price = 350000, unlocked = 1, label = 'Vintage Pistolet' },
			{ name = 'powiekszonymagazynek', price = 300000, unlocked = 1, label = 'Powiekszony magazynek' },
			{ name = 'pistol', price = 100000, unlocked = 1, label = 'Pistolet' },
		},
		samochody = {
			   {name = '4444', label = 'Brabus 700', color = 74, glass = 3, tunning = true, count = 2},		
		},
		pex = {
			samochody = 3,
			wyciaganiebroni = 2,
			wyciaganieitemow = 2,
			wyciaganiekasy = 4,
			wyciaganiekasybrudnej = 4,
			kupowaniebroni = 0,
			kupowanieprzedmiotow = 0,
		}
	},
	['brx'] = {
		bronie = true,
		society = 'society_brx',				
		szafka = 'brx',
		societyblack = 'society_brx_black',
		bronie = {
			-- { name = 'WEAPON_SNSPISTOL_MK2', price = 200000, unlocked = 1, ammo = 100 },					
		},
		itemy = {
			-- { name = 'Suppressor', price = 50000, unlocked = 1, label = 'Tłumik' },
			{ name = 'clip', price = 1000, unlocked = 1, label = 'Magazynek' },
			{ name = 'blantgigant', price = 600000, unlocked = 1, label = 'Blancior Gigancior' },
			{ name = 'Suppressor', price = 600000, unlocked = 1, label = 'Tlumik' },
			{ name = 'snspistol', price = 80000, unlocked = 1, label = 'Pukawka' },
			{ name = 'pistol', price = 100000, unlocked = 1, label = 'Pistolet' },
		},
		samochody = {
			-- {name = 'velar', label = 'Range Rover Velar', color = 159, glass = 1, tunning = true, count = 2},		
		},
		pex = {
			samochody = 1,
			wyciaganiebroni = 2,
			wyciaganieitemow = 2,
			wyciaganiekasy = 4,
			wyciaganiekasybrudnej = 4,
			kupowaniebroni = 0,
			kupowanieprzedmiotow = 0,
		}
	},
	-- ['ballasi'] = {
	-- 	bronie = true,
	-- 	society = 'society_ballasi',				
	-- 	szafka = 'ballasi',
	-- 	societyblack = 'society_ballasi_black',
	-- 	bronie = {
	-- 		-- { name = 'WEAPON_SNSPISTOL_MK2', price = 200000, unlocked = 1, ammo = 100 },					
	-- 	},
	-- 	itemy = {
	-- 		-- { name = 'Suppressor', price = 50000, unlocked = 1, label = 'Tłumik' },
	-- 		{ name = 'clip', price = 1000, unlocked = 1, label = 'Magazynek' },
	-- 		{ name = 'blantgigant', price = 600000, unlocked = 1, label = 'Blancior Gigancior' },
	-- 	},
	-- 	samochody = {
	-- 		 {name = 'velar', label = 'Range Rover Velar', color = 159, glass = 1, tunning = true, count = 2},		
	-- 	},
	-- 	pex = {
	-- 		samochody = 1,
	-- 		wyciaganiebroni = 2,
	-- 		wyciaganieitemow = 2,
	-- 		wyciaganiekasy = 4,
	-- 		wyciaganiekasybrudnej = 4,
	-- 		kupowaniebroni = 0,
	-- 		kupowanieprzedmiotow = 0,
	-- 	}
	-- },
	-- ['zieloni'] = {
	-- 	bronie = true,
	-- 	society = 'society_zieloni',				
	-- 	szafka = 'zieloni',
	-- 	societyblack = 'society_zieloni_black',
	-- 	bronie = {
	-- 		-- { name = 'weapon_snspistol', price = 70000, unlocked = 1, ammo = 100 },					
	-- 	},
	-- 	itemy = {
	-- 		{ name = 'clip', price = 1000, unlocked = 1, label = 'Magazynek' },
	-- 		{ name = 'blantgigant', price = 600000, unlocked = 1, label = 'Blancior Gigancior' }
	-- 		-- { name = 'bread', price = 1000000, unlocked = 1, label = 'Powiększony magazynek' },
	-- 		-- { name = 'kamza50', price = 1000000, unlocked = 1, label = 'Ciężka kamizelka' }
	-- 	},
	-- 	samochody = {
	-- 		{name = 'hustler', label = 'Hustler', color = 145, glass = 1, tunning = true, count = 5},		
	-- 		{name = 'buccaneer', label = 'Buccaneer', color = 145, glass = 1, tunning = true, count = 5},	
	-- 		{name = 'chino', label = 'Chino', color = 145, glass = 1, tunning = true, count = 5},	
	-- 		{name = 'moonbeam2', label = 'Moonbeam 2', color = 145, glass = 1, tunning = true, count = 5},
	-- 		{name = 'yosemite', label = 'Yosemite', color = 145, glass = 1, tunning = true, count = 5},
	-- 		{name = 'impaler', label = 'Impaler', color = 145, glass = 1, tunning = true, count = 5},
	-- 	},
	-- 	pex = {
	-- 		samochody = 1,
	-- 		wyciaganiebroni = 2,
	-- 		wyciaganieitemow = 2,
	-- 		wyciaganiekasy = 4,
	-- 		wyciaganiekasybrudnej = 4,
	-- 		kupowaniebroni = 0,
	-- 		kupowanieprzedmiotow = 0,
	-- 	}
	-- },
	-- ['ttc'] = {
	-- 	bronie = true,
	-- 	society = 'society_ttc',				
	-- 	szafka = 'ttc',
	-- 	societyblack = 'society_ttc_black',
	-- 	bronie = {
	-- 		-- { name = 'weapon_snspistol', price = 70000, unlocked = 1, ammo = 100 },					
	-- 	},
	-- 	itemy = {
	-- 		-- { name = 'bread', price = 1000000, unlocked = 1, label = 'Powiększony magazynek' },
	-- 		-- { name = 'kamza50', price = 1000000, unlocked = 1, label = 'Ciężka kamizelka' }
	-- 	},
	-- 	samochody = {
	-- 		-- {name = 'hustler', label = 'Hustler', color = 145, glass = 1, tunning = true, count = 5},		
	-- 	},
	-- 	pex = {
	-- 		samochody = 1,
	-- 		wyciaganiebroni = 2,
	-- 		wyciaganieitemow = 2,
	-- 		wyciaganiekasy = 4,
	-- 		wyciaganiekasybrudnej = 4,
	-- 		kupowaniebroni = 0,
	-- 		kupowanieprzedmiotow = 0,
	-- 	}
	-- },
	-- ['dwg'] = {
	-- 	bronie = true,
	-- 	society = 'society_dwg',				
	-- 	szafka = 'dwg',
	-- 	societyblack = 'society_dwg_black',
	-- 	bronie = {
	-- 		-- { name = 'weapon_snspistol_mk2', price = 70000, unlocked = 1, ammo = 100 },					
	-- 	},
	-- 	itemy = {
	-- 		{ name = 'MountedScope', price = 50000, unlocked = 1, label = 'Celownik Mk.2' },
	-- 		{ name = 'snspistol_mk2', price = 500000, unlocked = 1, label = 'Pukawka mk.2' },
	-- 		{ name = 'blantgigant', price = 600000, unlocked = 1, label = 'Blancior Gigancior' },
	-- 		{ name = 'clip', price = 1000, unlocked = 1, label = 'Magazynek' }
	-- 	},
	-- 	samochody = {
	-- 		-- {name = 'hustler', label = 'Hustler', color = 145, glass = 1, tunning = true, count = 5},		
	-- 	},
	-- 	pex = {
	-- 		samochody = 1,
	-- 		wyciaganiebroni = 2,
	-- 		wyciaganieitemow = 2,
	-- 		wyciaganiekasy = 4,
	-- 		wyciaganiekasybrudnej = 4,
	-- 		kupowaniebroni = 0,
	-- 		kupowanieprzedmiotow = 0,
	-- 	}
	-- },
	['ccf'] = {
		bronie = true,
		society = 'society_ccf',				
		szafka = 'ccf',
		societyblack = 'society_ccf_black',
		bronie = {
			-- { name = 'weapon_snspistol', price = 70000, unlocked = 1, ammo = 100 },					
		},
		itemy = {
			{ name = 'MountedScope', price = 100000, unlocked = 1, label = 'Celownik MK2' },
			{ name = 'blantgigant', price = 600000, unlocked = 1, label = 'Blancior Gigancior' },
			{ name = 'snspistol_mk2', price = 350000, unlocked = 1, label = 'Pukawka MK2' },
			{ name = 'clip', price = 1000, unlocked = 1, label = 'Magazynek' },
			{ name = 'pistol', price = 100000, unlocked = 1, label = 'Pistolet' }
		},
		samochody = {
			{name = 'brabus800a', label = 'Brabus 800a', color = 4, glass = 1, tunning = true, count = 5},		
		},
		pex = {
			samochody = 1,
			wyciaganiebroni = 2,
			wyciaganieitemow = 2,
			wyciaganiekasy = 4,
			wyciaganiekasybrudnej = 4,
			kupowaniebroni = 0,
			kupowanieprzedmiotow = 0,
		}
	},
	['cb'] = {
		bronie = true,
		society = 'society_cb',				
		szafka = 'cb',
		societyblack = 'society_cb_black',
		bronie = {
			-- { name = 'weapon_heavypistol', price = 70000, unlocked = 1, ammo = 100 },					
		},
		itemy = {
			-- { name = 'Suppressor', price = 1000, unlocked = 1, label = 'Tłumik do broni' },
			-- { name = 'heavypistol', price = 1000000, unlocked = 1, label = 'Ciężki pistolet' },
			{ name = 'blantgigant', price = 600000, unlocked = 1, label = 'Blancior Gigancior' },
			{ name = 'pistol_mk2', price = 350000, unlocked = 1, label = 'Pistolet MK.2' },
			{ name = 'flashlight', price = 10000, unlocked = 1, label = 'Latarka MK.2' },
			{ name = 'clip', price = 1000, unlocked = 1, label = 'Magazynek' },
			{ name = 'pistol', price = 100000, unlocked = 1, label = 'Pistolet' }
		},
		samochody = {
			-- {name = 'hustler', label = 'Hustler', color = 145, glass = 1, tunning = true, count = 5},		
		},
		pex = {
			samochody = 1,
			wyciaganiebroni = 2,
			wyciaganieitemow = 2,
			wyciaganiekasy = 4,
			wyciaganiekasybrudnej = 4,
			kupowaniebroni = 0,
			kupowanieprzedmiotow = 0,
		}
	},
	['tbf'] = {
		bronie = true,
		society = 'society_tbf',				
		szafka = 'tbf',
		societyblack = 'society_tbf_black',
		bronie = {
			-- { name = 'weapon_vintagepistol', price = 120000, unlocked = 1, ammo = 100 },					
		},
		itemy = {
			{ name = 'clip', price = 1000, unlocked = 1, label = 'Magazynek' },
			{ name = 'blantgigant', price = 600000, unlocked = 1, label = 'Blancior Gigancior' },
			{ name = 'pistol', price = 100000, unlocked = 1, label = 'Pistolet' }
		},
		samochody = {
			-- {name = 'rmodrs7', label = 'Audi RS7', color = 0, glass = 1, tunning = true, count = 2},	
		},
		pex = {
			samochody = 1,
			wyciaganiebroni = 2,
			wyciaganieitemow = 2,
			wyciaganiekasy = 4,
			wyciaganiekasybrudnej = 4,
			kupowaniebroni = 0,
			kupowanieprzedmiotow = 0,
		}
	},
	-- ['wwa'] = {
	-- 	bronie = false,
	-- 	society = 'society_wwa',				
	-- 	szafka = 'wwa',
	-- 	societyblack = 'society_wwa_black',
	-- 	bronie = {
	-- 		-- { name = 'weapon_vintagepistol', price = 120000, unlocked = 1, ammo = 100 },					
	-- 	},
	-- 	itemy = {
	-- 		{ name = 'clip', price = 1000, unlocked = 1, label = 'Magazynek' },
	-- 		{ name = 'blantgigant', price = 600000, unlocked = 1, label = 'Blancior Gigancior' },
	-- 		{ name = 'pistol', price = 100000, unlocked = 1, label = 'Pistolet' }
	-- 	},
	-- 	samochody = {
	-- 		-- {name = 'rmodrs7', label = 'Audi RS7', color = 0, glass = 1, tunning = true, count = 2},	
	-- 	},
	-- 	pex = {
	-- 		samochody = 1,
	-- 		wyciaganiebroni = 2,
	-- 		wyciaganieitemow = 2,
	-- 		wyciaganiekasy = 4,
	-- 		wyciaganiekasybrudnej = 4,
	-- 		kupowaniebroni = 0,
	-- 		kupowanieprzedmiotow = 0,
	-- 	}
	-- },
	['gmd'] = {
		bronie = false,
		society = 'society_gmd',				
		szafka = 'gmd',
		societyblack = 'society_gmd_black',
		bronie = {
			-- { name = 'weapon_vintagepistol', price = 120000, unlocked = 1, ammo = 100 },					
		},
		itemy = {
			{ name = 'clip', price = 1000, unlocked = 1, label = 'Magazynek' },
			{ name = 'blantgigant', price = 600000, unlocked = 1, label = 'Blancior Gigancior' },
			{ name = 'heavypistol', price = 600000, unlocked = 1, label = 'Heavy Pistolet' },
			{ name = 'powiekszonymagazynek', price = 600000, unlocked = 1, label = 'Powiekszony magazynek' },
			{ name = 'pistol', price = 100000, unlocked = 1, label = 'Pistolet' }
		},
		samochody = {
			-- {name = 'rmodrs7', label = 'Audi RS7', color = 0, glass = 1, tunning = true, count = 2},	
		},
		pex = {
			samochody = 1,
			wyciaganiebroni = 2,
			wyciaganieitemow = 2,
			wyciaganiekasy = 4,
			wyciaganiekasybrudnej = 4,
			kupowaniebroni = 0,
			kupowanieprzedmiotow = 0,
		}
	},
	['gkb'] = {
		bronie = false,
		society = 'society_gkb',				
		szafka = 'gkb',
		societyblack = 'society_gkb_black',
		bronie = {
			-- { name = 'weapon_vintagepistol', price = 120000, unlocked = 1, ammo = 100 },					
		},
		itemy = {
			{ name = 'clip', price = 1000, unlocked = 1, label = 'Magazynek' },
			{ name = 'blantgigant', price = 600000, unlocked = 1, label = 'Blancior Gigancior' },
			{ name = 'pistol', price = 100000, unlocked = 1, label = 'Pistolet' }
		},
		samochody = {
			-- {name = 'rmodrs7', label = 'Audi RS7', color = 0, glass = 1, tunning = true, count = 2},	
		},
		pex = {
			samochody = 1,
			wyciaganiebroni = 2,
			wyciaganieitemow = 2,
			wyciaganiekasy = 4,
			wyciaganiekasybrudnej = 4,
			kupowaniebroni = 0,
			kupowanieprzedmiotow = 0,
		}
	},
}
Config.Zones = {
	['biali'] = {
		tako = {
			Armories = {
				vector3(412.1448, 3.708, 84.4243),
				vector3(460.33, 6530.1, 13.7243),
			},	
			Blip = {
				Pos     = { x = 399.9448, y = -4.7608, z = 90.0243 }, 
				Pos2	= { x = 660.9448, y = 6471.7608, z = 31.0243 },
				-- Sprite  = 378,
				Sprite  = 310,
				Display = 4,
				Scale   = 1.2,
				Colour  = 66,
				Name = "W.M.P"
			},
			Vehicles = {
				{
					Spawner      = { x = 346.8369, y = -13.7472, z = 82.843 },
					SpawnPoint   = { x = 345.9369, y = -18.717, z = 82.343 },
					Heading      = 308.54,
				},
				
			},	
			VehicleDeleters = {
				vector3(353.5493,-29.0579, 81.6243),
				
			},
			szafka = {
				vector3(401.0516, -23.65, 91.6242),
				vector3(508.78, 6509.17, 13.62),
			},	
		}

	},
	['brx'] = {
		tako = {
			Armories = {
				vector3(-1520.1028, 110.8851, 49.0774),
				
			},	
			Blip = {
				Pos     = { x = -1550.1448, y = 119.8908, z = 177.0243 }, 
				Sprite  = 378,
				Display = 4,
				Scale   = 1.2,
				Colour  = 45,
				Name = "B.R.X"
			},
			Vehicles = {
				{
					Spawner      = { x = -1541.1487, y = 92.0392, z = 57.0018 },
					SpawnPoint   = { x = -1523.0104, y = 99.0737, z = 55.7665 },
					Heading      = 226.08,
				},
				
			},	
			VehicleDeleters = {
				vector3(-1523.0104, 99.0737, 55.7665),
				
			},
			szafka = {
				vector3(-1503.5386, 102.2175, 54.7082),
			},	
		}

	},
	-- ['ballasi'] = {
	-- 	tako = {
	-- 		Armories = {
	-- 			vector3(110.15, -1980.78, 20.96),
				
	-- 		},	
	-- 		Blip = {
	-- 			Pos     = { x = 119.65, y = -1968.31, z = 21.33 }, 
	-- 			Sprite  = 378,
	-- 			Display = 4,
	-- 			Scale   = 1.2,
	-- 			Colour  = 45,
	-- 			Name = "Ballasi"
	-- 		},
	-- 		Vehicles = {
	-- 			{
	-- 				Spawner      = { x = 105.01, y = -1965.36, z = 20.84 },
	-- 				SpawnPoint   = { x = 102.26, y = -1963.7, z = 20.84 },
	-- 				Heading      = 353.32,
	-- 			},
				
	-- 		},	
	-- 		VehicleDeleters = {
	-- 			vector3(102.26, -1963.7, 20.84),
				
	-- 		},
	-- 		szafka = {
	-- 			vector3(119.65, -1968.31, 21.33),
	-- 		},	
	-- 	}

	-- },
	-- ['ttc'] = {
	-- 	tako = {
	-- 		Armories = {
	-- 			vector3(-1555.66, 409.85, 105.11),
				
	-- 		},	
	-- 		Blip = {
	-- 			Pos     = { x = -1541.39, y = 426.05, z = 109.52 }, 
	-- 			Sprite  = 378,
	-- 			Display = 4,
	-- 			Scale   = 1.2,
	-- 			Colour  = 45,
	-- 			Name = "TTC"
	-- 		},
	-- 		Vehicles = {
	-- 			{
	-- 				Spawner      = { x = -1563.3, y = 423.01, z = 109.59 },
	-- 				SpawnPoint   = { x = -1561.48, y = 426.65, z = 109.59 },
	-- 				Heading      = 272.36,
	-- 			},
				
	-- 		},	
	-- 		VehicleDeleters = {
	-- 			vector3(-1562.29, 431.84, 108.55),
				
	-- 		},
	-- 		szafka = {
	-- 			vector3(-1551.46, 420.93, 109.66),
	-- 		},	
	-- 	}

	-- },
	-- ['dwg'] = {
	-- 	tako = {
	-- 		Armories = {
	-- 			vector3(947.33, -1462.15, 30.4),
				
	-- 		},	
	-- 		Blip = {
	-- 			Pos     = { x = 939.73, y = -1493.49, z = 30.07 }, 
	-- 			Sprite  = 378,
	-- 			Display = 4,
	-- 			Scale   = 1.2,
	-- 			Colour  = 45,
	-- 			Name = "DWG"
	-- 		},
	-- 		Vehicles = {
	-- 			{
	-- 				Spawner      = { x = 943.95, y = -1481.65, z = 30.1 },
	-- 				SpawnPoint   = { x = 940.14, y = -1479.19, z = 30.1 },
	-- 				Heading      = 148.93,
	-- 			},
				
	-- 		},	
	-- 		VehicleDeleters = {
	-- 			vector3(943.33, -1485.72, 30.1),
				
	-- 		},
	-- 		szafka = {
	-- 			vector3(932.57, -1462.69, 33.61),
	-- 		},	
	-- 	}

	-- },
	['ccf'] = {
		tako = {
			Armories = {
				vector3(-60.86, 984.63, 234.58),
				
			},	
			Blip = {
				Pos     = { x = -123.2, y = 999.42, z = 235.74 }, 
				Sprite  = 378,
				Display = 4,
				Scale   = 1.2,
				Colour  = 45,
				Name = "CCF"
			},
			Vehicles = {
				{
					Spawner      = { x = -128.22, y = 1009.01, z = 235.73 },
					SpawnPoint   = { x = -125.84, y = 1002.78, z = 235.73 },
					Heading      = 200.83,
				},
				
			},	
			VehicleDeleters = {
				vector3(-114.67, 1006.59, 235.77),
				
			},
			szafka = {
				vector3(-77.27, 1007.87, 234.56),
			},	
		}

	},
	['cb'] = {
		tako = {
			Armories = {
				vector3(1394.2408, 1159.0918, 113.3836),
				
			},	
			Blip = {
				Pos     = { x = 1400.5487, y = 1135.1035, z = 113.3836 }, 
				Sprite  = 378,
				Display = 4,
				Scale   = 1.2,
				Colour  = 45,
				Name = "Calidos Bastardos"
			},
			Vehicles = {
				{
					Spawner      = { x = 1404.6324, y = 1115.0973, z = 113.8876 },
					SpawnPoint   = { x = 1404.8429, y = 1118.6733, z = 113.8877 },
					Heading      = 240.08,
				},
				
			},	
			VehicleDeleters = {
				vector3(-587.9498, -1637.0483, 18.9517),
				
			},
			szafka = {
				vector3(1401.605, 1132.321, 113.3835),
			},	
		}

	},
	-- ['zieloni'] = {
	-- 	tako = {
	-- 		Armories = {
	-- 			vector3(-136.7544, -1609.5962, 34.0802),
				
	-- 		},	
	-- 		Vehicles = {
	-- 			{
	-- 				Spawner      = { x = -207.5923, y = -1694.6371, z = 33.7696 },
	-- 				SpawnPoint   = { x = -225.5508, y = -1698.7799, z = 33.6896 },
	-- 				Heading      = 226.08,
	-- 			},
				
	-- 		},	
	-- 		VehicleDeleters = {
	-- 			vector3(-214.5508, -1692.7799, 33.6896),
				
	-- 		},
	-- 		szafka = {
	-- 			vector3(-155.4521, -1603.73, 34.0839),
	-- 		},	
	-- 	}

	-- },
	['tbf'] = {
		tako = {
			Armories = {
				vector3(-1794.7446, 412.4312, 116.3606),
				
			},	
			Blip = {
				Pos     = { x = -1805.1448, y = 455.1508, z = 127.0243 }, 
				Sprite  = 378,
				Display = 4,
				Scale   = 1.2,
				Colour  = 61,
				Name = "T.B.F"
			},
			Vehicles = {
				{
					Spawner      = { x = -1787.1953, y = 416.7161, z = 112.9667 },
					SpawnPoint   = { x = -1792.3312, y = 416.5546, z = 113.9019 },
					Heading      = 182.08,
				},
				
			},	
			VehicleDeleters = {
				vector3(-1789.9498, 393.0483, 112.0517),
				
			},
			szafka = {
				vector3(-1801.5453, 430.0941, 128.3606),
			},	
		}

	},
	-- ['wwa'] = {
	-- 	tako = {
	-- 		Armories = {
	-- 			vector3(1018.7446, -2538.4312, 32.0606),
				
	-- 		},	
	-- 		Blip = {
	-- 			Pos     = { x = 1029.1448, y = -2522.1508, z = 27.0243 }, 
	-- 			Sprite  = 378,
	-- 			Display = 4,
	-- 			Scale   = 1.2,
	-- 			Colour  = 32,
	-- 			Name = "W.W.A"
	-- 		},
	-- 		Vehicles = {
	-- 			{
	-- 				Spawner      = { x = 1004.4453, y = -2534.7161, z = 27.4667 },
	-- 				SpawnPoint   = { x = 1008.3312, y = -2536.5546, z = 27.9019 },
	-- 				Heading      = 356.08,
	-- 			},
				
	-- 		},	
	-- 		VehicleDeleters = {
	-- 			vector3(-587.9498, -1637.0483, 18.9517),
				
	-- 		},
	-- 		szafka = {
	-- 			vector3(1018.3453, -2546.0941, 32.3606),
	-- 		},	
	-- 	}

	-- },
	['gmd'] = {
		tako = {
			Armories = {
				vector3(-846.3453, -40.0941, 38.7606),
				
			},	
			Blip = {
				Pos     = { x = -849.1448, y = -25.3908, z = 27.0243 }, 
				Sprite  = 378,
				Display = 4,
				Scale   = 1.2,
				Colour  = 47,
				Name = "G.M.D"
			},
			Vehicles = {
				{
					Spawner      = { x = -884.3753, y = -51.661, z = 37.1667 },
					SpawnPoint   = { x = -882.3312, y = -55.5546, z = 37.1 },
					Heading      = 297.54,
				},
				
			},	
			VehicleDeleters = {
				vector3(-881.9498, -47.0483, 37.4517),
				
			},
			szafka = {
				vector3(-857.1053, -39.3541, 38.8606),
			},	
		}

	},
	['gkb'] = {
		tako = {
			Armories = {
				vector3(-18.21, -1432.56, 30.1),
				
			},	
			Blip = {
				Pos     = { x = -14.2, y = -1443.74, z = 30.94 }, 
				Sprite  = 378,
				Display = 4,
				Scale   = 1.2,
				Colour  = 47,
				Name = "G.K.B"
			},
			Vehicles = {
				{
					Spawner      = { x = -24.13, y = -1430.4, z = 29.65 },
					SpawnPoint   = { x = -24.4, y = -1436.65, z = 29.65 },
					Heading      = 177.37,
				},
				
			},	
			VehicleDeleters = {
				vector3(-25.56, -1427.95, 29.66),
				
			},
			szafka = {
				vector3(-17.98, -1439.03, 30.1),
			},	
		}

	},
}

