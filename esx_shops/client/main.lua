Keys = {["E"] = 38, ["L"] = 182, ["G"] = 47}

payAmount = 0
Basket = {}

--[[ Gets the ESX library ]]--
ESX = nil 
Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(10)

        TriggerEvent("esx:getSharedObject", function(obj)
            ESX = obj
        end)
    end
end)

DrawText3D = function(x, y, z, text)
    local onScreen,x,y = World3dToScreen2d(x, y, z)
    local factor = #text / 370

    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(x,y)
        --DrawRect(x,y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 120)--
    end
end

--[[ Requests specified model ]]--
_RequestModel = function(hash)
    if type(hash) == "string" then hash = GetHashKey(hash) end
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(0)
    end
end

--[[ Deletes the cashiers ]]--
DeleteCashier = function()
    for i=1, #Config.Locations do
        local cashier = Config.Locations[i]["cashier"]
        if DoesEntityExist(cashier["entity"]) then
            DeletePed(cashier["entity"])
            SetPedAsNoLongerNeeded(cashier["entity"])
        end
    end
end

Citizen.CreateThread(function()
    local defaultHash = 416176080
    for i=1, #Config.Locations do
        local cashier = Config.Locations[i]["cashier"]
        if cashier then
            cashier["hash"] = cashier["hash"] or defaultHash
            _RequestModel(cashier["hash"])
            if not DoesEntityExist(cashier["entity"]) then
                cashier["entity"] = CreatePed(4, cashier["hash"], cashier["x"], cashier["y"], cashier["z"], cashier["h"])
                SetEntityAsMissionEntity(cashier["entity"])
                SetBlockingOfNonTemporaryEvents(cashier["entity"], true)
                FreezeEntityPosition(cashier["entity"], true)
                SetEntityInvincible(cashier["entity"], true)
            end
            SetModelAsNoLongerNeeded(cashier["hash"])
        end
    end
end)


--Black cashier

DeleteCashier = function()
    for i=1, #Config.Locations do
        local cashier_black = Config.Locations[i]["cashier_black"]
        if cashier_black ~= nil then
            DeletePed(cashier_black["entity"])
            SetPedAsNoLongerNeeded(cashier_black["entity"])
        end
    end
end

Citizen.CreateThread(function()
    local defaultHash = 275618457
    for i=1, #Config.Locations do
        local cashier_black = Config.Locations[i]["cashier_black"]
        if cashier_black then
            cashier_black["hash"] = cashier_black["hash"] or defaultHash
            _RequestModel(cashier_black["hash"])
            if not DoesEntityExist(cashier_black["entity"]) then
                cashier_black["entity"] = CreatePed(4, cashier_black["hash"], cashier_black["x"], cashier_black["y"], cashier_black["z"], cashier_black["h"])
                SetEntityAsMissionEntity(cashier_black["entity"])
                SetBlockingOfNonTemporaryEvents(cashier_black["entity"], true)
                FreezeEntityPosition(cashier_black["entity"], true)
                SetEntityInvincible(cashier_black["entity"], true)
            end
            SetModelAsNoLongerNeeded(cashier_black["hash"])
        end
    end
end)



--[[ Creates cashiers and blips ]]--
Citizen.CreateThread(function()
    for i=1, #Config.Locations do
        local blip = Config.Locations[i]["blip"]

        if blip then
            if not DoesBlipExist(blip["id"]) then
                blip["id"] = AddBlipForCoord(blip["x"], blip["y"], blip["z"])
                SetBlipSprite(blip["id"], 52)
                SetBlipDisplay(blip["id"], 4)
                SetBlipScale(blip["id"], 0.7)
                SetBlipColour(blip["id"], 30)
                SetBlipAsShortRange(blip["id"], true)

                BeginTextCommandSetBlipName("shopblip")
                AddTextEntry("shopblip", "Sklep")
                EndTextCommandSetBlipName(blip["id"])
            end
        end
    end
end)

--black sklep

Citizen.CreateThread(function()
    for i=1, #Config.Locations do
        local blip_black = Config.Locations[i]["blip_black"]

        if blip_black then
            if not DoesBlipExist(blip_black["id"]) then
                blip_black["id"] = AddBlipForCoord(blip_black["x"], blip_black["y"], blip_black["z"])
                SetBlipSprite(blip_black["id"], 84)
                SetBlipDisplay(blip_black["id"], 4)
                SetBlipScale(blip_black["id"], 0.7)
                SetBlipColour(blip_black["id"], 40)
                SetBlipAsShortRange(blip_black["id"], true)

                BeginTextCommandSetBlipName("shopblip_black")
                AddTextEntry("shopblip_black", "Brudny Sklep")
                EndTextCommandSetBlipName(blip_black["id"])
            end
        end
    end
end)

Citizen.CreateThread(function()
    for i=1, #Config.Locations do
        local blip_stripper = Config.Locations[i]["blip_stripper"]

        if blip_stripper then
            if not DoesBlipExist(blip_stripper["id"]) then
                blip_stripper["id"] = AddBlipForCoord(blip_stripper["x"], blip_stripper["y"], blip_stripper["z"])
                SetBlipSprite(blip_stripper["id"], 614)
                SetBlipDisplay(blip_stripper["id"], 4)
                SetBlipScale(blip_stripper["id"], 0.5)
                SetBlipColour(blip_stripper["id"], 61)
                SetBlipAsShortRange(blip_stripper["id"], true)

                BeginTextCommandSetBlipName("shopblip_stripper")
                AddTextEntry("shopblip_stripper", "Klub")
                EndTextCommandSetBlipName(blip_stripper["id"])
            end
        end
    end
end)


--[[ Function to trigger pNotify event for easier use :) ]]--
pNotify = function(message, messageType, messageTimeout)
	TriggerEvent("pNotify:SendNotification", {
        text = message,
		type = messageType,
		queue = "shopcl",
		timeout = messageTimeout,
		layout = "topRight"
	})
end

Marker = function(pos)
    DrawMarker(25, pos["x"], pos["y"], pos["z"] - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.75, 0.75, 0.75, 0, 178, 209, 60, false, false, 2, false, nil, nil, false)
    DrawMarker(25, pos["x"], pos["y"], pos["z"] - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.8, 0.8, 0, 178, 209, 60, false, false, 2, false, nil, nil, false)
end
