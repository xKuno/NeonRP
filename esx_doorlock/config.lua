Config = {}
Config.ShowUnlockedText = true

Config.DoorList = {

------------------------------------------
--	COMMUNITY MISSION ROW PD
--	https://www.gta5-mods.com/maps/community-mission-row-pd
------------------------------------------
    
    --
	-- Mission Row First Floor
	--

	{
		textCoords = vector3(434.7, -982.0, 31.5),
		authorizedJobs = {'police'},
		locked = false,
		maxDistance = 2.5,
		doors = {
			{objHash = GetHashKey('v_ilev_ph_door01'), objHeading = 270.0, objCoords = vector3(434.7, -980.6, 30.8)},
			{objHash = GetHashKey('v_ilev_ph_door002'), objHeading = 270.0, objCoords = vector3(434.7, -983.2, 30.8)}
		}
	},

	-- To locker room & roof
	{
		objHash = GetHashKey('v_ilev_ph_gendoor004'),
		objHeading = 90.0,
		objCoords = vector3(449.6, -986.4, 30.6),
		textCoords = vector3(450.1, -986.3, 31.7),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 2.25
	},

	-- Rooftop
	{
		objHash = GetHashKey('v_ilev_gtdoor02'),
		objHeading = 90.0,
		objCoords = vector3(464.3, -984.6, 43.8),
		textCoords = vector3(464.3, -983.9, 43.7),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 2.25
	},

	-- Hallway to roof
	{
		objHash = GetHashKey('v_ilev_arm_secdoor'),
		objHeading = 90.0,
		objCoords = vector3(461.2, -985.3, 30.8),
		textCoords = vector3(461.5, -986.0, 31.5),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 2.25
	},

	-- Armory
	{
		objHash = GetHashKey('v_ilev_arm_secdoor'),
		objHeading = 270.0,
		objCoords = vector3(452.6, -982.7, 30.6),
		textCoords = vector3(453.0, -982.4, 30.7),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 2.25
	},

	-- Captain Office
	{
		objHash = GetHashKey('v_ilev_ph_gendoor002'),
		objHeading = 180.0,
		objCoords = vector3(447.2, -980.6, 30.6),
		textCoords = vector3(447.3, -980.3, 30.7),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 2.25
	},

	-- To downstairs (double doors)
	{
		authorizedJobs = { 'police' },
		locked = true,
		maxDistance = 2.5,
		doors = {
			{objHash = 185711165, objHeading = 180.0, objCoords = vector3(443.4078, -989.4454, 30.83931)},
			{objHash = 185711165, objHeading = 0.0, objCoords = vector3(446.008, -989.4454, 30.83931)}
		}
	},

	--
	-- Mission Row Cells
	--

	-- Main Cells
	{
		objHash = GetHashKey('v_ilev_ph_cellgate'),
		objHeading = 0.0,
		objCoords = vector3(463.8, -992.6, 24.9),
		textCoords = vector3(463.3, -992.6, 25.1),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 2.0,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},

	-- Cell 1
	{
		objHash = GetHashKey('v_ilev_ph_cellgate'),
		objHeading = 270.0,
		objCoords = vector3(462.3, -993.6, 24.9),
		textCoords = vector3(461.8, -993.3, 25.0),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 2.0,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},

	-- Cell 2
	{
		objHash = GetHashKey('v_ilev_ph_cellgate'),
		objHeading = 90.0,
		objCoords = vector3(462.3, -998.1, 24.9),
		textCoords = vector3(461.8, -998.8, 25.0),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 2.0,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},

	-- Cell 3
	{
		objHash = GetHashKey('v_ilev_ph_cellgate'),
		objHeading = 90.0,
		objCoords = vector3(462.7, -1001.9, 24.9),
		textCoords = vector3(461.8, -1002.4, 25.0),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 2.0,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},
	-- Cell 4
	{
		objHash = GetHashKey('v_ilev_ph_cellgate'),
		objHeading = 179.1,
		objCoords = vector3(467.4, -999.5, 25.0),
		textCoords = vector3(468.4, -999.5, 25.0),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 2.0,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},
	-- Cell 5
	{
		objHash = GetHashKey('v_ilev_ph_cellgate'),
		objHeading = 179.1,
		objCoords = vector3(471.0, -999.5, 25.0),
		textCoords = vector3(472.2, -999.5, 25.0),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 2.0,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},
	-- Cell 6
	{
		objHash = GetHashKey('v_ilev_ph_cellgate'),
		objHeading = 179.1,
		objCoords = vector3(475.2, -1007.7, 24.4),
		textCoords = vector3(476.2, -1007.7, 24.4),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 2.0,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},
	-- Cell 7
	{
		objHash = GetHashKey('v_ilev_ph_cellgate'),
		objHeading = 179.1,
		objCoords = vector3(478.8, -1007.7, 24.4),
		textCoords = vector3(479.8, -1007.7, 24.4),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 2.0,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},
	-- To Back
	{
		objHash = GetHashKey('v_ilev_gtdoor'),
		objHeading = 0.0,
		objCoords = vector3(463.4, -1003.5, 25.0),
		textCoords = vector3(464.0, -1003.5, 25.5),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 2.0,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},

	--
	-- Mission Row Back
	--

	-- Back (double doors)
	{
		textCoords = vector3(468.6, -1014.4, 27.1),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 4,
		doors = {
			{objHash = GetHashKey('v_ilev_rc_door2'), objHeading = 0.0, objCoords  = vector3(467.3, -1014.4, 26.5)},
			{objHash = GetHashKey('v_ilev_rc_door2'), objHeading = 180.0, objCoords  = vector3(469.9, -1014.4, 26.5)}
		}
	},

	-- Back Gate
	{
		objHash = GetHashKey('hei_prop_station_gate'),
		objHeading = 90.0,
		objCoords = vector3(488.8, -1017.2, 27.1),
		textCoords = vector3(488.8, -1020.2, 30.0),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 15,
		size = 2
	},

	--Vinewoodpd 
	--Glowne wejscie
	{
		textCoords = vector3(637.5,2.1,82.8),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 4,
		doors = {
			{objHash = GetHashKey('int_vinewood_police_maindoor'), objHeading = 249.6, objCoords  = vector3(637.1,0.7,83.0)},
			{objHash = GetHashKey('int_vinewood_police_maindoor'), objHeading = 71.8, objCoords  = vector3(638.1,3.3,83.0)}
		}
	},
	--wejscie u gory 
	{
		textCoords = vector3(619.6,16.6,88.0),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 4,
		doors = {
			{objHash = GetHashKey('int_vinewood_police_door_l'), objHeading = 158.9, objCoords  = vector3(621.1,16.0,88.6)},
			{objHash = GetHashKey('int_vinewood_police_door_l'), objHeading = 340.3, objCoords  = vector3(618.1,17.1,88.6)}
		}
	},
	--wejscie do szatni
	{
		objHash = GetHashKey('v_ilev_roc_door2'),
		objHeading = 70.0,
		objCoords = vector3(619.5,3.7,82.9),
		textCoords = vector3(619.5,4.5,82.9),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 2
	},
	--wejscie do cell
	{
		objHash = GetHashKey('v_ilev_ph_cellgate'),
		objHeading = 340.5,
		objCoords = vector3(614.6,-2.3,82.9),
		textCoords = vector3(613.6,-2.3,82.9),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 2.25,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},
	--Cell 1
	{
		objHash = GetHashKey('v_ilev_ph_cellgate'),
		objHeading = 163.5,
		objCoords = vector3(611.9,-11.2,82.9),
		textCoords = vector3(612.9,-11.2,82.9),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 2.25,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},
	--Cell 2
	{
		objHash = GetHashKey('v_ilev_ph_cellgate'),
		objHeading = 164.0,
		objCoords = vector3(608.1,-9.8,82.9),
		textCoords = vector3(609.1,-10.2,82.9),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 2.25,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},
	--Cell 3
	{
		objHash = GetHashKey('v_ilev_ph_cellgate'),
		objHeading = 163.5,
		objCoords = vector3(604.2,-8.4,82.9),
		textCoords = vector3(605.2,-8.9,82.9),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 2.25,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},
	--Cell 4
	{
		objHash = GetHashKey('v_ilev_ph_cellgate'),
		objHeading = 163.5,
		objCoords = vector3(600.4,-7.0,82.9),
		textCoords = vector3(601.4,-7.5,82.9),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 2.25,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},
	{
		objHash = GetHashKey('v_ilev_ph_gendoor002'),
		objHeading = 339.4,
		objCoords = vector3(620.0,-4.5,82.9),
		textCoords = vector3(619.0,-4.1,82.9),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 2.25,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},
	--szpital eclips
	--sala operacyjna 1
	{
		textCoords = vector3(-693.2,326.8,83.3),
		authorizedJobs = {'ambulance'},
		locked = true,
		maxDistance = 4,
		doors = {
			{objHash = GetHashKey('gabz_pillbox_doubledoor_l'), objHeading = 85.0, objCoords  = vector3(-693.2,325.5,83.2)},
			{objHash = GetHashKey('gabz_pillbox_doubledoor_r'), objHeading = 85.0, objCoords  = vector3(-693.0,328.1,83.2)}
		}
	},
	--sala operacyjna 2
	{
		textCoords = vector3(-692.6,333.0,83.3),
		authorizedJobs = {'ambulance'},
		locked = true,
		maxDistance = 4,
		doors = {
			{objHash = GetHashKey('gabz_pillbox_doubledoor_l'), objHeading = 85.0, objCoords  = vector3(-692.6,331.7,83.2)},
			{objHash = GetHashKey('gabz_pillbox_doubledoor_r'), objHeading = 85.0, objCoords  = vector3(-692.4,334.3,83.2)}
		}
	},
	--sala operacyjna 3
	{
		textCoords = vector3(-692.1,338.8,83.3),
		authorizedJobs = {'ambulance'},
		locked = true,
		maxDistance = 4,
		doors = {
			{objHash = GetHashKey('gabz_pillbox_doubledoor_l'), objHeading = 85.0, objCoords  = vector3(-692.1,337.4,83.2)},
			{objHash = GetHashKey('gabz_pillbox_doubledoor_r'), objHeading = 85.0, objCoords  = vector3(-692.9,340.0,83.2)}
		}
	},
	--rtg 1
	{
		objHash = GetHashKey('gabz_pillbox_singledoor'),
		objHeading = 85.0,
		objCoords = vector3(-690.9,351.1,83.2),
		textCoords = vector3(-690.9,352.1,83.2),
		authorizedJobs = {'ambulance'},
		locked = true,
		maxDistance = 2.25
	},
	--rtg 2
	{
		objHash = GetHashKey('gabz_pillbox_singledoor'),
		objHeading = 85.0,
		objCoords = vector3(-690.0,362.4,83.2),
		textCoords = vector3(-690.0,363.4,83.2),
		authorizedJobs = {'ambulance'},
		locked = true,
		maxDistance = 2.25
	},
	--szatnia
	{
		objHash = GetHashKey('gabz_pillbox_singledoor'),
		objHeading = 265.0,
		objCoords = vector3(-666.9,329.6,83.2),
		textCoords = vector3(-666.9,328.6,83.2),
		authorizedJobs = {'ambulance'},
		locked = true,
		maxDistance = 2.25
	},
	--Dom RUdego 
	{
		objHash = GetHashKey('v_ilev_fh_frontdoor'),
		objHeading = 150.0,
		objCoords = vector3(7.5,539.5,176.1),
		textCoords = vector3(8.5,539.0,176.1),
		authorizedJobs = {'ambulance'},
		locked = true,
		maxDistance = 2.25
	},
	--Dom Franklin (Mateo)
	{
		objHash = GetHashKey('v_ilev_fh_frontdoor'),
		objHeading = 150.0,
		objCoords = vector3(7.5,539.5,176.1),
		textCoords = vector3(8.5,539.0,176.1),
		authorizedJobs = {'ambulance'},
		locked = true,
		maxDistance = 2.25
	},
	--Paleto szatnai 
	{
        objHash = GetHashKey('v_ilev_rc_door2'),
        objHeading = 315.2,
        objCoords = vector3(-450.7, 6016.3, 31.8),
        textCoords = vector3(-450.5, 6015.5, 31.8),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2
    },
	--wyjscie tyl 1 
	{
        objHash = GetHashKey('v_ilev_rc_door2'),
        objHeading = 135.1,
        objCoords = vector3(-450.9664, 6006.086, 31.99004),
        textCoords = vector3(-451.7, 6007.0, 31.99004),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2
    },
	--wyjscie tyl 2 
	{
        objHash = GetHashKey('v_ilev_rc_door2'),
        objHeading = 314.7,
        objCoords = vector3(-447.2363, 6002.317, 31.84003),
        textCoords = vector3(-446.3, 6001.317, 31.84003),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2
    },
	--wejscie do zbrojowni 
	{
        textCoords = vector3(-441.88, 6011.74, 31.72),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2,
        doors = {
            {objHash = GetHashKey('v_ilev_rc_door2'), objHeading = 223.5, objCoords = vector3(-441.0185, 6012.795, 31.86523)},
            {objHash = GetHashKey('v_ilev_rc_door2'), objHeading = 44.5, objCoords = vector3(-442.8578, 6010.958, 31.86523)}
        }
    },
	--Wejscie na tyl
	{
        textCoords = vector3(-448.67, 6007.5, 31.72),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2,
        doors = {
            {objHash = GetHashKey('v_ilev_rc_door2'), objHeading = 135.0, objCoords = vector3(-447.7283, 6006.702, 31.86523)},
            {objHash = GetHashKey('v_ilev_rc_door2'), objHeading = 315.0, objCoords = vector3(-449.5656, 6008.538, 31.86523)}
        }
    },
     --cell
    {
        objHash = GetHashKey('v_ilev_ph_cellgate1'),
        objHeading = 42.4,
        objCoords = vector3(-444.8, 6011.5, 27.9),
        textCoords = vector3(-444.8, 6011.5, 27.9),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2
    },
	--vespucci
	{
        textCoords = vector3(-1057.87, -839.99, 5.11),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2,
        doors = {
            {objHash = GetHashKey('v_ilev_rc_door2'), objHeading = 37.0, objCoords = vector3(-1058.82, -840.68, 5.30)},
            {objHash = GetHashKey('v_ilev_rc_door2'), objHeading = -142.0, objCoords = vector3(-1056.75, -839.11, 5.30)}
        }
    },
	--cele
	 {
        objHash = GetHashKey('v_ilev_ph_cellgate'),
        objHeading = -145.0,
        objCoords = vector3(-1073.58056640625, -827.4854125976562, 5.630563735961914),
        textCoords = vector3(-1072.91, -827.01, 5.48),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2
    },
	 {
        objHash = GetHashKey('v_ilev_ph_cellgate'),
        objHeading = -143.0,
        objCoords = vector3(-1087.75, -829.87, 5.63),
        textCoords = vector3(-1087.11, -829.65, 5.48),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2
    },
	-- cela 1 prawa
	{
        objHash = GetHashKey('v_ilev_ph_cellgate'),
        objHeading = -52.0,
        objCoords = vector3(-1088.795, -830.25, 5.63),
        textCoords = vector3(-1089.28, -829.49, 5.48),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2
    },
		-- cela 2 prawa
	{
        objHash = GetHashKey('v_ilev_ph_cellgate'),
        objHeading = -52.0,
        objCoords = vector3(-1091.14, -827.00, 5.63),
        textCoords = vector3(-1091.61, -826.31, 5.48),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2
    },
			-- cela 3 prawa
	{
        objHash = GetHashKey('v_ilev_ph_cellgate'),
        objHeading = -52.0,
        objCoords = vector3(-1093.55, -823.85, 5.63),
        textCoords = vector3(-1093.85, -823.2, 5.48),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2
    },
			-- cela 4 prawa
	{
        objHash = GetHashKey('v_ilev_ph_cellgate'),
        objHeading = -52.0,
        objCoords = vector3(-1095.95, -820.72, 5.63),
        textCoords = vector3(-1096.11, -820.92, 5.48),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2
    },
	      -- cela 1 lewa
	{
        objHash = GetHashKey('v_ilev_ph_cellgate'),
        objHeading = -52.0,
        objCoords = vector3(-1085.82, -827.83, 5.63),
        textCoords = vector3(-1086.36, -827.4, 5.48),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2
    },	  
	      -- cela 2 lewa
	{
        objHash = GetHashKey('v_ilev_ph_cellgate'),
        objHeading = -52.0,
        objCoords = vector3(-1088.23, -824.77, 5.63),
        textCoords = vector3(-1088.7, -824.29, 5.48),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2
    },	
              -- cela 3 lewa
    {
        objHash = GetHashKey('v_ilev_ph_cellgate'),
        objHeading = -52.0,
        objCoords = vector3(-1090.64, -821.62, 5.63),
        textCoords = vector3(-1091.14, -820.96, 5.48),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2
	},
    {
        textCoords = vector3(-1093.42, -817.32, 5.48),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2,
        doors = {
            {objHash = GetHashKey('v_ilev_rc_door2'), objHeading = -53.0, objCoords = vector3(-1094.09, -816.21, 5.63)},
            {objHash = GetHashKey('v_ilev_rc_door2'), objHeading =  128.0, objCoords = vector3(-1092.51, -818.27, 5.63)}
        }
    },
	{
        objHash = GetHashKey('v_ilev_rc_door2'),
        objHeading = -52.0,
        objCoords = vector3(-1078.52, -813.56, 5.63),
        textCoords = vector3(-1078.03, -814.26, 5.48),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2
	},
	{
        objHash = GetHashKey('v_ilev_rc_door2'),
        objHeading = -52.0,
        objCoords = vector3(-1082.15, -816.34, 5.63),
        textCoords = vector3(-1081.54, -816.58, 5.48),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2
	},
	{
        objHash = GetHashKey('v_ilev_rc_door2'),
        objHeading = 35.0,
        objCoords = vector3(-1108.87, -842.73, 13.83),
        textCoords = vector3(-1108.39, -842.06, 13.68),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2
	},
	{
        textCoords = vector3(-1111.92, -848.2, 13.51),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2.5,
        doors = {
            {objHash = GetHashKey('v_ilev_rc_door2'), objHeading = 126.0, objCoords = vector3(-1112.86, -846.85, 13.81)},
            {objHash = GetHashKey('v_ilev_rc_door2'), objHeading = -52.0, objCoords = vector3(-1111.19, -849.02, 13.81)}
        }
	},
	{
        textCoords = vector3(-1094.51, -834.84, 14.28),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2.5,
        doors = {
            {objHash = GetHashKey('v_ilev_rc_door2'), objHeading = 216.0, objCoords = vector3(-1093.42, -834.21, 14.43)},
            {objHash = GetHashKey('v_ilev_rc_door2'), objHeading = 38.0, objCoords = vector3(-1095.49, -835.79, 14.43)}
        }
	},
	{
        textCoords = vector3(-1075.27, -823.28, 14.88),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2.5,
        doors = {
            {objHash = GetHashKey('v_ilev_rc_door2'), objHeading = 36.0, objCoords = vector3(-1076.40, -824.14, 15.03)},
            {objHash = GetHashKey('v_ilev_rc_door2'), objHeading = -142.0, objCoords = vector3(-1074.33, -822.57, 15.03)}
        }
	},
	{
        objHash = GetHashKey('v_ilev_rc_door2'),
        objHeading = -143.0,
        objCoords = vector3(-1100.79, -826.73, 14.43),
        textCoords = vector3(-1101.37, -827.19, 14.28),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2
	},
	{
        textCoords = vector3(-1102.22, -846.71, 13.85),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2.5,
        doors = {
            {objHash = GetHashKey('v_ilev_rc_door2'), objHeading = 216.0, objCoords = vector3(-1100.96, -846.15, 13.85)},
            {objHash = GetHashKey('v_ilev_rc_door2'), objHeading = 37.0, objCoords = vector3(-1103.02, -847.72, 13.85)}
        }
	},
	{
        objHash = GetHashKey('xm_prop_iaa_base_door_01'),
        objHeading = 127.0,
        objCoords = vector3(-1090.72, -841.96, 14.49),
        textCoords = vector3(-1091.34, -841.53, 14.28),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2
	},  
    {
        textCoords = vector3(-1112.3, -847.99, 13.44),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2.5,
        doors = {
            {objHash = GetHashKey('vesp_glav_door'), objHeading = 308.0, objCoords = vector3(-1111.19, -849.02, 13.81)},
            {objHash = GetHashKey('vesp_glav_door'), objHeading = 132.0, objCoords = vector3(-1112.86, -846.85, 13.81)}
        }
	},
	{
        objHash = GetHashKey('xm_prop_iaa_base_door_01'),
        objHeading = 127.0,
        objCoords = vector3(-1090.72, -841.96, 18.36),
        textCoords = vector3(-1091.01, -841.07, 18.36),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2
	},  
	{
        objHash = GetHashKey('xm_prop_iaa_base_door_01'),
        objHeading = 128.0,
        objCoords = vector3(-1090.71, -841.96, 22.50),
        textCoords = vector3(-1091.11, -841.4, 22.36),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2
	},  
	{
        objHash = GetHashKey('xm_prop_iaa_base_door_01'),
        objHeading = 128.0,
        objCoords = vector3(-1090.71, -841.96, 26.50),
        textCoords = vector3(-1091.05, -841.51, 26.36),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2
	}, 
	{
        objHash = GetHashKey('xm_prop_iaa_base_door_01'),
        objHeading = 128.0,
        objCoords = vector3(-1090.71, -841.96, 30.50),
        textCoords = vector3(-1091.18, -841.47, 30.36),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2
	}, 
	{
        objHash = GetHashKey('xm_prop_iaa_base_door_01'),
        objHeading = 128.0,
        objCoords = vector3(-1090.74, -841.98, 34.50),
        textCoords = vector3(-1091.1, -841.57, 34.36),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2
	}, 
	{
        objHash = GetHashKey('xm_prop_iaa_base_door_01'),
        objHeading = 128.0,
        objCoords = vector3(-1089.59, -841.56, 37.91),
        textCoords = vector3(-1090.0, -841.04, 37.76),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2
	}, 
	{
        objHash = GetHashKey('xm_prop_iaa_base_door_01'),
        objHeading = 128.0,
        objCoords = vector3(-1090.72, -841.96, 10.43),
        textCoords = vector3(-1090.93, -841.34, 10.28),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2
	}, 
	{
        objHash = GetHashKey('xm_prop_iaa_base_door_01'),
        objHeading = 127.0,
        objCoords = vector3(-1092.23, -843.13, 5.03),
        textCoords = vector3(-1092.65, -842.8, 4.88),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2 
	}, 
	{
        objHash = GetHashKey('v_ilev_rc_door2'),
        objHeading = 207.0,
        objCoords = vector3(1857.25, 3690.29, 34.41),
        textCoords = vector3(1856.81, 3690.06, 34.27),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2  
	}, 
	{
        textCoords = vector3(1850.39, 3682.9, 34.27),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2.5,
        doors = {
            {objHash = GetHashKey('v_ilev_rc_door2'), objHeading = 120.0, objCoords = vector3(1851.28, 3681.87, 34.41)},
            {objHash = GetHashKey('v_ilev_rc_door2'), objHeading = 299.0, objCoords = vector3(1849.98, 3684.11, 34.41)}
        }
	},
	{
        textCoords = vector3(1848.22, 3690.54, 34.27),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2.5,
        doors = {
            {objHash = GetHashKey('v_ilev_rc_door2'), objHeading = 28.0, objCoords = vector3(1847.13, 3689.94, 34.41)},
            {objHash = GetHashKey('v_ilev_rc_door2'), objHeading = 209.0, objCoords = vector3(1849.4, 3691.20, 34.41)}
        }
	},
	{
        objHash = GetHashKey('v_ilev_ph_cellgate'),
        objHeading = 300.0,
        objCoords = vector3(1858.99, 3694.93, 30.40),
        textCoords = vector3(1858.69, 3695.63, 30.26),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2  
	}, 
	{
        objHash = GetHashKey('v_ilev_ph_cellgate'),
        objHeading = 299.0,
        objCoords = vector3(1859.69, 3686.64, 30.40),
        textCoords = vector3(1859.46, 3687.27, 30.26),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2  
	}, 
	{
        objHash = GetHashKey('v_ilev_ph_cellgate'),
        objHeading = 300.0,
        objCoords = vector3(1862.76, 3688.41, 30.40),
        textCoords = vector3(1862.45, 3689.07, 30.26),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2  
	}, 
	{
        objHash = GetHashKey('v_ilev_ph_cellgate'),
        objHeading = 300.0,
        objCoords = vector3(1860.89, 3691.64, 30.40),
        textCoords = vector3(1860.61, 3692.18, 30.26),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2   
	}, 
	{
        objHash = GetHashKey('v_ilev_arm_secdoor'),
        objHeading = 29.87,
        objCoords = vector3(1852.92, 3686.40, 30.41),
        textCoords = vector3(1852.37, 3686.04, 30.26),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2    
	}, 
	{
        objHash = GetHashKey('v_ilev_arm_secdoor'),
        objHeading = 29.87,
        objCoords = vector3(1856.16, 3688.26, 30.41),
        textCoords = vector3(1855.66, 3687.92, 30.26),
        authorizedJobs = {'police'},
        locked = true,
        maxDistance = 2    
	}, 

	-- taxi

	{
        objHash = GetHashKey('v_ilev_rc_door2'),
        objHeading = 148.86,
        objCoords = vector3(897.2452, -169.4265, 74.84328),
        textCoords = vector3(897.2452, -169.4265, 74.84328),
        authorizedJobs = {'taxi'},
        locked = true,
        maxDistance = 2    
	},
	{
        textCoords = vector3(894.73, -179.05, 73.75),
        authorizedJobs = {'taxi'},
        locked = true,
        maxDistance = 2,
        doors = {
            {objHash = GetHashKey('v_ilev_rc_door2'), objHeading = 57.89, objCoords = vector3(893.93, -180.09, 74.84)},
            {objHash = GetHashKey('v_ilev_rc_door2'), objHeading = 237.90, objCoords = vector3(895.31, -177.89, 74.84)}
        }
	},
	{
        objHash = GetHashKey('v_ilev_store_door'),
        objHeading = 57.28,
        objCoords = vector3(889.24, -159.81, 77.10),
        textCoords = vector3(888.63, -160.32, 77.10),
        authorizedJobs = {'taxi'},
        locked = true,
        maxDistance = 2    
	},
}	

-- Citizen.CreateThread(function()
-- 	Citizen.Wait(5)
-- 	if CustomDoors[1] == nil then --[[no doors]] else
-- 		for k, v in pairs(CustomDoors) do
-- 			table.insert(Config.DoorList, v)
-- 		end
-- 	end
-- end)
