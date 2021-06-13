local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["INSERT"] = 121, ["HOME"] = 213, ["PAGEUP"] = 10, ["DELETE"] = 178, ["PAGEDOWN"] = 11,  
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
local ped = nil
local is_in_veh = false
local vehicle = nil
local RPMTime = GetGameTimer()
local UI = { x =  0.000 , y = -0.001 }
local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }
local directions = { [0] = 'N', [45] = 'NW', [90] = 'W', [135] = 'SW', [180] = 'S', [225] = 'SE', [270] = 'E', [315] = 'NE', [360] = 'N', } 
local currentZoneData = {}
local currentZoneData2 = {}

Citizen.CreateThread(function()
	while true do
		Wait(500)
		ped = PlayerPedId()
		is_in_veh = IsPedInAnyVehicle(ped, false)
		if is_in_veh then
			SendNUIMessage({
				action = "toggleStreetlabel",
				status = "block",
			})
			vehicle = GetVehiclePedIsIn(ped, false)
		else
			SendNUIMessage({
				action = "toggleStreetlabel",
				status = "none",
			})
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		if is_in_veh then
			local pos = GetEntityCoords(ped)
			local var1, var2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
			local current_zone = zones[GetNameOfZone(pos.x, pos.y, pos.z)]
			if GetStreetNameFromHashKey(var1) and GetNameOfZone(pos.x, pos.y, pos.z) then
				if zones[GetNameOfZone(pos.x, pos.y, pos.z)] and tostring(GetStreetNameFromHashKey(var1)) then
					if tostring(GetStreetNameFromHashKey(var2)) == "" then
						currentZoneData = tostring(GetStreetNameFromHashKey(var1))
						currentZoneData2 = ""
					else 
						currentZoneData = tostring(GetStreetNameFromHashKey(var1)) .. " /"
						currentZoneData2 = tostring(GetStreetNameFromHashKey(var2))
					end

					currentZoneData3 = current_zone

					for k,v in pairs(directions)do
						direction = GetEntityHeading(PlayerPedId())
						if(math.abs(direction - k) < 22.5)then
							direction = v
							break
						end
					end

					SendNUIMessage({
						action = "updateStreetLabel",
						street = currentZoneData,
						street2 = currentZoneData2,
						zone = currentZoneData3,
						direction = direction,
					})

				end
			end
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if IsPauseMenuActive() and not IsPaused then
	          IsPaused = true
            SendNUIMessage({
              action = "toggle", 
              show = false,
              id = GetPlayerServerId(PlayerId())
            })
        elseif not IsPauseMenuActive() and IsPaused then
            IsPaused = false
            SendNUIMessage({
              action = "toggle", 
              show = true,
              id = GetPlayerServerId(PlayerId())
            })
        else
          SendNUIMessage({
            action = "update", 
            id = GetPlayerServerId(PlayerId())
          })
        end
    end
end)

local Ped = {
	Driver = false,
	DisplayStreet = false
}

local OnlyDriver = false

function _DrawRect(X, Y, W, H, R, G, B, A, L)
	SetUiLayer(L)
	DrawRect(X, Y, W, H, R, G, B, A)
end

