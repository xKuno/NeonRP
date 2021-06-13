Citizen.CreateThread(function()
    while true do
        Citizen.Wait(50)
        for t, u in ipairs(Config.WeaponBL) do
            Wait(1)
            if HasPedGotWeapon(PlayerPedId(), GetHashKey(u), false) == 1 then
                RemoveAllPedWeapons(PlayerPedId(), false)
                TriggerServerEvent("CYNAMON:webhook", 'weapon', u)
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        KillAllPeds()
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(30000)
        TriggerServerEvent("CYNAMON:ackasa")
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(30000)
        TriggerServerEvent('pobierzkase')
    end
end)

function _DeleteEntity(E)
    Citizen.InvokeNative(0xAE3CBE5BF394C9C9,
                         Citizen.PointerValueIntInitialized(E))
end
function KillAllPeds()
    local F;
    local G;
    for e in EnumeratePeds() do
        Citizen.Wait(100)
        if DoesEntityExist(e) then
            G = GetEntityModel(e)
            F = GetSelectedPedWeapon(e)
            if F == -1312131151 or not IsPedHuman(e) then
                Citizen.Wait(100)
                ApplyDamageToPed(e, 1000, false)
                DeleteEntity(e)
            else
                switch = function(H)
                    H = H and tonumber(H) or H;
                    case = {
                        [1684083350] = function()
                            ApplyDamageToPed(e, 1000, false)
                            DeleteEntity(e)
                        end,
                        [451459928] = function()
                            ApplyDamageToPed(e, 1000, false)
                            DeleteEntity(e)
                        end,
                        [1096929346] = function()
                            ApplyDamageToPed(e, 1000, false)
                            DeleteEntity(e)
                        end,
                        [-1320879687] = function()
                            ApplyDamageToPed(e, 1000, false)
                            DeleteEntity(e)
                        end,
                        [-1686040670] = function()
                            ApplyDamageToPed(e, 1000, false)
                            DeleteEntity(e)
                        end,
                        [880829941] = function()
                            ApplyDamageToPed(e, 1000, false)
                            DeleteEntity(e)
                        end,
                        [-1404353274] = function()
                            ApplyDamageToPed(e, 1000, false)
                            DeleteEntity(e)
                        end,
                        [2109968527] = function()
                            ApplyDamageToPed(e, 1000, false)
                            DeleteEntity(e)
                        end,
                        default = function() end
                    }
                    if case[H] then
                        Citizen.Wait(100)
                        case[H]()
                    else
                        Citizen.Wait(100)
                        case["default"]()
                    end
                end;
                switch(G)
            end
        end
    end
end
function DeleteObjects(g, I)
    if DoesEntityExist(g) then
        NetworkRequestControlOfEntity(g)
        while not NetworkHasControlOfEntity(g) do Citizen.Wait(1) end
        if I then DetachEntity(g, 0, false) end
        SetEntityCollision(g, false, false)
        SetEntityAlpha(g, 0.0, true)
        SetEntityAsMissionEntity(g, true, true)
        SetEntityAsNoLongerNeeded(g)
        DeleteEntity(g)
    end
end
local function J(K, L, M)
    return coroutine.wrap(function()
        local N, O = K()
        if not O or O == 0 then
            M(N)
            return
        end
        local P = {handle = N, destructor = M}
        setmetatable(P, entityEnumerator)
        local Q = true;
        repeat
            coroutine.yield(O)
            Q, O = L(N)
        until not Q;
        P.destructor, P.handle = nil, nil;
        M(N)
    end)
end
function EnumeratePeds() return J(FindFirstPed, FindNextPed, EndFindPed) end
function EnumerateObjects()
    return J(FindFirstObject, FindNextObject, EndFindObject)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(50)
		id = PlayerId()
		DisablePlayerVehicleRewards(id)	
	end
end)

-- CODE --

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(50)

		playerPed = GetPlayerPed(-1)
        if playerPed then
			checkCar(GetVehiclePedIsIn(playerPed, false))

            x, y, z = table.unpack(GetEntityCoords(playerPed, true))
            for _, blacklistedCar in pairs(Config.VehicleBL) do
				checkCar(GetClosestVehicle(x, y, z, 100.0, GetHashKey(blacklistedCar), 70))
			end
		end
    end
    -- Citizen.Wait(2000)
end)




--###################
--#### FUNCTIONS ####
--###################





function checkCar(car)
	if car then
        carModel = GetEntityModel(car)
        -- auto = carName
		carName = GetDisplayNameFromVehicleModel(carModel)
        Citizen.Wait(1)
        if isCarBlacklisted(carModel) then
            TriggerServerEvent('wyslij:auto', carName)
			_DeleteEntity(car)
		end
	end
end

function isCarBlacklisted(model)
    Citizen.Wait(50)
	for _, blacklistedCar in pairs(Config.VehicleBL) do
        if model == GetHashKey(blacklistedCar) then
            -- Citizen.Wait(1)
			return true
		end
	end
    Citizen.Wait(10)
	return false
end

function isWeaponBlacklisted(model)
    Citizen.Wait(50)
	for _, blacklistedWeapon in pairs(weaponblacklist) do
        if model == GetHashKey(blacklistedWeapon) then
            -- Citizen.Wait(1)
			return true
		end
	end
    Citizen.Wait(10)
	return false
end