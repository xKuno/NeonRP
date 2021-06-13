Config                = {}
Config.DrawDistance   = 10
Config.Size           = { x = 1.0, y = 1.0, z = 1.0 }
Config.Color          = { r = 149, g = 66, b = 244 }
Config.Type           = 29
Config.Locale         = 'pl'
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 0.5 }
Config.Marker                = { x = 1.5, y = 1.5, z = 0.5 }
Config.MarkerColor                = { r = 0, g = 130, b = 204 }
Config.Marker 			 = {Type = 27, r = 0, g = 127, b = 22}
Config.EnableLicense  = true -- only turn this on if you are using esx_license

Config.LicenseEnable  = true -- only turn this on if you are using esx_license
Config.LicensePrice   = 0

Config.Prices = {
	[1] = 100000,
	[2] = 25000,
	[3] = 25000,
	[4] = 20000,
	[5] = 3000,
	[6] = 10000,
	[7] = 15000,
}

Config.BlackPrices = {
	[1] = 150000,
	[3] = 100000,
	[5] = 4000,
}

-- Config.BlackShop = { 
-- 	{x = 2533.31, y = 3893.4, z = 40.03}
-- }

Config.Zones = {

	GunShop = {
		legal = true,
		Items = {},
		Pos   = {
			{ x = -662.180,   y = -934.961,   z = 21.829 },
            { x = 810.25,     y = -2157.60,   z = 29.62 },
            { x = 1693.44,    y = 3760.16,    z = 32.71 },
            { x = -330.24,    y = 6083.88,    z = 31.45 },
            { x = 252.63,     y = -50.00,     z = 69.94 },
            { x = 22.09,      y = -1107.28,   z = 29.80 },
            { x = 2567.69,    y = 294.38,     z = 108.73 },
            { x = -1117.58,   y = 2698.61,    z = 18.55 },
            { x = 842.44,     y = -1033.42,   z = 28.19 },
			{ x = -1306.239,   y = -394.018,  z = 36.695 },
		}
	},
	BlackWeashop = {
		Legal = false,
		Items = {},
		Pos = {
			{x = 2888.8174, y = 1513.0916, z = 24.9171}
		}
	}
}
