----------------------
-- Author : Deediezi
-- Version 4.5
--
-- Contributors : No contributors at the moment.
--
-- Github link : https://github.com/Deediezi/FiveM_LockSystem
-- You can contribute to the project. All the information is on Github.

--  Vehicle object manager - Client side

ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function newVehicle()
    local self = {}

    self.id = nil
    self.plate = nil
    self.lockStatus = nil

    rTable = {}

    rTable.__construct = function(id, plate, lockStatus)
        if(id and type(id) == "number")then
            self.id = id
        end
        if(plate and type(plate) == "string")then
            self.plate = plate
        end
        if(lockStatus and type(lockStatus) == "number")then
            self.lockStatus = lockStatus
        end
    end

    -- Methods

    rTable.update = function(id, lockStatus)
        self.id = id
        self.lockStatus = lockStatus
    end

    -- 0, 1 = unlocked
    -- 2 = locked
    -- 4 = locked and player can't get out
    rTable.lock = function()
        local closestVehicle = ESX.Game.GetClosestVehicle(coords)
        local vehicle = ESX.Game.GetVehicleProperties(closestVehicle)
        local ped = GetPlayerPed(-1)
        lockStatus = self.lockStatus
        if(lockStatus <= 2)then
            self.lockStatus = 4
            SetVehicleDoorsLocked(self.id, self.lockStatus)
            SetVehicleDoorsLockedForAllPlayers(self.id, 1)
            ESX.ShowAdvancedNotification("NeonRP", "~y~Zamknięto pojazd", "~y~Nr.Rej~s~: ~b~" .. vehicle.plate,  'CustomLogo', 1)
            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "lock", 1.0)
            if not IsPedInAnyVehicle(ped) then
                TaskPlayAnim(GetPlayerPed(-1), "anim@mp_player_intmenu@key_fob@", "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
            end
        elseif(lockStatus > 2)then
            self.lockStatus = 1
            SetVehicleDoorsLocked(self.id, self.lockStatus)
            SetVehicleDoorsLockedForAllPlayers(self.id, false)
            ESX.ShowAdvancedNotification("NeonRP", "~y~Otwarto pojazd", "~y~Nr.Rej~s~: ~b~" .. vehicle.plate,  'CustomLogo', 1)
            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "unlock", 1.0)
            if not IsPedInAnyVehicle(ped) then
                TaskPlayAnim(GetPlayerPed(-1), "anim@mp_player_intmenu@key_fob@", "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
            end
        end
    end

    -- Setters

    rTable.setId = function(id)
        if(type(id) == "number" and id >= 0)then
            self.id = id
        end
    end

    rTable.setPlate = function(plate)
        if(type(plate) == "string")then
            self.plate = plate
        end
    end

    rTable.setLockStatus = function(lockStatus)
        if(type(lockStatus) == "number" and lockStatus >= 0)then
            self.lockStatus = lockStatus
            SetVehicleDoorsLocked(self.id, lockStatus)
        end
    end

    -- Getters

    rTable.getId = function()
        return self.id
    end

    rTable.getPlate = function()
        return self.plate
    end

    rTable.getLockStatus = function()
        return self.lockStatus
    end

    return rTable
end