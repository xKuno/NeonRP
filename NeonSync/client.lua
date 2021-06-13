
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_LOST"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_HILLBILLY"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(5, GetHashKey("AMBIENT_GANG_BALLAS"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_MEXICAN"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_FAMILY"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_MARABUNTE"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_SALVA"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("GANG_1"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("GANG_2"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("GANG_9"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("GANG_10"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("FIREMAN"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("MEDIC"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("COP"), GetHashKey('PLAYER'))





    SetGarbageTrucks(false) -- Stop garbage trucks from randomly spawning
    SetRandomBoats(false) -- Stop random boats from spawning in the water.
    SetCreateRandomCops(false) -- disable random cops walking/driving around.
    SetCreateRandomCopsNotOnScenarios(false) -- stop random cops (not in a scenario) from spawning.
    SetCreateRandomCopsOnScenarios(false) -- stop random cops (in a scenario) from spawning.
    --ClearAreaOfCops(pos.x, pos.y, pos.z, 400.0)
    ClearAreaOfPeds(1680.07, 2512.8, 45.4649, 100.0001)
    ClearAreaOfPeds(-2080.90, 3258.49, 32.81, 450.0001)
    ClearAreaOfVehicles(-2080.90, 3258.49, 32.81, 450.0001, false, false, false, false, false)
	ClearAreaOfVehicles(1887.51, 2453.14, 54.04, 328.0400, false, false, false, false, false)
    --ClearAreaOfVehicles(187.00, -343.49, 44.06, 50.0001, false, false, false, false, false)
    --RemoveVehiclesFromGeneratorsInArea(-2920.23, 3168.61, 31.81, -1526.15, 3144.96 100.81);
    --RemoveVehiclesFromGeneratorsInArea(39.00, -453.49, -222.00, 462.22, -248.49, 85.59);      ---- sąd
    RemoveVehiclesFromGeneratorsInArea(-1478.426,-1035.627,5.29558,-1478.426,-1035.627,5.29558)   -- LSL Lranger 1
    RemoveVehiclesFromGeneratorsInArea(-1473.324,-1029.541,5.29558,-1473.324,-1029.541,5.29558)   -- LSL Lranger 2
    RemoveVehiclesFromGeneratorsInArea(-1487.368,-1019.312,5.29558,-1487.368,-1019.312,5.29558)   -- LSL Lranger inside
----------------------------[[
--  Remove PickUps
----------------------------]]

    RemoveAllPickupsOfType(0xDF711959) -- carbine rifle
    RemoveAllPickupsOfType(0xF9AFB48F) -- pistol
    RemoveAllPickupsOfType(0xA9355DCD) -- pumpshotgun
    RemoveAllPickupsOfType(0x88EAACA7)