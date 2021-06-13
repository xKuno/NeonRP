Config                            = {}
Config.DrawDistance               = 100.0
Config.MaxInService               = -1
Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false
Config.NPCSpawnDistance           = 500.0
Config.NPCNextToDistance          = 25.0
Config.NPCJobEarnings             = { min = 500, max = 1500 }
Config.Locale                     = 'pl'

Config.Zones = {

	MecanoActions = {
		Pos   =	{ x = 898.35, y = -899.3, z = 27.2 },		
		Size  = { x = 1.5, y = 1.5, z = 1.5 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 31,
	},

	VehicleSpawnPoint = {
		Pos   = { x = 891.24, y = -891.65, z = 26.82 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = -1,
	},

	VehicleDeleter = {
		Pos   = { x = 892.11, y = -886.39, z = 26.85 },
		Size  = { x = 2.0, y = 2.0, z = 2.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 24,
	}
}