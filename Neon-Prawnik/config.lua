Config                            = {}

Config.DrawDistance               = 10.0


Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false

Config.Locale                     = 'pl'

Config.AuthorizedVehicles = {

	{
		model = 'buffalo2',
		label = 'Buffalo Sport'
	}
}

Config.essa = {
	essa = {
		Pos   = {x = -113.01, y = -605.63, z = 36.28}
	}
}

Config.Zones = {

	VehicleSpawner = {
		Pos   = {x = -114.22, y = -596.14, z = 35.56},
		Size  = {x = 1.0, y = 1.0, z = 1.0},
		Color = {r = 33, g = 103, b = 233},
		Type  = 36, Rotate = true
	},

	VehicleSpawnPoint = {
		Pos     = {x = -101.64, y = -600.86, z = 35.0},
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Type    = -1, Rotate = false,
		Heading = 162.02
	},

	VehicleDeleter = {
		Pos   = {x = -114.64, y = -631.86, z = 35.0},
		Size  = {x = 3.0, y = 3.0, z = 0.25},
		Color = {r = 255, g = 0, b = 0},
		Type  = 1, Rotate = false
	},

	avocatActions = {
		Pos   = {x = -139.08, y = -634.9, z = 168.82},
		Size  = {x = 1.0, y = 1.0, z = 1.0},
		Color = {r = 33, g = 103, b = 233},
		Type  = 21, Rotate = true
	},
	Cloakroom = {
		Pos     = {x = -127.73, y = -633.5, z = 168.82},
		Size    = {x = 1.0, y = 1.0, z = 1.0},
		Color   = {r = 204, g = 204, b = 0},
		Type    = 21, Rotate = true
	}
}
