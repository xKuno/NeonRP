Config = {}

Config.Locale       				= 'en' 

Config.ServiceExtensionOnEscape		= 8

Config.ServiceLocation 				= {x =  170.43, y = -990.7, z = 30.09}

Config.ReleaseLocation				= {x = 427.33, y = -979.51, z = 30.2}

Config.ServiceLocations = {
	{ type = "cleaning", coords = vector3(170.0, -1006.0, 29.34) },
	{ type = "cleaning", coords = vector3(177.0, -1007.94, 29.33) },
	{ type = "cleaning", coords = vector3(181.58, -1009.46, 29.34) },
	{ type = "cleaning", coords = vector3(189.33, -1009.48, 29.34) },
	{ type = "cleaning", coords = vector3(195.31, -1016.0, 29.34) },
	{ type = "cleaning", coords = vector3(169.97, -1001.29, 29.34) },
	{ type = "cleaning", coords = vector3(164.74, -1008.0, 29.43) },
	{ type = "cleaning", coords = vector3(163.28, -1000.55, 29.35) },
	{ type = "gardening", coords = vector3(181.38, -1000.05, 29.29) },
	{ type = "gardening", coords = vector3(188.43, -1000.38, 29.29) },
	{ type = "gardening", coords = vector3(194.81, -1002.0, 29.29) },
	{ type = "gardening", coords = vector3(198.97, -1006.85, 29.29) },
	{ type = "gardening", coords = vector3(201.47, -1004.37, 29.29) }
}

Config.Uniforms = {
	prison_wear = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1']  = 144, ['torso_2']  = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms']     = 69, ['pants_1']  = 70,
			['pants_2']  = 2,   ['shoes_1']  = 19,
			['shoes_2']  = 0,  ['chain_1']  = 0,
			['chain_2']  = 0
		},
		female = {
			['tshirt_1'] = 14,   ['tshirt_2'] = 0,
			['torso_1']  = 146,  ['torso_2']  = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms']     = 73,  ['pants_1'] = 71,
			['pants_2']  = 0,  ['shoes_1']  = 22,
			['shoes_2']  = 4,   ['chain_1']  = 0,
			['chain_2']  = 0
		}
	}
}
