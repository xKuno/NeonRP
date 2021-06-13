

ESX = nil
local PlayerData                = {}
local phoneProp = 0

voice_one = {

  RestrictedChannels = 16

}

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)


local radioMenu = false

function newPhoneProp()
  deletePhone()
  RequestModel("prop_cs_walkie_talkie")
  while not HasModelLoaded("prop_cs_walkie_talkie") do
    Citizen.Wait(1)
  end

  phoneProp = CreateObject("prop_cs_walkie_talkie", 1.0, 1.0, 1.0, 1, 1, 0)
  local bone = GetPedBoneIndex(PlayerPedId(), 28422)
  AttachEntityToEntity(phoneProp, PlayerPedId(), bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
end

function deletePhone()
  if phoneProp ~= 0 then
    Citizen.InvokeNative(0xAE3CBE5BF394C9C9 , Citizen.PointerValueIntInitialized(phoneProp))
    phoneProp = 0
  end
end

function enableRadio(enable)
  if enable then
    local dict = "cellphone@"
    if IsPedInAnyVehicle(PlayerPedId(), false) then
      dict = "anim@cellphone@in_car@ps"
    end

    loadAnimDict(dict)

    local anim = "cellphone_call_to_text"
    TaskPlayAnim(PlayerPedId(), dict, anim, 3.0, -1, -1, 50, 0, false, false, false)
    newPhoneProp()
  else
    ClearPedSecondaryTask(PlayerPedId())
    deletePhone()
  end

  SetNuiFocus(true, true)
  radioMenu = enable
  SendNUIMessage({
    type = "enableui",
    enable = enable
  })

end

function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(1)
	end
end


-- dołączanie do radia

RegisterNUICallback('joinRadio', function(data, cb)
    local _source = source
    local PlayerData = ESX.GetPlayerData(_source)
    local playerName = GetPlayerName(PlayerId())

    if tonumber(data.channel) then
      if tonumber(data.channel) == 999 then
        
        
      end
        if tonumber(data.channel) <= voice_one.RestrictedChannels then
          if(PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance') then
            exports["mumble-voip"]:SetRadioChannel(tonumber(data.channel))
            TriggerEvent('esx:showAdvancedNotification', 'System', '','~g~Wszedłeś na radio!', 'CHAR_BLOCKED', 7)
          elseif not (PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance') then
           TriggerEvent('esx:showNotification', '~r~Ta częstotliwość jest zablokowana!')
          end
        end
        if tonumber(data.channel) > voice_one.RestrictedChannels then
          exports["mumble-voip"]:SetRadioChannel(tonumber(data.channel))
        end
      else
      end--
    cb('ok')
end)

-- opuszczanie radia

RegisterNUICallback('leaveRadio', function(data, cb)
   local playerName = GetPlayerName(PlayerId())

    TriggerEvent('esx:showAdvancedNotification', 'System', '','~r~Wyszedłeś z radia!', 'CHAR_BLOCKED', 7)
          exports["mumble-voip"]:SetRadioChannel(0)

   cb('ok')

end)

RegisterNUICallback('escape', function(data, cb)

    enableRadio(false)
    SetNuiFocus(false, false)


    cb('ok')
end)

if IsControlJustPressed(1, 177) then
    enableRadio(false)
    SetNuiFocus(false, false)
	local debugmode = false
	elseif debugmode == true then
end

RegisterNetEvent('mumble-radio:use')
AddEventHandler('mumble-radio:use', function()
  enableRadio(true)
end)

RegisterNetEvent('mumble-radio:onRadioDrop')
AddEventHandler('mumble-radio:onRadioDrop', function()
  local playerName = GetPlayerName(PlayerId())
    exports["mumble-voip"]:SetRadioChannel(0)
end)

Citizen.CreateThread(function()
    while true do
        if radioMenu then
            DisableControlAction(0, 1, guiEnabled)
            DisableControlAction(0, 2, guiEnabled)
            DisableControlAction(0, 142, guiEnabled)
            DisableControlAction(0, 106, guiEnabled)
            if IsDisabledControlJustReleased(0, 142) then
                SendNUIMessage({
                    type = "click"
                })
            end
        else
          Citizen.Wait(1500)
        end
        Citizen.Wait(10)
    end
end)
