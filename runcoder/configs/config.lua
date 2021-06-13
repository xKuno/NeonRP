APIAC = {}
--//Basic Security\\--
APIAC.Spectate = true -- Detects a user that is spectating someone else without permissions
APIAC.AntiArmor = true -- ANTI ARMOR ABOVE X VALUE
APIAC.ArmorValue = 90 -- Set Value (0-100)
APIAC.Logger = true -- INSERT KEY LOG 
APIAC.AntiTeleport = false -- Detecting player which tried to teleport to example. Waypoint or to someone else. (No it dont detecting admin.)
--//Resource Injection Protection\\-- --ANTI RESTART BOOLS (DO NOT RESTART SCRIPTS IF YOU ENALBED THESE!!!)
APIAC.AntiResourceInjection = false -- This script will check if a player tries to start/stop/restart script (do not restart scripts if this is enabled)
--//Nui Devtools Protection\\-
APIAC.NuiDevtoolsProtection = true -- nui devtools security if someone opens he will get ban
--//Vehicle options\\--
APIAC.AntiVehicleWeaponSpawn = true -- This checking what player type to spawn. 
APIAC.AntiVehicleSpeedModifier = false -- This checking car speed and if someone using boost torque or boost speed then u will get log ;)
APIAC.AntiVehicleHashChanger = true -- Detects if a player tried to change his vehicle hash model
--//Ammo Options\\--
APIAC.AntiInfinityAmmo = false
APIAC.AmmoChecker = true
APIAC.MaxAmmo = 300 -- default value, if you got enlarged magazine then set to 340
--//Anti Attach Ped\\--
APIAC.AntiAttachPedToPlayer = true
--//ADMIN MENU KEY\\--  default: numpad -
APIAC.AdminMenu = true
APIAC.Key = 315 --key from: https://docs.fivem.net/docs/game-references/controls/
--//Anti Model Changer\\--
APIAC.AntiModelChanger = true
APIAC.AntiModelChangerTable = { -- Peds, animals, etc.
	"s_m_y_swat_01",
	"a_m_y_mexthug_01", 
    "a_c_cat_01", 
    "a_c_boar", 
    "a_c_sharkhammer", 
    "a_c_coyote", 
    "a_c_chimp",  
    "a_c_cow", 
    "a_c_deer", 
    "a_c_dolphin", 
    "a_c_fish", 
    "a_c_hen", 
    "a_c_humpback", 
    "a_c_killerwhale", 
    "a_c_mtlion",
    "a_c_rabbit_01",  
    "a_c_rhesus",  
    "a_c_sharktiger", 
	"u_m_y_zombie_01"
}

--//Blacklisted Weapons\\-- LIST OF BLOCKED WEAPONS (NO BAN)
APIAC.BlacklistedWeaponsTable = { -- U can add/delete some weapons if u want!
	"WEAPON_SAWNOFFSHOTGUN",
	"WEAPON_BULLPUPSHOTGUN",
	"WEAPON_GRENADELAUNCHER",
	"WEAPON_GRENADELAUNCHER_SMOKE",
	"WEAPON_RPG",
	"WEAPON_STINGER",
	"WEAPON_MINIGUN",
	"WEAPON_GRENADE",
	"WEAPON_FIREWORK",
	"WEAPON_BALL",
	"WEAPON_BOTTLE",
	"WEAPON_HEAVYSHOTGUN",
	"WEAPON_GARBAGEBAG",
	"WEAPON_RAILGUN",
	"WEAPON_RAILPISTOL",
	"WEAPON_RAYPISTOL",
	"WEAPON_RAYCARBINE",
	"WEAPON_RAYMINIGUN",
	"WEAPON_DIGISCANNER",
	"WEAPON_SPECIALCARBINE_MK2",
	"WEAPON_BULLPUPRIFLE_MK2",
	"WEAPON_PUMPSHOTGUN_MK2",
	"WEAPON_MARKSMANRIFLE_MK2",
	"WEAPON_COMPACTLAUNCHER",
	"WEAPON_REVOLVER_MK2",
	"WEAPON_HOMINGLAUNCHER",
	"WEAPON_SNOWBALL",
	"WEAPON_SMG_MK2"
}

--//Anti Blacklisted cars\\--
APIAC.CarsBL = { -- add more if u want
	"RHINO",
	"HYDRA",
	"vigilante",
	"hydra",
	"buzzard",
	"deluxo",
	"avenger",
	"akula",
	"apc",
	"barrage",
	"caracara",
	"cargobob",
	"chernobog",
	"jet",
	"airjet",
	"hunter",
	"insurgent",
	"starling",
	"lazer",
	"bombushka",
	"savage",
	"rhino",
	"oppressor",
	"oppressor2",
	"khanjali"
}

-------------------------------------------------------------------------------
--------------------- ___  ______ _____       ___    _____ --------------------
---------------------/ _ \ | ___ \_   _|     / _ \  /  __ \ -------------------
--------------------/ /_\ \| |_/ / | |______/ /_\ \ | /  \/--------------------
--------------------|  _  ||  __/  | |______|  _  | | |    --------------------
--------------------| | | || |    _| |_     | | | | | \__/\--------------------
--------------------\_| |_/\_|    \___/     \_| |_/  \____/--------------------
-------------------------------------------------------------------------------
