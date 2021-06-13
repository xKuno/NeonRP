local PlayerData                = {}
ESX                             = nil
group 							= nil
local reviveWait 				= 0
local timerCount 				= reviveWait
local statusreporta				= true
Permisje 						= nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()
end)
local group 
RegisterNetEvent('es_admin:setGroup')
AddEventHandler('es_admin:setGroup', function(g)
	-- print('group setted ' .. g)
	group = g
end)
---------------------
----- LOCAL OOC -----
---------------------

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	TriggerServerEvent('iluka:updatepermisisons')
	Wait(1500)
	TriggerEvent('NeonRP:loadedpermisions', Permisje)
	return
end)

-- TriggerServerEvent('iluka:updatepermisisons')

RegisterNetEvent('iluka:sendpermisionstoclient', group)
AddEventHandler('iluka:sendpermisionstoclient', function(group)
		Permisje = group
		-- print("Wczytano permisje: "..Permisje)
end)

RegisterCommand('repoff', function(source, args)
	if Permisje == "superadmin" then
		if statusreporta then
			statusreporta = false
			TriggerEvent('esx:showAdvancedNotification', "~r~Wyłączono report")
		else
			statusreporta = true
			TriggerEvent('esx:showAdvancedNotification', "~g~Włączono report")
		end
	else
		TriggerEvent('esx:showAdvancedNotification', "~r~Nie masz permisji")
	end
end)
RegisterNetEvent('iluka:sendstatusreportatoclient', repoff)
AddEventHandler('iluka:sendstatusreportatoclient', function(repoff)
	statusreporta = repoff
end)

RegisterNetEvent('sendProximityMessage')
AddEventHandler('sendProximityMessage', function(id, name, message)
  local monid = PlayerId()
  local sonid = GetPlayerFromServerId(id)
  if sonid ~= -1 then
	  if sonid == monid then
		TriggerEvent('chatMessage',"💬 [" .. id .. "] ".. name, {128, 128, 128}, message)
	  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 29.999 then
		TriggerEvent('chatMessage',"💬 [" .. id .. "] ".. name, {128, 128, 128}, message)
	  end
  end
end)

RegisterNetEvent('sendProximityMessagetry')
AddEventHandler('sendProximityMessagetry', function(id, name, message)
  local monid = PlayerId()
  local sonid = GetPlayerFromServerId(id)
  if sonid ~= -1 then
	  if sonid == monid then
		TriggerEvent('chatMessage',"💬 [" .. id .. "] ".. name, {128, 128, 128}, message)
	  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 29.999 then
		TriggerEvent('chatMessage',"💬 [" .. id .. "] ".. name, {128, 128, 128}, message)
	  end
  end
end)


RegisterNetEvent('esx_rpchat:sendProximityMessageTask')
AddEventHandler('esx_rpchat:sendProximityMessageTask', function(id, message, color)
	local source = PlayerId()
	local target = GetPlayerFromServerId(id)
	if target ~= -1 then
		if target == source then
			TriggerEvent('chat:addMessage', { args = { message }, color = color })
		elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(source)), GetEntityCoords(GetPlayerPed(target)), true) < 50 then
			TriggerEvent('chat:addMessage', { args = { message }, color = color })
		end
	end
end)

RegisterNetEvent('pokaDw')
AddEventHandler('pokaDw', function(id, message)
    PlayerData = ESX.GetPlayerData()
    if PlayerData.job.name == 'police' or PlayerData.job.name == 'offpolice' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'offambulance' then


    else
		if Permisje ~= "user" and Permisje ~= nil then
		TriggerEvent('chatMessage',"["..id.."] 💻 DARKWEB", {255, 0, 0}, message)
		else
		TriggerEvent('chatMessage',"💻 DARKWEB", {255, 0, 0}, message)
		end
    end
end)

RegisterNetEvent('iluka:pokaTwT')
AddEventHandler('iluka:pokaTwT', function(id, name, message)
	if Permisje ~= "user" and Permisje ~= nil then
	TriggerEvent('chatMessage',"["..id.."] 🕊️ @"  .. name, {30, 144, 255}, message)
	else
	TriggerEvent('chatMessage',"🕊️ @"  .. name, {30, 144, 255}, message)
	end
end)

RegisterNetEvent('pokaLSPD')
AddEventHandler('pokaLSPD', function(id, name, message)
	TriggerEvent('chatMessage',"👮 @"  .. name, {30, 144, 255}, message)
end)

RegisterNetEvent('pokaOGL')
AddEventHandler('pokaOGL', function(id, name, message)
	TriggerEvent('chatMessage',"^8OGŁOSZENIE^7", {30, 144, 255}, message)
end)



RegisterNetEvent('esx_chat:setGroup')
AddEventHandler('esx_chat:setGroup', function(g)
	group = g
end)


RegisterNetEvent("sendMessageToPlayer")
AddEventHandler('sendMessageToPlayer', function(id, name, message, gID)
  local pID = GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1)))
  if pID == id then
	TriggerEvent('chatMessage',"💬 ["..gID.."] "  .. name, {79, 114, 255}, message)
  end
end)


RegisterNetEvent('sendReport')
AddEventHandler('sendReport', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if timerCount > 0 then
  if pid == myId then
  TriggerEvent('chatMessage', "", {255, 0, 0}, "Musisz odczekać "..timerCount.." s przed wysłaniem kolejnej wiadomości!")
  return
  end
  else
  if pid == myId then
    TriggerEvent('chatMessage', "", {255, 0, 0}, "Wiadomość została wysłana do administratorów!")
	TriggerEvent('chatMessage', "", {255, 0, 0}, " ^*[^3ZGŁOSZENIE^r^*^8] | ^*[^3".. id .."^r^*^8] ^3 " .. name .."^r"..":^0  ^*" .. message)
	timerCount = 120
  elseif group ~= 'user' and pid ~= myId then
	if statusreporta then
    TriggerEvent('chatMessage', "", {255, 0, 0}, " ^*[^3ZGŁOSZENIE^r^*^8] | ^*[^3".. id .."^r^*^8] ^3 " .. name .."^r"..":^0  ^*" .. message)
	end
  end
  end
end)

Citizen.CreateThread(function()
    while true do
		timerCount = timerCount - 1
        Citizen.Wait(1000)          
    end
end)

local color = {r = 37, g = 175, b = 134, alpha = 255} -- Color of the text 
local color2 = {r = 37, g = 175, b = 134, alpha = 255}
local color3 = { r = 255, g = 255, b = 255, a = 255 } -- Text color3
local font = 0 -- Font of the text
local time = 15000 -- Duration of the display of the text : 1000ms = 1sec
local nbrDisplaying = 0
local distToDraw = 70 -- Min. distance to draw 
local pedDisplaying = {}
local defaultScale = 0.5 -- Text scale


RegisterCommand('me', function(source, args)
    local text = ' ' -- edit here if you want to change the language : EN: the person / FR: la personne
    for i = 1,#args do
        text = text .. ' ' .. args[i]
    end
    text = text .. ' '
	  TriggerServerEvent('3dme:shareDisplayMe', text)
end)

RegisterCommand('do', function(source, args)
    local text = ' ' -- edit here if you want to change the language : EN: the person / FR: la personne
    for i = 1,#args do
        text = text .. ' ' .. args[i]
    end
    text = text .. ' '
          TriggerServerEvent('3dme:shareDisplayDo', text)
end)

RegisterNetEvent('3dme:shareDisplayOpis')
AddEventHandler('3dme:shareDisplayOpis', function(text, serverId)
    local ped = GetPlayerPed(GetPlayerFromServerId(serverId))
	if GetPlayerFromServerId(serverId) ~= -1 then
		DisplayOpis(ped, text)
	end
end)


RegisterNetEvent('3dme:triggerDisplayMe')
AddEventHandler('3dme:triggerDisplayMe', function(text, source)
    local offset = 1 + (nbrDisplaying*0.14)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(source)
 if pid ~= -1 then
	 if pid == myId then
		 
	  DisplayMe(GetPlayerFromServerId(source), text, offset)
	  TriggerEvent('chatMessage',"^*Obywatel ["  .. source .. "] " .. text, {255, 152, 247})
	  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
	 
	  DisplayMe(GetPlayerFromServerId(source), text, offset)
	  TriggerEvent('chatMessage',"^*Obywatel ["  .. source .. "] " .. text, {255, 152, 247})
	  end
 end
end)

RegisterNetEvent('3dme:triggerDisplayDo')
AddEventHandler('3dme:triggerDisplayDo', function(text, source)
    local offset = 1 + (nbrDisplaying*0.14)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(source)
 if pid ~= -1 then
	 if pid == myId then
		TriggerEvent('chatMessage',"^*Obywatel ["  .. source .. "] " .. text, {256, 202, 247})
		DisplayDo(GetPlayerFromServerId(source), text, offset)
	  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
		TriggerEvent('chatMessage',"^*Obywatel ["  .. source .. "] " .. text, {256, 202, 247})
		DisplayDo(GetPlayerFromServerId(source), text, offset)
	  end
		--Display(GetPlayerFromServerId(source), text, offset)
  end
end)

RegisterNetEvent('pokaTry')
AddEventHandler('pokaTry', function(id, message)
    local monid = PlayerId()
    local sonid = GetPlayerFromServerId(id)
	if sonid ~= -1 then
		if sonid == monid then
			TriggerEvent('chatMessage',"🎲 | ^*Obywatel [" .. id .. "] ".. message, {256, 202, 247})
		elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 29.999 then
			TriggerEvent('chatMessage',"🎲 | ^*Obywatel [" .. id .. "] ".. message, {256, 202, 247})
		end
	end
end)


local try = 1
RegisterNetEvent('iluka:tryzchatemes')
AddEventHandler('iluka:tryzchatemes', function(tekst, source)
	if GetPlayerFromServerId(source) ~= -1 then
		local zmienna = 1 + (try*0.15)
		Pokazuj(GetPlayerFromServerId(source), tekst, zmienna)
	end
end)


function DisplayMe(mePlayer, text, offset)
    local displaying = true
    Citizen.CreateThread(function()
        Wait(time)
        displaying = false
    end)
    Citizen.CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1
        while displaying do
            Wait(0)
            local coords = GetEntityCoords(GetPlayerPed(mePlayer), false)
            DrawText3Dme(coords['x'], coords['y'], coords['z']+offset, text)
        end
        nbrDisplaying = nbrDisplaying - 1
    end)
end

function DisplayDo(mePlayer, text, offset)
    local displaying = true
    Citizen.CreateThread(function()
        Wait(time)
        displaying = false
    end)
    Citizen.CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1
        while displaying do
            Wait(0)
            local coords = GetEntityCoords(GetPlayerPed(mePlayer), false)
            DrawText3Ddo(coords['x'], coords['y'], coords['z']+offset, text)
        end
        nbrDisplaying = nbrDisplaying - 1
    end)
end
function DrawText3Dme(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.40, 0.40)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end


function DrawText3Ddo(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.40, 0.40)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(0, 0, 0, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 255, 255, 255, 68)
end
function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
        N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
        DrawText(x - 0.1+w, y - 0.02+h)
end

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    local px,py,pz = table.unpack(GetGameplayCamCoord())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextColour(color.r, color.g, color.b, color.alpha)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(true)
        AddTextComponentString(text)
        EndTextCommandDisplayText(_x, _y)
    end
end

function DrawText3DOpis(coords, text)
    local camCoords = GetGameplayCamCoord()
    local dist = #(coords - camCoords)
    
    -- Experimental math to scale the text down
    local scale = 200 / (GetGameplayCamFov() * dist)
	local text = '* ' .. text .. ' *'

    --if onScreen then

        -- Format the text
        SetTextColour(color3.r, color3.g, color3.b, color3.a)
        SetTextScale(0.0, defaultScale * scale)
        SetTextDropshadow(0, 0, 0, 0, 20)
        SetTextDropShadow()
        SetTextCentre(true)

        -- Diplay the text
        BeginTextCommandDisplayText("STRING")
        AddTextComponentSubstringPlayerName(text)
        SetDrawOrigin(coords, 0)
        EndTextCommandDisplayText(0.0, 0.0)
        ClearDrawOrigin()

    --end
end

-- OBJ : handle the drawing of text above a ped head
-- PARAMETERS :
--      - coords : world coordinates to where you want to draw the text
--      - text : the text to display
function DisplayOpis(ped, text)

    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local pedCoords = GetEntityCoords(ped)
    local dist = #(playerCoords - pedCoords)

    if dist <= distToDraw then

        pedDisplaying[ped] = (pedDisplaying[ped] or 1) + 1

		
		if string.len(text) > 0 then
			display = true
		else
			display = false
		end
        --[[Citizen.CreateThread(function()
            Wait(displayTime)
            display = false
        end)]]

        -- Display
        local offset = 0.8 + pedDisplaying[ped] * 0.1
			while display do
				if HasEntityClearLosToEntity(playerPed, ped, 17 ) then
					local x, y, z = table.unpack(GetEntityCoords(ped))
					z = z + offset
					DrawText3DOpis(vector3(x, y, z), text)
				end
				Wait(0)
				if not display then 
					break 
				end
			end

        pedDisplaying[ped] = pedDisplaying[ped] - 1

    end
end

function Pokazuj(osoba, tekst, zmienna)
    local pokazuje = true

    Citizen.CreateThread(function()
        Wait(7000)
        pokazuje = false
    end)
	
    Citizen.CreateThread(function()
        try = try + 1
        while pokazuje do
            Wait(6)
            local kordygracz = GetEntityCoords(GetPlayerPed(osoba), false)
            local kordy = GetEntityCoords(PlayerPedId(), false)
            local odleglosc = Vdist2(kordygracz, kordy)
            if odleglosc < 500 then
                 Tekst3d(kordygracz['x'], kordygracz['y'], kordygracz['z']+zmienna-0.20, tekst)
            end
        end
        try = try - 1
    end)
end

function Tekst3d(x,y,z, tekst)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local p = GetGameplayCamCoords()
  local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
  local scale = (1 / distance) * 2
  local fov = (1 / GetGameplayCamFov()) * 100
  local scale = scale * fov
  if onScreen then
		SetTextScale(0.35, 0.35)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(tekst)
		DrawText(_x,_y)
		local factor = (string.len(tekst)) / 370
		DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
    end
end

function Emojit(text)
    for i = 1, #emoji do
      for k = 1, #emoji[i][1] do
        text = string.gsub(text, emoji[i][1][k], emoji[i][2])
      end
    end
    return text
end

emoji = {
	{
		{":grinning:"},
		"😀"
	}, {
		{":grimacing:"},
		"😬"
	}, {
		{":grin:"},
		"😁"
	}, {
		{":joy:"},
		"😂"
	}, {
		{":smiley:"},
		"😃"
	}, {
		{":smile:"},
		"😄"
	}, {
		{":sweat_smile:"},
		"😅"
	}, {
		{":laughing:", ":satisfied:"},
		"😆"
	}, {
		{":innocent:"},
		"😇"
	}, {
		{":wink:"},
		"😉"
	}, {
		{":blush:"},
		"😊"
	}, {
		{":slight_smile:", ":slightly_smiling_face:"},
		"🙂"
	}, {
		{":upside_down:", ":upside_down_face:"},
		"🙃"
	}, {
		{":relaxed:"},
		"☺"
	}, {
		{":yum:"},
		"😋"
	}, {
		{":relieved:"},
		"😌"
	}, {
		{":heart_eyes:"},
		"😍"
	}, {
		{":kissing_heart:"},
		"😘"
	}, {
		{":kissing:"},
		"😗"
	}, {
		{":kissing_smiling_eyes:"},
		"😙"
	}, {
		{":kissing_closed_eyes:"},
		"😚"
	}, {
		{":stuck_out_tongue_winking_eye:"},
		"😜"
	}, {
		{":stuck_out_tongue_closed_eyes:"},
		"😝"
	}, {
		{":stuck_out_tongue:"},
		"😛"
	}, {
		{":money_mouth:", ":money_mouth_face:"},
		"🤑"
	}, {
		{":nerd:", ":nerd_face:"},
		"🤓"
	}, {
		{":sunglasses:"},
		"😎"
	}, {
		{":hugging:", ":hugging_face:"},
		"🤗"
	}, {
		{":smirk:"},
		"😏"
	}, {
		{":no_mouth:"},
		"😶"
	}, {
		{":neutral_face:"},
		"😐"
	}, {
		{":expressionless:"},
		"😑"
	}, {
		{":unamused:"},
		"😒"
	}, {
		{":rolling_eyes:", ":face_with_rolling_eyes:"},
		"🙄"
	}, {
		{":thinking:", ":thinking_face:"},
		"🤔"
	}, {
		{":flushed:"},
		"😳"
	}, {
		{":disappointed:"},
		"😞"
	}, {
		{":worried:"},
		"😟"
	}, {
		{":angry:"},
		"😠"
	}, {
		{":rage:"},
		"😡"
	}, {
		{":pensive:"},
		"😔"
	}, {
		{":confused:"},
		"😕"
	}, {
		{":slight_frown:", ":slightly_frowning_face:"},
		"🙁"
	}, {
		{":frowning2:", ":white_frowning_face:"},
		"☹"
	}, {
		{":persevere:"},
		"😣"
	}, {
		{":confounded:"},
		"😖"
	}, {
		{":tired_face:"},
		"😫"
	}, {
		{":weary:"},
		"😩"
	}, {
		{":triumph:"},
		"😤"
	}, {
		{":open_mouth:"},
		"😮"
	}, {
		{":scream:"},
		"😱"
	}, {
		{":fearful:"},
		"😨"
	}, {
		{":cold_sweat:"},
		"😰"
	}, {
		{":hushed:"},
		"😯"
	}, {
		{":frowning:"},
		"😦"
	}, {
		{":anguished:"},
		"😧"
	}, {
		{":cry:"},
		"😢"
	}, {
		{":disappointed_relieved:"},
		"😥"
	}, {
		{":sleepy:"},
		"😪"
	}, {
		{":sweat:"},
		"😓"
	}, {
		{":sob:"},
		"😭"
	}, {
		{":dizzy_face:"},
		"😵"
	}, {
		{":astonished:"},
		"😲"
	}, {
		{":zipper_mouth:", ":zipper_mouth_face:"},
		"🤐"
	}, {
		{":mask:"},
		"😷"
	}, {
		{":thermometer_face:", ":face_with_thermometer:"},
		"🤒"
	}, {
		{":head_bandage:", ":face_with_head_bandage:"},
		"🤕"
	}, {
		{":sleeping:"},
		"😴"
	}, {
		{":zzz:"},
		"💤"
	}, {
		{":poop:", ":shit:", ":hankey:", ":poo:"},
		"💩"
	}, {
		{":smiling_imp:"},
		"😈"
	}, {
		{":imp:"},
		"👿"
	}, {
		{":japanese_ogre:"},
		"👹"
	}, {
		{":japanese_goblin:"},
		"👺"
	}, {
		{":skull:", ":skeleton:"},
		"💀"
	}, {
		{":ghost:"},
		"👻"
	}, {
		{":alien:"},
		"👽"
	}, {
		{":robot:", ":robot_face:"},
		"🤖"
	}, {
		{":smiley_cat:"},
		"😺"
	}, {
		{":smile_cat:"},
		"😸"
	}, {
		{":joy_cat:"},
		"😹"
	}, {
		{":heart_eyes_cat:"},
		"😻"
	}, {
		{":smirk_cat:"},
		"😼"
	}, {
		{":kissing_cat:"},
		"😽"
	}, {
		{":scream_cat:"},
		"🙀"
	}, {
		{":crying_cat_face:"},
		"😿"
	}, {
		{":pouting_cat:"},
		"😾"
	}, {
		{":raised_hands:"},
		"🙌",
		
	}, {
		{":clap:"},
		"👏",
		
	}, {
		{":wave:"},
		"👋",
		
	}, {
		{":thumbsup:", ":+1:", ":thumbup:"},
		"👍",
		
	}, {
		{":thumbsdown:", ":-1:", ":thumbdown:"},
		"👎",
		
	}, {
		{":punch:"},
		"👊",
		
	}, {
		{":fist:"},
		"✊",
		
	}, {
		{":v:"},
		"✌",
		
	}, {
		{":ok_hand:"},
		"👌",
		
	}, {
		{":raised_hand:"},
		"✋",
		
	}, {
		{":open_hands:"},
		"👐",
		
	}, {
		{":muscle:"},
		"💪",
		
	}, {
		{":pray:"},
		"🙏",
		
	}, {
		{":point_up:"},
		"☝",
		
	}, {
		{":point_up_2:"},
		"👆",
		
	}, {
		{":point_down:"},
		"👇",
		
	}, {
		{":point_left:"},
		"👈",
		
	}, {
		{":point_right:"},
		"👉",
		
	}, {
		{":middle_finger:", ":reversed_hand_with_middle_finger_extended:"},
		"🖕",
		
	}, {
		{":hand_splayed:", ":raised_hand_with_fingers_splayed:"},
		"🖐",
		
	}, {
		{":metal:", ":sign_of_the_horns:"},
		"🤘",
		
	}, {
		{":vulcan:", ":raised_hand_with_part_between_middle_and_ring_fingers:"},
		"🖖",
		
	}, {
		{":writing_hand:"},
		"✍",
		
	}, {
		{":nail_care:"},
		"💅",
		
	}, {
		{":lips:"},
		"👄"
	}, {
		{":tongue:"},
		"👅"
	}, {
		{":ear:"},
		"👂",
		
	}, {
		{":nose:"},
		"👃",
		
	}, {
		{":eye:"},
		"👁"
	}, {
		{":eyes:"},
		"👀"
	}, {
		{":bust_in_silhouette:"},
		"👤"
	}, {
		{":busts_in_silhouette:"},
		"👥"
	}, {
		{":speaking_head:", ":speaking_head_in_silhouette:"},
		"🗣"
	}, {
		{":baby:"},
		"👶",
		
	}, {
		{":boy:"},
		"👦",
		
	}, {
		{":girl:"},
		"👧",
		
	}, {
		{":man:"},
		"👨",
		
	}, {
		{":woman:"},
		"👩",
		
	}, {
		{":person_with_blond_hair:"},
		"👱",
		
	}, {
		{":older_man:"},
		"👴",
		
	}, {
		{":older_woman:", ":grandma:"},
		"👵",
		
	}, {
		{":man_with_gua_pi_mao:"},
		"👲",
		
	}, {
		{":man_with_turban:"},
		"👳",
		
	}, {
		{":cop:"},
		"👮",
		
	}, {
		{":construction_worker:"},
		"👷",
		
	}, {
		{":guardsman:"},
		"💂",
		
	}, {
		{":spy:", ":sleuth_or_spy:"},
		"🕵",
		
	}, {
		{":santa:"},
		"🎅",
		
	}, {
		{":angel:"},
		"👼",
		
	}, {
		{":princess:"},
		"👸",
		
	}, {
		{":bride_with_veil:"},
		"👰",
		
	}, {
		{":walking:"},
		"🚶",
		
	}, {
		{":runner:"},
		"🏃",
		
	}, {
		{":dancer:"},
		"💃",
		
	}, {
		{":dancers:"},
		"👯"
	}, {
		{":couple:"},
		"👫"
	}, {
		{":two_men_holding_hands:"},
		"👬"
	}, {
		{":two_women_holding_hands:"},
		"👭"
	}, {
		{":bow:"},
		"🙇",
		
	}, {
		{":information_desk_person:"},
		"💁",
		
	}, {
		{":no_good:"},
		"🙅",
		
	}, {
		{":ok_woman:"},
		"🙆",
		
	}, {
		{":raising_hand:"},
		"🙋",
		
	}, {
		{":person_with_pouting_face:"},
		"🙎",
		
	}, {
		{":person_frowning:"},
		"🙍",
		
	}, {
		{":haircut:"},
		"💇",
		
	}, {
		{":massage:"},
		"💆",
		
	}, {
		{":couple_with_heart:"},
		"💑"
	}, {
		{":couple_ww:", ":couple_with_heart_ww:"},
		"👩‍❤️‍👩"
	}, {
		{":couple_mm:", ":couple_with_heart_mm:"},
		"👨‍❤️‍👨"
	}, {
		{":couplekiss:"},
		"💏"
	}, {
		{":kiss_ww:", ":couplekiss_ww:"},
		"👩‍❤️‍💋‍👩"
	}, {
		{":kiss_mm:", ":couplekiss_mm:"},
		"👨‍❤️‍💋‍👨"
	}, {
		{":family:"},
		"👪"
	}, {
		{":family_mwg:"},
		"👨‍👩‍👧"
	}, {
		{":family_mwgb:"},
		"👨‍👩‍👧‍👦"
	}, {
		{":family_mwbb:"},
		"👨‍👩‍👦‍👦"
	}, {
		{":family_mwgg:"},
		"👨‍👩‍👧‍👧"
	}, {
		{":family_wwb:"},
		"👩‍👩‍👦"
	}, {
		{":family_wwg:"},
		"👩‍👩‍👧"
	}, {
		{":family_wwgb:"},
		"👩‍👩‍👧‍👦"
	}, {
		{":family_wwbb:"},
		"👩‍👩‍👦‍👦"
	}, {
		{":family_wwgg:"},
		"👩‍👩‍👧‍👧"
	}, {
		{":family_mmb:"},
		"👨‍👨‍👦"
	}, {
		{":family_mmg:"},
		"👨‍👨‍👧"
	}, {
		{":family_mmgb:"},
		"👨‍👨‍👧‍👦"
	}, {
		{":family_mmbb:"},
		"👨‍👨‍👦‍👦"
	}, {
		{":family_mmgg:"},
		"👨‍👨‍👧‍👧"
	}, {
		{":womans_clothes:"},
		"👚"
	}, {
		{":shirt:"},
		"👕"
	}, {
		{":jeans:"},
		"👖"
	}, {
		{":necktie:"},
		"👔"
	}, {
		{":dress:"},
		"👗"
	}, {
		{":bikini:"},
		"👙"
	}, {
		{":kimono:"},
		"👘"
	}, {
		{":lipstick:"},
		"💄"
	}, {
		{":kiss:"},
		"💋"
	}, {
		{":footprints:"},
		"👣"
	}, {
		{":high_heel:"},
		"👠"
	}, {
		{":sandal:"},
		"👡"
	}, {
		{":boot:"},
		"👢"
	}, {
		{":mans_shoe:"},
		"👞"
	}, {
		{":athletic_shoe:"},
		"👟"
	}, {
		{":womans_hat:"},
		"👒"
	}, {
		{":tophat:"},
		"🎩"
	}, {
		{":helmet_with_cross:", ":helmet_with_white_cross:"},
		"⛑"
	}, {
		{":mortar_board:"},
		"🎓"
	}, {
		{":crown:"},
		"👑"
	}, {
		{":school_satchel:"},
		"🎒"
	}, {
		{":pouch:"},
		"👝"
	}, {
		{":purse:"},
		"👛"
	}, {
		{":handbag:"},
		"👜"
	}, {
		{":briefcase:"},
		"💼"
	}, {
		{":eyeglasses:"},
		"👓"
	}, {
		{":dark_sunglasses:"},
		"🕶"
	}, {
		{":ring:"},
		"💍"
	}, {
		{":closed_umbrella:"},
		"🌂"
	}, {
		{":cowboy:", ":face_with_cowboy_hat:"},
		"🤠"
	}, {
		{":clown:", ":clown_face:"},
		"🤡"
	}, {
		{":nauseated_face:", ":sick:"},
		"🤢"
	}, {
		{":rofl:", ":rolling_on_the_floor_laughing:"},
		"🤣"
	}, {
		{":drooling_face:", ":drool:"},
		"🤤"
	}, {
		{":lying_face:", ":liar:"},
		"🤥"
	}, {
		{":sneezing_face:", ":sneeze:"},
		"🤧"
	}, {
		{":prince:"},
		"🤴",
		
	}, {
		{":man_in_tuxedo:"},
		"🤵",
		
	}, {
		{":mrs_claus:", ":mother_christmas:"},
		"🤶",
		
	}, {
		{":face_palm:", ":facepalm:"},
		"🤦",
		
	}, {
		{":shrug:"},
		"🤷",
		
	}, {
		{":pregnant_woman:", ":expecting_woman:"},
		"🤰",
		
	}, {
		{":selfie:"},
		"🤳",
		
	}, {
		{":man_dancing:", ":male_dancer:"},
		"🕺",
		
	}, {
		{":call_me:", ":call_me_hand:"},
		"🤙",
		
	}, {
		{":raised_back_of_hand:", ":back_of_hand:"},
		"🤚",
		
	}, {
		{":left_facing_fist:", ":left_fist:"},
		"🤛",
		
	}, {
		{":right_facing_fist:", ":right_fist:"},
		"🤜",
		
	}, {
		{":handshake:", ":shaking_hands:"},
		"🤝",
		
	}, {
		{":fingers_crossed:", ":hand_with_index_and_middle_finger_crossed:"},
		"🤞",
		
	},
	{
		{":dog:"},
		"🐶"
	}, {
		{":cat:"},
		"🐱"
	}, {
		{":mouse:"},
		"🐭"
	}, {
		{":hamster:"},
		"🐹"
	}, {
		{":rabbit:"},
		"🐰"
	}, {
		{":bear:"},
		"🐻"
	}, {
		{":panda_face:"},
		"🐼"
	}, {
		{":koala:"},
		"🐨"
	}, {
		{":tiger:"},
		"🐯"
	}, {
		{":lion_face:", ":lion:"},
		"🦁"
	}, {
		{":cow:"},
		"🐮"
	}, {
		{":pig:"},
		"🐷"
	}, {
		{":pig_nose:"},
		"🐽"
	}, {
		{":frog:"},
		"🐸"
	}, {
		{":octopus:"},
		"🐙"
	}, {
		{":monkey_face:"},
		"🐵"
	}, {
		{":see_no_evil:"},
		"🙈"
	}, {
		{":hear_no_evil:"},
		"🙉"
	}, {
		{":speak_no_evil:"},
		"🙊"
	}, {
		{":monkey:"},
		"🐒"
	}, {
		{":chicken:"},
		"🐔"
	}, {
		{":penguin:"},
		"🐧"
	}, {
		{":bird:"},
		"🐦"
	}, {
		{":baby_chick:"},
		"🐤"
	}, {
		{":hatching_chick:"},
		"🐣"
	}, {
		{":hatched_chick:"},
		"🐥"
	}, {
		{":wolf:"},
		"🐺"
	}, {
		{":boar:"},
		"🐗"
	}, {
		{":horse:"},
		"🐴"
	}, {
		{":unicorn:", ":unicorn_face:"},
		"🦄"
	}, {
		{":bee:"},
		"🐝"
	}, {
		{":bug:"},
		"🐛"
	}, {
		{":snail:"},
		"🐌"
	}, {
		{":beetle:"},
		"🐞"
	}, {
		{":ant:"},
		"🐜"
	}, {
		{":spider:"},
		"🕷"
	}, {
		{":scorpion:"},
		"🦂"
	}, {
		{":crab:"},
		"🦀"
	}, {
		{":snake:"},
		"🐍"
	}, {
		{":turtle:"},
		"🐢"
	}, {
		{":tropical_fish:"},
		"🐠"
	}, {
		{":fish:"},
		"🐟"
	}, {
		{":blowfish:"},
		"🐡"
	}, {
		{":dolphin:"},
		"🐬"
	}, {
		{":whale:"},
		"🐳"
	}, {
		{":whale2:"},
		"🐋"
	}, {
		{":crocodile:"},
		"🐊"
	}, {
		{":leopard:"},
		"🐆"
	}, {
		{":tiger2:"},
		"🐅"
	}, {
		{":water_buffalo:"},
		"🐃"
	}, {
		{":ox:"},
		"🐂"
	}, {
		{":cow2:"},
		"🐄"
	}, {
		{":dromedary_camel:"},
		"🐪"
	}, {
		{":camel:"},
		"🐫"
	}, {
		{":elephant:"},
		"🐘"
	}, {
		{":goat:"},
		"🐐"
	}, {
		{":ram:"},
		"🐏"
	}, {
		{":sheep:"},
		"🐑"
	}, {
		{":racehorse:"},
		"🐎"
	}, {
		{":pig2:"},
		"🐖"
	}, {
		{":rat:"},
		"🐀"
	}, {
		{":mouse2:"},
		"🐁"
	}, {
		{":rooster:"},
		"🐓"
	}, {
		{":turkey:"},
		"🦃"
	}, {
		{":dove:", ":dove_of_peace:"},
		"🕊"
	}, {
		{":dog2:"},
		"🐕"
	}, {
		{":poodle:"},
		"🐩"
	}, {
		{":cat2:"},
		"🐈"
	}, {
		{":rabbit2:"},
		"🐇"
	}, {
		{":chipmunk:"},
		"🐿"
	}, {
		{":feet:", ":paw_prints:"},
		"🐾"
	}, {
		{":dragon:"},
		"🐉"
	}, {
		{":dragon_face:"},
		"🐲"
	}, {
		{":cactus:"},
		"🌵"
	}, {
		{":christmas_tree:"},
		"🎄"
	}, {
		{":evergreen_tree:"},
		"🌲"
	}, {
		{":deciduous_tree:"},
		"🌳"
	}, {
		{":palm_tree:"},
		"🌴"
	}, {
		{":seedling:"},
		"🌱"
	}, {
		{":herb:"},
		"🌿"
	}, {
		{":shamrock:"},
		"☘"
	}, {
		{":four_leaf_clover:"},
		"🍀"
	}, {
		{":bamboo:"},
		"🎍"
	}, {
		{":tanabata_tree:"},
		"🎋"
	}, {
		{":leaves:"},
		"🍃"
	}, {
		{":fallen_leaf:"},
		"🍂"
	}, {
		{":maple_leaf:"},
		"🍁"
	}, {
		{":ear_of_rice:"},
		"🌾"
	}, {
		{":hibiscus:"},
		"🌺"
	}, {
		{":sunflower:"},
		"🌻"
	}, {
		{":rose:"},
		"🌹"
	}, {
		{":tulip:"},
		"🌷"
	}, {
		{":blossom:"},
		"🌼"
	}, {
		{":cherry_blossom:"},
		"🌸"
	}, {
		{":bouquet:"},
		"💐"
	}, {
		{":mushroom:"},
		"🍄"
	}, {
		{":chestnut:"},
		"🌰"
	}, {
		{":jack_o_lantern:"},
		"🎃"
	}, {
		{":shell:"},
		"🐚"
	}, {
		{":spider_web:"},
		"🕸"
	}, {
		{":earth_americas:"},
		"🌎"
	}, {
		{":earth_africa:"},
		"🌍"
	}, {
		{":earth_asia:"},
		"🌏"
	}, {
		{":full_moon:"},
		"🌕"
	}, {
		{":waning_gibbous_moon:"},
		"🌖"
	}, {
		{":last_quarter_moon:"},
		"🌗"
	}, {
		{":waning_crescent_moon:"},
		"🌘"
	}, {
		{":new_moon:"},
		"🌑"
	}, {
		{":waxing_crescent_moon:"},
		"🌒"
	}, {
		{":first_quarter_moon:"},
		"🌓"
	}, {
		{":waxing_gibbous_moon:"},
		"🌔"
	}, {
		{":new_moon_with_face:"},
		"🌚"
	}, {
		{":full_moon_with_face:"},
		"🌝"
	}, {
		{":first_quarter_moon_with_face:"},
		"🌛"
	}, {
		{":last_quarter_moon_with_face:"},
		"🌜"
	}, {
		{":sun_with_face:"},
		"🌞"
	}, {
		{":crescent_moon:"},
		"🌙"
	}, {
		{":star:"},
		"⭐"
	}, {
		{":star2:"},
		"🌟"
	}, {
		{":dizzy:"},
		"💫"
	}, {
		{":sparkles:"},
		"✨"
	}, {
		{":comet:"},
		"☄"
	}, {
		{":sunny:"},
		"☀"
	}, {
		{":white_sun_small_cloud:", ":white_sun_with_small_cloud:"},
		"🌤"
	}, {
		{":partly_sunny:"},
		"⛅"
	}, {
		{":white_sun_cloud:", ":white_sun_behind_cloud:"},
		"🌥"
	}, {
		{":white_sun_rain_cloud:", ":white_sun_behind_cloud_with_rain:"},
		"🌦"
	}, {
		{":cloud:"},
		"☁"
	}, {
		{":cloud_rain:", ":cloud_with_rain:"},
		"🌧"
	}, {
		{":thunder_cloud_rain:", ":thunder_cloud_and_rain:"},
		"⛈"
	}, {
		{":cloud_lightning:", ":cloud_with_lightning:"},
		"🌩"
	}, {
		{":zap:"},
		"⚡"
	}, {
		{":fire:", ":flame:"},
		"🔥"
	}, {
		{":boom:"},
		"💥"
	}, {
		{":snowflake:"},
		"❄"
	}, {
		{":cloud_snow:", ":cloud_with_snow:"},
		"🌨"
	}, {
		{":snowman2:"},
		"☃"
	}, {
		{":snowman:"},
		"⛄"
	}, {
		{":wind_blowing_face:"},
		"🌬"
	}, {
		{":dash:"},
		"💨"
	}, {
		{":cloud_tornado:", ":cloud_with_tornado:"},
		"🌪"
	}, {
		{":fog:"},
		"🌫"
	}, {
		{":umbrella2:"},
		"☂"
	}, {
		{":umbrella:"},
		"☔"
	}, {
		{":droplet:"},
		"💧"
	}, {
		{":sweat_drops:"},
		"💦"
	}, {
		{":ocean:"},
		"🌊"
	}, {
		{":eagle:"},
		"🦅"
	}, {
		{":duck:"},
		"🦆"
	}, {
		{":bat:"},
		"🦇"
	}, {
		{":shark:"},
		"🦈"
	}, {
		{":owl:"},
		"🦉"
	}, {
		{":fox:", ":fox_face:"},
		"🦊"
	}, {
		{":butterfly:"},
		"🦋"
	}, {
		{":deer:"},
		"🦌"
	}, {
		{":gorilla:"},
		"🦍"
	}, {
		{":lizard:"},
		"🦎"
	}, {
		{":rhino:", ":rhinoceros:"},
		"🦏"
	}, {
		{":wilted_rose:", ":wilted_flower:"},
		"🥀"
	}, {
		{":shrimp:"},
		"🦐"
	}, {
		{":squid:"},
		"🦑"
	},
	{
		{":green_apple:"},
		"🍏"
	}, {
		{":apple:"},
		"🍎"
	}, {
		{":pear:"},
		"🍐"
	}, {
		{":tangerine:"},
		"🍊"
	}, {
		{":lemon:"},
		"🍋"
	}, {
		{":banana:"},
		"🍌"
	}, {
		{":watermelon:"},
		"🍉"
	}, {
		{":grapes:"},
		"🍇"
	}, {
		{":strawberry:"},
		"🍓"
	}, {
		{":melon:"},
		"🍈"
	}, {
		{":cherries:"},
		"🍒"
	}, {
		{":peach:"},
		"🍑"
	}, {
		{":pineapple:"},
		"🍍"
	}, {
		{":tomato:"},
		"🍅"
	}, {
		{":eggplant:"},
		"🍆"
	}, {
		{":hot_pepper:"},
		"🌶"
	}, {
		{":corn:"},
		"🌽"
	}, {
		{":sweet_potato:"},
		"🍠"
	}, {
		{":honey_pot:"},
		"🍯"
	}, {
		{":bread:"},
		"🍞"
	}, {
		{":cheese:", ":cheese_wedge:"},
		"🧀"
	}, {
		{":poultry_leg:"},
		"🍗"
	}, {
		{":meat_on_bone:"},
		"🍖"
	}, {
		{":fried_shrimp:"},
		"🍤"
	}, {
		{":cooking:"},
		"🍳"
	}, {
		{":hamburger:"},
		"🍔"
	}, {
		{":fries:"},
		"🍟"
	}, {
		{":hotdog:", ":hot_dog:"},
		"🌭"
	}, {
		{":pizza:"},
		"🍕"
	}, {
		{":spaghetti:"},
		"🍝"
	}, {
		{":taco:"},
		"🌮"
	}, {
		{":burrito:"},
		"🌯"
	}, {
		{":ramen:"},
		"🍜"
	}, {
		{":stew:"},
		"🍲"
	}, {
		{":fish_cake:"},
		"🍥"
	}, {
		{":sushi:"},
		"🍣"
	}, {
		{":bento:"},
		"🍱"
	}, {
		{":curry:"},
		"🍛"
	}, {
		{":rice_ball:"},
		"🍙"
	}, {
		{":rice:"},
		"🍚"
	}, {
		{":rice_cracker:"},
		"🍘"
	}, {
		{":oden:"},
		"🍢"
	}, {
		{":dango:"},
		"🍡"
	}, {
		{":shaved_ice:"},
		"🍧"
	}, {
		{":ice_cream:"},
		"🍨"
	}, {
		{":icecream:"},
		"🍦"
	}, {
		{":cake:"},
		"🍰"
	}, {
		{":birthday:"},
		"🎂"
	}, {
		{":custard:", ":pudding:", ":flan:"},
		"🍮"
	}, {
		{":candy:"},
		"🍬"
	}, {
		{":lollipop:"},
		"🍭"
	}, {
		{":chocolate_bar:"},
		"🍫"
	}, {
		{":popcorn:"},
		"🍿"
	}, {
		{":doughnut:"},
		"🍩"
	}, {
		{":cookie:"},
		"🍪"
	}, {
		{":beer:"},
		"🍺"
	}, {
		{":beers:"},
		"🍻"
	}, {
		{":wine_glass:"},
		"🍷"
	}, {
		{":cocktail:"},
		"🍸"
	}, {
		{":tropical_drink:"},
		"🍹"
	}, {
		{":champagne:", ":bottle_with_popping_cork:"},
		"🍾"
	}, {
		{":sake:"},
		"🍶"
	}, {
		{":tea:"},
		"🍵"
	}, {
		{":coffee:"},
		"☕"
	}, {
		{":baby_bottle:"},
		"🍼"
	}, {
		{":fork_and_knife:"},
		"🍴"
	}, {
		{":fork_knife_plate:", ":fork_and_knife_with_plate:"},
		"🍽"
	}, {
		{":croissant:"},
		"🥐"
	}, {
		{":avocado:"},
		"🥑"
	}, {
		{":cucumber:"},
		"🥒"
	}, {
		{":bacon:"},
		"🥓"
	}, {
		{":potato:"},
		"🥔"
	}, {
		{":carrot:"},
		"🥕"
	}, {
		{":french_bread:", ":baguette_bread:"},
		"🥖"
	}, {
		{":salad:", ":green_salad:"},
		"🥗"
	}, {
		{":shallow_pan_of_food:", ":paella:"},
		"🥘"
	}, {
		{":stuffed_flatbread:", ":stuffed_pita:"},
		"🥙"
	}, {
		{":champagne_glass:", ":clinking_glass:"},
		"🥂"
	}, {
		{":tumbler_glass:", ":whisky:"},
		"🥃"
	}, {
		{":spoon:"},
		"🥄"
	}, {
		{":egg:"},
		"🥚"
	}, {
		{":milk:", ":glass_of_milk:"},
		"🥛"
	}, {
		{":peanuts:", ":shelled_peanut:"},
		"🥜"
	}, {
		{":kiwi:", ":kiwifruit:"},
		"🥝"
	}, {
		{":pancakes:"},
		"🥞"
	},
	{
		{":soccer:"},
		"⚽"
	}, {
		{":basketball:"},
		"🏀"
	}, {
		{":football:"},
		"🏈"
	}, {
		{":baseball:"},
		"⚾"
	}, {
		{":tennis:"},
		"🎾"
	}, {
		{":volleyball:"},
		"🏐"
	}, {
		{":rugby_football:"},
		"🏉"
	}, {
		{":8ball:"},
		"🎱"
	}, {
		{":golf:"},
		"⛳"
	}, {
		{":golfer:"},
		"🏌"
	}, {
		{":ping_pong:", ":table_tennis:"},
		"🏓"
	}, {
		{":badminton:"},
		"🏸"
	}, {
		{":hockey:"},
		"🏒"
	}, {
		{":field_hockey:"},
		"🏑"
	}, {
		{":cricket:", ":cricket_bat_ball:"},
		"🏏"
	}, {
		{":ski:"},
		"🎿"
	}, {
		{":skier:"},
		"⛷"
	}, {
		{":snowboarder:"},
		"🏂",
		
	}, {
		{":ice_skate:"},
		"⛸"
	}, {
		{":bow_and_arrow:", ":archery:"},
		"🏹"
	}, {
		{":fishing_pole_and_fish:"},
		"🎣"
	}, {
		{":rowboat:"},
		"🚣",
		
	}, {
		{":swimmer:"},
		"🏊",
		
	}, {
		{":surfer:"},
		"🏄",
		
	}, {
		{":bath:"},
		"🛀",
		
	}, {
		{":basketball_player:", ":person_with_ball:"},
		"⛹",
		
	}, {
		{":lifter:", ":weight_lifter:"},
		"🏋",
		
	}, {
		{":bicyclist:"},
		"🚴",
		
	}, {
		{":mountain_bicyclist:"},
		"🚵",
		
	}, {
		{":horse_racing:"},
		"🏇",
		
	}, {
		{":levitate:", ":man_in_business_suit_levitating:"},
		"🕴"
	}, {
		{":trophy:"},
		"🏆"
	}, {
		{":running_shirt_with_sash:"},
		"🎽"
	}, {
		{":medal:", ":sports_medal:"},
		"🏅"
	}, {
		{":military_medal:"},
		"🎖"
	}, {
		{":reminder_ribbon:"},
		"🎗"
	}, {
		{":rosette:"},
		"🏵"
	}, {
		{":ticket:"},
		"🎫"
	}, {
		{":tickets:", ":admission_tickets:"},
		"🎟"
	}, {
		{":performing_arts:"},
		"🎭"
	}, {
		{":art:"},
		"🎨"
	}, {
		{":circus_tent:"},
		"🎪"
	}, {
		{":microphone:"},
		"🎤"
	}, {
		{":headphones:"},
		"🎧"
	}, {
		{":musical_score:"},
		"🎼"
	}, {
		{":musical_keyboard:"},
		"🎹"
	}, {
		{":saxophone:"},
		"🎷"
	}, {
		{":trumpet:"},
		"🎺"
	}, {
		{":guitar:"},
		"🎸"
	}, {
		{":violin:"},
		"🎻"
	}, {
		{":clapper:"},
		"🎬"
	}, {
		{":video_game:"},
		"🎮"
	}, {
		{":space_invader:"},
		"👾"
	}, {
		{":dart:"},
		"🎯"
	}, {
		{":game_die:"},
		"🎲"
	}, {
		{":slot_machine:"},
		"🎰"
	}, {
		{":bowling:"},
		"🎳"
	}, {
		{":cartwheel:", ":person_doing_cartwheel:"},
		"🤸",
		
	}, {
		{":juggling:", ":juggler:"},
		"🤹",
		
	}, {
		{":wrestlers:", ":wrestling:"},
		"🤼",
		
	}, {
		{":boxing_glove:", ":boxing_gloves:"},
		"🥊"
	}, {
		{":martial_arts_uniform:", ":karate_uniform:"},
		"🥋"
	}, {
		{":water_polo:"},
		"🤽",
		
	}, {
		{":handball:"},
		"🤾",
		
	}, {
		{":goal:", ":goal_net:"},
		"🥅"
	}, {
		{":fencer:", ":fencing:"},
		"🤺"
	}, {
		{":first_place:", ":first_place_medal:"},
		"🥇"
	}, {
		{":second_place:", ":second_place_medal:"},
		"🥈"
	}, {
		{":third_place:", ":third_place_medal:"},
		"🥉"
	}, {
		{":drum:", ":drum_with_drumsticks:"},
		"🥁"
	},
	{
		{":red_car:"},
		"🚗"
	}, {
		{":taxi:"},
		"🚕"
	}, {
		{":blue_car:"},
		"🚙"
	}, {
		{":bus:"},
		"🚌"
	}, {
		{":trolleybus:"},
		"🚎"
	}, {
		{":race_car:", ":racing_car:"},
		"🏎"
	}, {
		{":police_car:"},
		"🚓"
	}, {
		{":ambulance:"},
		"🚑"
	}, {
		{":fire_engine:"},
		"🚒"
	}, {
		{":minibus:"},
		"🚐"
	}, {
		{":truck:"},
		"🚚"
	}, {
		{":articulated_lorry:"},
		"🚛"
	}, {
		{":tractor:"},
		"🚜"
	}, {
		{":motorcycle:", ":racing_motorcycle:"},
		"🏍"
	}, {
		{":bike:"},
		"🚲"
	}, {
		{":rotating_light:"},
		"🚨"
	}, {
		{":oncoming_police_car:"},
		"🚔"
	}, {
		{":oncoming_bus:"},
		"🚍"
	}, {
		{":oncoming_automobile:"},
		"🚘"
	}, {
		{":oncoming_taxi:"},
		"🚖"
	}, {
		{":aerial_tramway:"},
		"🚡"
	}, {
		{":mountain_cableway:"},
		"🚠"
	}, {
		{":suspension_railway:"},
		"🚟"
	}, {
		{":railway_car:"},
		"🚃"
	}, {
		{":train:"},
		"🚋"
	}, {
		{":monorail:"},
		"🚝"
	}, {
		{":bullettrain_side:"},
		"🚄"
	}, {
		{":bullettrain_front:"},
		"🚅"
	}, {
		{":light_rail:"},
		"🚈"
	}, {
		{":mountain_railway:"},
		"🚞"
	}, {
		{":steam_locomotive:"},
		"🚂"
	}, {
		{":train2:"},
		"🚆"
	}, {
		{":metro:"},
		"🚇"
	}, {
		{":tram:"},
		"🚊"
	}, {
		{":station:"},
		"🚉"
	}, {
		{":helicopter:"},
		"🚁"
	}, {
		{":airplane_small:", ":small_airplane:"},
		"🛩"
	}, {
		{":airplane:"},
		"✈"
	}, {
		{":airplane_departure:"},
		"🛫"
	}, {
		{":airplane_arriving:"},
		"🛬"
	}, {
		{":sailboat:"},
		"⛵"
	}, {
		{":motorboat:"},
		"🛥"
	}, {
		{":speedboat:"},
		"🚤"
	}, {
		{":ferry:"},
		"⛴"
	}, {
		{":cruise_ship:", ":passenger_ship:"},
		"🛳"
	}, {
		{":rocket:"},
		"🚀"
	}, {
		{":satellite_orbital:"},
		"🛰"
	}, {
		{":seat:"},
		"💺"
	}, {
		{":anchor:"},
		"⚓"
	}, {
		{":construction:"},
		"🚧"
	}, {
		{":fuelpump:"},
		"⛽"
	}, {
		{":busstop:"},
		"🚏"
	}, {
		{":vertical_traffic_light:"},
		"🚦"
	}, {
		{":traffic_light:"},
		"🚥"
	}, {
		{":checkered_flag:"},
		"🏁"
	}, {
		{":ship:"},
		"🚢"
	}, {
		{":ferris_wheel:"},
		"🎡"
	}, {
		{":roller_coaster:"},
		"🎢"
	}, {
		{":carousel_horse:"},
		"🎠"
	}, {
		{":construction_site:", ":building_construction:"},
		"🏗"
	}, {
		{":foggy:"},
		"🌁"
	}, {
		{":tokyo_tower:"},
		"🗼"
	}, {
		{":factory:"},
		"🏭"
	}, {
		{":fountain:"},
		"⛲"
	}, {
		{":rice_scene:"},
		"🎑"
	}, {
		{":mountain:"},
		"⛰"
	}, {
		{":mountain_snow:", ":snow_capped_mountain:"},
		"🏔"
	}, {
		{":mount_fuji:"},
		"🗻"
	}, {
		{":volcano:"},
		"🌋"
	}, {
		{":japan:"},
		"🗾"
	}, {
		{":camping:"},
		"🏕"
	}, {
		{":tent:"},
		"⛺"
	}, {
		{":park:", ":national_park:"},
		"🏞"
	}, {
		{":motorway:"},
		"🛣"
	}, {
		{":railway_track:", ":railroad_track:"},
		"🛤"
	}, {
		{":sunrise:"},
		"🌅"
	}, {
		{":sunrise_over_mountains:"},
		"🌄"
	}, {
		{":desert:"},
		"🏜"
	}, {
		{":beach:", ":beach_with_umbrella:"},
		"🏖"
	}, {
		{":island:", ":desert_island:"},
		"🏝"
	}, {
		{":city_sunset:", ":city_sunrise:"},
		"🌇"
	}, {
		{":city_dusk:"},
		"🌆"
	}, {
		{":cityscape:"},
		"🏙"
	}, {
		{":night_with_stars:"},
		"🌃"
	}, {
		{":bridge_at_night:"},
		"🌉"
	}, {
		{":milky_way:"},
		"🌌"
	}, {
		{":stars:"},
		"🌠"
	}, {
		{":sparkler:"},
		"🎇"
	}, {
		{":fireworks:"},
		"🎆"
	}, {
		{":rainbow:"},
		"🌈"
	}, {
		{":homes:", ":house_buildings:"},
		"🏘"
	}, {
		{":european_castle:"},
		"🏰"
	}, {
		{":japanese_castle:"},
		"🏯"
	}, {
		{":stadium:"},
		"🏟"
	}, {
		{":statue_of_liberty:"},
		"🗽"
	}, {
		{":house:"},
		"🏠"
	}, {
		{":house_with_garden:"},
		"🏡"
	}, {
		{":house_abandoned:", ":derelict_house_building:"},
		"🏚"
	}, {
		{":office:"},
		"🏢"
	}, {
		{":department_store:"},
		"🏬"
	}, {
		{":post_office:"},
		"🏣"
	}, {
		{":european_post_office:"},
		"🏤"
	}, {
		{":hospital:"},
		"🏥"
	}, {
		{":bank:"},
		"🏦"
	}, {
		{":hotel:"},
		"🏨"
	}, {
		{":convenience_store:"},
		"🏪"
	}, {
		{":school:"},
		"🏫"
	}, {
		{":love_hotel:"},
		"🏩"
	}, {
		{":wedding:"},
		"💒"
	}, {
		{":classical_building:"},
		"🏛"
	}, {
		{":church:"},
		"⛪"
	}, {
		{":mosque:"},
		"🕌"
	}, {
		{":synagogue:"},
		"🕍"
	}, {
		{":kaaba:"},
		"🕋"
	}, {
		{":shinto_shrine:"},
		"⛩"
	}, {
		{":scooter:"},
		"🛴"
	}, {
		{":motor_scooter:", ":motorbike:"},
		"🛵"
	}, {
		{":canoe:", ":kayak:"},
		"🛶"
	},
	{
		{":watch:"},
		"⌚"
	}, {
		{":iphone:"},
		"📱"
	}, {
		{":calling:"},
		"📲"
	}, {
		{":computer:"},
		"💻"
	}, {
		{":keyboard:"},
		"⌨"
	}, {
		{":desktop:", ":desktop_computer:"},
		"🖥"
	}, {
		{":printer:"},
		"🖨"
	}, {
		{":mouse_three_button:", ":three_button_mouse:"},
		"🖱"
	}, {
		{":trackball:"},
		"🖲"
	}, {
		{":joystick:"},
		"🕹"
	}, {
		{":compression:"},
		"🗜"
	}, {
		{":minidisc:"},
		"💽"
	}, {
		{":floppy_disk:"},
		"💾"
	}, {
		{":cd:"},
		"💿"
	}, {
		{":dvd:"},
		"📀"
	}, {
		{":vhs:"},
		"📼"
	}, {
		{":camera:"},
		"📷"
	}, {
		{":camera_with_flash:"},
		"📸"
	}, {
		{":video_camera:"},
		"📹"
	}, {
		{":movie_camera:"},
		"🎥"
	}, {
		{":projector:", ":film_projector:"},
		"📽"
	}, {
		{":film_frames:"},
		"🎞"
	}, {
		{":telephone_receiver:"},
		"📞"
	}, {
		{":telephone:"},
		"☎"
	}, {
		{":pager:"},
		"📟"
	}, {
		{":fax:"},
		"📠"
	}, {
		{":tv:"},
		"📺"
	}, {
		{":radio:"},
		"📻"
	}, {
		{":microphone2:", ":studio_microphone:"},
		"🎙"
	}, {
		{":level_slider:"},
		"🎚"
	}, {
		{":control_knobs:"},
		"🎛"
	}, {
		{":stopwatch:"},
		"⏱"
	}, {
		{":timer:", ":timer_clock:"},
		"⏲"
	}, {
		{":alarm_clock:"},
		"⏰"
	}, {
		{":clock:", ":mantlepiece_clock:"},
		"🕰"
	}, {
		{":hourglass_flowing_sand:"},
		"⏳"
	}, {
		{":hourglass:"},
		"⌛"
	}, {
		{":satellite:"},
		"📡"
	}, {
		{":battery:"},
		"🔋"
	}, {
		{":electric_plug:"},
		"🔌"
	}, {
		{":bulb:"},
		"💡"
	}, {
		{":flashlight:"},
		"🔦"
	}, {
		{":candle:"},
		"🕯"
	}, {
		{":wastebasket:"},
		"🗑"
	}, {
		{":oil:", ":oil_drum:"},
		"🛢"
	}, {
		{":money_with_wings:"},
		"💸"
	}, {
		{":dollar:"},
		"💵"
	}, {
		{":yen:"},
		"💴"
	}, {
		{":euro:"},
		"💶"
	}, {
		{":pound:"},
		"💷"
	}, {
		{":moneybag:"},
		"💰"
	}, {
		{":credit_card:"},
		"💳"
	}, {
		{":gem:"},
		"💎"
	}, {
		{":scales:"},
		"⚖"
	}, {
		{":wrench:"},
		"🔧"
	}, {
		{":hammer:"},
		"🔨"
	}, {
		{":hammer_pick:", ":hammer_and_pick:"},
		"⚒"
	}, {
		{":tools:", ":hammer_and_wrench:"},
		"🛠"
	}, {
		{":pick:"},
		"⛏"
	}, {
		{":nut_and_bolt:"},
		"🔩"
	}, {
		{":gear:"},
		"⚙"
	}, {
		{":chains:"},
		"⛓"
	}, {
		{":gun:"},
		"🔫"
	}, {
		{":bomb:"},
		"💣"
	}, {
		{":knife:"},
		"🔪"
	}, {
		{":dagger:", ":dagger_knife:"},
		"🗡"
	}, {
		{":crossed_swords:"},
		"⚔"
	}, {
		{":shield:"},
		"🛡"
	}, {
		{":smoking:"},
		"🚬"
	}, {
		{":skull_crossbones:", ":skull_and_crossbones:"},
		"☠"
	}, {
		{":coffin:"},
		"⚰"
	}, {
		{":urn:", ":funeral_urn:"},
		"⚱"
	}, {
		{":amphora:"},
		"🏺"
	}, {
		{":crystal_ball:"},
		"🔮"
	}, {
		{":prayer_beads:"},
		"📿"
	}, {
		{":barber:"},
		"💈"
	}, {
		{":alembic:"},
		"⚗"
	}, {
		{":telescope:"},
		"🔭"
	}, {
		{":microscope:"},
		"🔬"
	}, {
		{":hole:"},
		"🕳"
	}, {
		{":pill:"},
		"💊"
	}, {
		{":syringe:"},
		"💉"
	}, {
		{":thermometer:"},
		"🌡"
	}, {
		{":label:"},
		"🏷"
	}, {
		{":bookmark:"},
		"🔖"
	}, {
		{":toilet:"},
		"🚽"
	}, {
		{":shower:"},
		"🚿"
	}, {
		{":bathtub:"},
		"🛁"
	}, {
		{":key:"},
		"🔑"
	}, {
		{":key2:", ":old_key:"},
		"🗝"
	}, {
		{":couch:", ":couch_and_lamp:"},
		"🛋"
	}, {
		{":sleeping_accommodation:"},
		"🛌"
	}, {
		{":bed:"},
		"🛏"
	}, {
		{":door:"},
		"🚪"
	}, {
		{":bellhop:", ":bellhop_bell:"},
		"🛎"
	}, {
		{":frame_photo:", ":frame_with_picture:"},
		"🖼"
	}, {
		{":map:", ":world_map:"},
		"🗺"
	}, {
		{":beach_umbrella:", ":umbrella_on_ground:"},
		"⛱"
	}, {
		{":moyai:"},
		"🗿"
	}, {
		{":shopping_bags:"},
		"🛍"
	}, {
		{":balloon:"},
		"🎈"
	}, {
		{":flags:"},
		"🎏"
	}, {
		{":ribbon:"},
		"🎀"
	}, {
		{":gift:"},
		"🎁"
	}, {
		{":confetti_ball:"},
		"🎊"
	}, {
		{":tada:"},
		"🎉"
	}, {
		{":dolls:"},
		"🎎"
	}, {
		{":wind_chime:"},
		"🎐"
	}, {
		{":crossed_flags:"},
		"🎌"
	}, {
		{":izakaya_lantern:"},
		"🏮"
	}, {
		{":envelope:"},
		"✉"
	}, {
		{":envelope_with_arrow:"},
		"📩"
	}, {
		{":incoming_envelope:"},
		"📨"
	}, {
		{":e_mail:", ":email:"},
		"📧"
	}, {
		{":love_letter:"},
		"💌"
	}, {
		{":postbox:"},
		"📮"
	}, {
		{":mailbox_closed:"},
		"📪"
	}, {
		{":mailbox:"},
		"📫"
	}, {
		{":mailbox_with_mail:"},
		"📬"
	}, {
		{":mailbox_with_no_mail:"},
		"📭"
	}, {
		{":package:"},
		"📦"
	}, {
		{":postal_horn:"},
		"📯"
	}, {
		{":inbox_tray:"},
		"📥"
	}, {
		{":outbox_tray:"},
		"📤"
	}, {
		{":scroll:"},
		"📜"
	}, {
		{":page_with_curl:"},
		"📃"
	}, {
		{":bookmark_tabs:"},
		"📑"
	}, {
		{":bar_chart:"},
		"📊"
	}, {
		{":chart_with_upwards_trend:"},
		"📈"
	}, {
		{":chart_with_downwards_trend:"},
		"📉"
	}, {
		{":page_facing_up:"},
		"📄"
	}, {
		{":date:"},
		"📅"
	}, {
		{":calendar:"},
		"📆"
	}, {
		{":calendar_spiral:", ":spiral_calendar_pad:"},
		"🗓"
	}, {
		{":card_index:"},
		"📇"
	}, {
		{":card_box:", ":card_file_box:"},
		"🗃"
	}, {
		{":ballot_box:", ":ballot_box_with_ballot:"},
		"🗳"
	}, {
		{":file_cabinet:"},
		"🗄"
	}, {
		{":clipboard:"},
		"📋"
	}, {
		{":notepad_spiral:", ":spiral_note_pad:"},
		"🗒"
	}, {
		{":file_folder:"},
		"📁"
	}, {
		{":open_file_folder:"},
		"📂"
	}, {
		{":dividers:", ":card_index_dividers:"},
		"🗂"
	}, {
		{":newspaper2:", ":rolled_up_newspaper:"},
		"🗞"
	}, {
		{":newspaper:"},
		"📰"
	}, {
		{":notebook:"},
		"📓"
	}, {
		{":closed_book:"},
		"📕"
	}, {
		{":green_book:"},
		"📗"
	}, {
		{":blue_book:"},
		"📘"
	}, {
		{":orange_book:"},
		"📙"
	}, {
		{":notebook_with_decorative_cover:"},
		"📔"
	}, {
		{":ledger:"},
		"📒"
	}, {
		{":books:"},
		"📚"
	}, {
		{":book:"},
		"📖"
	}, {
		{":link:"},
		"🔗"
	}, {
		{":paperclip:"},
		"📎"
	}, {
		{":paperclips:", ":linked_paperclips:"},
		"🖇"
	}, {
		{":scissors:"},
		"✂"
	}, {
		{":triangular_ruler:"},
		"📐"
	}, {
		{":straight_ruler:"},
		"📏"
	}, {
		{":pushpin:"},
		"📌"
	}, {
		{":round_pushpin:"},
		"📍"
	}, {
		{":triangular_flag_on_post:"},
		"🚩"
	}, {
		{":flag_white:"},
		"🏳"
	}, {
		{":flag_black:"},
		"🏴"
	}, {
		{":closed_lock_with_key:"},
		"🔐"
	}, {
		{":lock:"},
		"🔒"
	}, {
		{":unlock:"},
		"🔓"
	}, {
		{":lock_with_ink_pen:"},
		"🔏"
	}, {
		{":pen_ballpoint:", ":lower_left_ballpoint_pen:"},
		"🖊"
	}, {
		{":pen_fountain:", ":lower_left_fountain_pen:"},
		"🖋"
	}, {
		{":black_nib:"},
		"✒"
	}, {
		{":pencil:"},
		"📝"
	}, {
		{":pencil2:"},
		"✏"
	}, {
		{":crayon:", ":lower_left_crayon:"},
		"🖍"
	}, {
		{":paintbrush:", ":lower_left_paintbrush:"},
		"🖌"
	}, {
		{":mag:"},
		"🔍"
	}, {
		{":mag_right:"},
		"🔎"
	}, {
		{":shopping_cart:", ":shopping_trolley:"},
		"🛒"
	},
	{
		{":100:"},
		"💯"
	}, {
		{":1234:"},
		"🔢"
	}, {
		{":heart:"},
		"❤"
	}, {
		{":yellow_heart:"},
		"💛"
	}, {
		{":green_heart:"},
		"💚"
	}, {
		{":blue_heart:"},
		"💙"
	}, {
		{":purple_heart:"},
		"💜"
	}, {
		{":broken_heart:"},
		"💔"
	}, {
		{":heart_exclamation:", ":heavy_heart_exclamation_mark_ornament:"},
		"❣"
	}, {
		{":two_hearts:"},
		"💕"
	}, {
		{":revolving_hearts:"},
		"💞"
	}, {
		{":heartbeat:"},
		"💓"
	}, {
		{":heartpulse:"},
		"💗"
	}, {
		{":sparkling_heart:"},
		"💖"
	}, {
		{":cupid:"},
		"💘"
	}, {
		{":gift_heart:"},
		"💝"
	}, {
		{":heart_decoration:"},
		"💟"
	}, {
		{":peace:", ":peace_symbol:"},
		"☮"
	}, {
		{":cross:", ":latin_cross:"},
		"✝"
	}, {
		{":star_and_crescent:"},
		"☪"
	}, {
		{":om_symbol:"},
		"🕉"
	}, {
		{":wheel_of_dharma:"},
		"☸"
	}, {
		{":star_of_david:"},
		"✡"
	}, {
		{":six_pointed_star:"},
		"🔯"
	}, {
		{":menorah:"},
		"🕎"
	}, {
		{":yin_yang:"},
		"☯"
	}, {
		{":orthodox_cross:"},
		"☦"
	}, {
		{":place_of_worship:", ":worship_symbol:"},
		"🛐"
	}, {
		{":ophiuchus:"},
		"⛎"
	}, {
		{":aries:"},
		"♈"
	}, {
		{":taurus:"},
		"♉"
	}, {
		{":gemini:"},
		"♊"
	}, {
		{":cancer:"},
		"♋"
	}, {
		{":leo:"},
		"♌"
	}, {
		{":virgo:"},
		"♍"
	}, {
		{":libra:"},
		"♎"
	}, {
		{":scorpius:"},
		"♏"
	}, {
		{":sagittarius:"},
		"♐"
	}, {
		{":capricorn:"},
		"♑"
	}, {
		{":aquarius:"},
		"♒"
	}, {
		{":pisces:"},
		"♓"
	}, {
		{":id:"},
		"🆔"
	}, {
		{":atom:", ":atom_symbol:"},
		"⚛"
	}, {
		{":u7a7a:"},
		"🈳"
	}, {
		{":u5272:"},
		"🈹"
	}, {
		{":radioactive:", ":radioactive_sign:"},
		"☢"
	}, {
		{":biohazard:", ":biohazard_sign:"},
		"☣"
	}, {
		{":mobile_phone_off:"},
		"📴"
	}, {
		{":vibration_mode:"},
		"📳"
	}, {
		{":u6709:"},
		"🈶"
	}, {
		{":u7121:"},
		"🈚"
	}, {
		{":u7533:"},
		"🈸"
	}, {
		{":u55b6:"},
		"🈺"
	}, {
		{":u6708:"},
		"🈷"
	}, {
		{":eight_pointed_black_star:"},
		"✴"
	}, {
		{":vs:"},
		"🆚"
	}, {
		{":accept:"},
		"🉑"
	}, {
		{":white_flower:"},
		"💮"
	}, {
		{":ideograph_advantage:"},
		"🉐"
	}, {
		{":secret:"},
		"㊙"
	}, {
		{":congratulations:"},
		"㊗"
	}, {
		{":u5408:"},
		"🈴"
	}, {
		{":u6e80:"},
		"🈵"
	}, {
		{":u7981:"},
		"🈲"
	}, {
		{":a:"},
		"🅰"
	}, {
		{":b:"},
		"🅱"
	}, {
		{":ab:"},
		"🆎"
	}, {
		{":cl:"},
		"🆑"
	}, {
		{":o2:"},
		"🅾"
	}, {
		{":sos:"},
		"🆘"
	}, {
		{":no_entry:"},
		"⛔"
	}, {
		{":name_badge:"},
		"📛"
	}, {
		{":no_entry_sign:"},
		"🚫"
	}, {
		{":x:"},
		"❌"
	}, {
		{":o:"},
		"⭕"
	}, {
		{":anger:"},
		"💢"
	}, {
		{":hotsprings:"},
		"♨"
	}, {
		{":no_pedestrians:"},
		"🚷"
	}, {
		{":do_not_litter:"},
		"🚯"
	}, {
		{":no_bicycles:"},
		"🚳"
	}, {
		{":non_potable_water:"},
		"🚱"
	}, {
		{":underage:"},
		"🔞"
	}, {
		{":no_mobile_phones:"},
		"📵"
	}, {
		{":exclamation:"},
		"❗"
	}, {
		{":grey_exclamation:"},
		"❕"
	}, {
		{":question:"},
		"❓"
	}, {
		{":grey_question:"},
		"❔"
	}, {
		{":bangbang:"},
		"‼"
	}, {
		{":interrobang:"},
		"⁉"
	}, {
		{":low_brightness:"},
		"🔅"
	}, {
		{":high_brightness:"},
		"🔆"
	}, {
		{":trident:"},
		"🔱"
	}, {
		{":fleur_de_lis:"},
		"⚜"
	}, {
		{":part_alternation_mark:"},
		"〽"
	}, {
		{":warning:"},
		"⚠"
	}, {
		{":children_crossing:"},
		"🚸"
	}, {
		{":beginner:"},
		"🔰"
	}, {
		{":recycle:"},
		"♻"
	}, {
		{":u6307:"},
		"🈯"
	}, {
		{":chart:"},
		"💹"
	}, {
		{":sparkle:"},
		"❇"
	}, {
		{":eight_spoked_asterisk:"},
		"✳"
	}, {
		{":negative_squared_cross_mark:"},
		"❎"
	}, {
		{":white_check_mark:"},
		"✅"
	}, {
		{":diamond_shape_with_a_dot_inside:"},
		"💠"
	}, {
		{":cyclone:"},
		"🌀"
	}, {
		{":loop:"},
		"➿"
	}, {
		{":globe_with_meridians:"},
		"🌐"
	}, {
		{":m:"},
		"Ⓜ"
	}, {
		{":atm:"},
		"🏧"
	}, {
		{":sa:"},
		"🈂"
	}, {
		{":passport_control:"},
		"🛂"
	}, {
		{":customs:"},
		"🛃"
	}, {
		{":baggage_claim:"},
		"🛄"
	}, {
		{":left_luggage:"},
		"🛅"
	}, {
		{":wheelchair:"},
		"♿"
	}, {
		{":no_smoking:"},
		"🚭"
	}, {
		{":wc:"},
		"🚾"
	}, {
		{":parking:"},
		"🅿"
	}, {
		{":potable_water:"},
		"🚰"
	}, {
		{":mens:"},
		"🚹"
	}, {
		{":womens:"},
		"🚺"
	}, {
		{":baby_symbol:"},
		"🚼"
	}, {
		{":restroom:"},
		"🚻"
	}, {
		{":put_litter_in_its_place:"},
		"🚮"
	}, {
		{":cinema:"},
		"🎦"
	}, {
		{":signal_strength:"},
		"📶"
	}, {
		{":koko:"},
		"🈁"
	}, {
		{":ng:"},
		"🆖"
	}, {
		{":ok:"},
		"🆗"
	}, {
		{":up:"},
		"🆙"
	}, {
		{":cool:"},
		"🆒"
	}, {
		{":new:"},
		"🆕"
	}, {
		{":free:"},
		"🆓"
	}, {
		{":zero:"},
		"0⃣"
	}, {
		{":one:"},
		"1⃣"
	}, {
		{":two:"},
		"2⃣"
	}, {
		{":three:"},
		"3⃣"
	}, {
		{":four:"},
		"4⃣"
	}, {
		{":five:"},
		"5⃣"
	}, {
		{":six:"},
		"6⃣"
	}, {
		{":seven:"},
		"7⃣"
	}, {
		{":eight:"},
		"8⃣"
	}, {
		{":nine:"},
		"9⃣"
	}, {
		{":keycap_ten:"},
		"🔟"
	}, {
		{":arrow_forward:"},
		"▶"
	}, {
		{":pause_button:", ":double_vertical_bar:"},
		"⏸"
	}, {
		{":play_pause:"},
		"⏯"
	}, {
		{":stop_button:"},
		"⏹"
	}, {
		{":record_button:"},
		"⏺"
	}, {
		{":track_next:", ":next_track:"},
		"⏭"
	}, {
		{":track_previous:", ":previous_track:"},
		"⏮"
	}, {
		{":fast_forward:"},
		"⏩"
	}, {
		{":rewind:"},
		"⏪"
	}, {
		{":twisted_rightwards_arrows:"},
		"🔀"
	}, {
		{":repeat:"},
		"🔁"
	}, {
		{":repeat_one:"},
		"🔂"
	}, {
		{":arrow_backward:"},
		"◀"
	}, {
		{":arrow_up_small:"},
		"🔼"
	}, {
		{":arrow_down_small:"},
		"🔽"
	}, {
		{":arrow_double_up:"},
		"⏫"
	}, {
		{":arrow_double_down:"},
		"⏬"
	}, {
		{":arrow_right:"},
		"➡"
	}, {
		{":arrow_left:"},
		"⬅"
	}, {
		{":arrow_up:"},
		"⬆"
	}, {
		{":arrow_down:"},
		"⬇"
	}, {
		{":arrow_upper_right:"},
		"↗"
	}, {
		{":arrow_lower_right:"},
		"↘"
	}, {
		{":arrow_lower_left:"},
		"↙"
	}, {
		{":arrow_upper_left:"},
		"↖"
	}, {
		{":arrow_up_down:"},
		"↕"
	}, {
		{":left_right_arrow:"},
		"↔"
	}, {
		{":arrows_counterclockwise:"},
		"🔄"
	}, {
		{":arrow_right_hook:"},
		"↪"
	}, {
		{":leftwards_arrow_with_hook:"},
		"↩"
	}, {
		{":arrow_heading_up:"},
		"⤴"
	}, {
		{":arrow_heading_down:"},
		"⤵"
	}, {
		{":hash:"},
		"#⃣"
	}, {
		{":asterisk:", ":keycap_asterisk:"},
		"*⃣"
	}, {
		{":information_source:"},
		"ℹ"
	}, {
		{":abc:"},
		"🔤"
	}, {
		{":abcd:"},
		"🔡"
	}, {
		{":capital_abcd:"},
		"🔠"
	}, {
		{":symbols:"},
		"🔣"
	}, {
		{":musical_note:"},
		"🎵"
	}, {
		{":notes:"},
		"🎶"
	}, {
		{":wavy_dash:"},
		"〰"
	}, {
		{":curly_loop:"},
		"➰"
	}, {
		{":heavy_check_mark:"},
		"✔"
	}, {
		{":arrows_clockwise:"},
		"🔃"
	}, {
		{":heavy_plus_sign:"},
		"➕"
	}, {
		{":heavy_minus_sign:"},
		"➖"
	}, {
		{":heavy_division_sign:"},
		"➗"
	}, {
		{":heavy_multiplication_x:"},
		"✖"
	}, {
		{":heavy_dollar_sign:"},
		"💲"
	}, {
		{":currency_exchange:"},
		"💱"
	}, {
		{":copyright:"},
		"©"
	}, {
		{":registered:"},
		"®"
	}, {
		{":tm:"},
		"™"
	}, {
		{":end:"},
		"🔚"
	}, {
		{":back:"},
		"🔙"
	}, {
		{":on:"},
		"🔛"
	}, {
		{":top:"},
		"🔝"
	}, {
		{":soon:"},
		"🔜"
	}, {
		{":ballot_box_with_check:"},
		"☑"
	}, {
		{":radio_button:"},
		"🔘"
	}, {
		{":white_circle:"},
		"⚪"
	}, {
		{":black_circle:"},
		"⚫"
	}, {
		{":red_circle:"},
		"🔴"
	}, {
		{":large_blue_circle:"},
		"🔵"
	}, {
		{":small_orange_diamond:"},
		"🔸"
	}, {
		{":small_blue_diamond:"},
		"🔹"
	}, {
		{":large_orange_diamond:"},
		"🔶"
	}, {
		{":large_blue_diamond:"},
		"🔷"
	}, {
		{":small_red_triangle:"},
		"🔺"
	}, {
		{":black_small_square:"},
		"▪"
	}, {
		{":white_small_square:"},
		"▫"
	}, {
		{":black_large_square:"},
		"⬛"
	}, {
		{":white_large_square:"},
		"⬜"
	}, {
		{":small_red_triangle_down:"},
		"🔻"
	}, {
		{":black_medium_square:"},
		"◼"
	}, {
		{":white_medium_square:"},
		"◻"
	}, {
		{":black_medium_small_square:"},
		"◾"
	}, {
		{":white_medium_small_square:"},
		"◽"
	}, {
		{":black_square_button:"},
		"🔲"
	}, {
		{":white_square_button:"},
		"🔳"
	}, {
		{":speaker:"},
		"🔈"
	}, {
		{":sound:"},
		"🔉"
	}, {
		{":loud_sound:"},
		"🔊"
	}, {
		{":mute:"},
		"🔇"
	}, {
		{":mega:"},
		"📣"
	}, {
		{":loudspeaker:"},
		"📢"
	}, {
		{":bell:"},
		"🔔"
	}, {
		{":no_bell:"},
		"🔕"
	}, {
		{":black_joker:"},
		"🃏"
	}, {
		{":mahjong:"},
		"🀄"
	}, {
		{":spades:"},
		"♠"
	}, {
		{":clubs:"},
		"♣"
	}, {
		{":hearts:"},
		"♥"
	}, {
		{":diamonds:"},
		"♦"
	}, {
		{":flower_playing_cards:"},
		"🎴"
	}, {
		{":thought_balloon:"},
		"💭"
	}, {
		{":anger_right:", ":right_anger_bubble:"},
		"🗯"
	}, {
		{":speech_balloon:"},
		"💬"
	}, {
		{":clock1:"},
		"🕐"
	}, {
		{":clock2:"},
		"🕑"
	}, {
		{":clock3:"},
		"🕒"
	}, {
		{":clock4:"},
		"🕓"
	}, {
		{":clock5:"},
		"🕔"
	}, {
		{":clock6:"},
		"🕕"
	}, {
		{":clock7:"},
		"🕖"
	}, {
		{":clock8:"},
		"🕗"
	}, {
		{":clock9:"},
		"🕘"
	}, {
		{":clock10:"},
		"🕙"
	}, {
		{":clock11:"},
		"🕚"
	}, {
		{":clock12:"},
		"🕛"
	}, {
		{":clock130:"},
		"🕜"
	}, {
		{":clock230:"},
		"🕝"
	}, {
		{":clock330:"},
		"🕞"
	}, {
		{":clock430:"},
		"🕟"
	}, {
		{":clock530:"},
		"🕠"
	}, {
		{":clock630:"},
		"🕡"
	}, {
		{":clock730:"},
		"🕢"
	}, {
		{":clock830:"},
		"🕣"
	}, {
		{":clock930:"},
		"🕤"
	}, {
		{":clock1030:"},
		"🕥"
	}, {
		{":clock1130:"},
		"🕦"
	}, {
		{":clock1230:"},
		"🕧"
	}, {
		{":eye_in_speech_bubble:"},
		"👁‍🗨"
	}, {
		{":speech_left:", ":left_speech_bubble:"},
		"🗨"
	}, {
		{":eject:", ":eject_symbol:"},
		"⏏"
	}, {
		{":black_heart:"},
		"🖤"
	}, {
		{":octagonal_sign:", ":stop_sign:"},
		"🛑"
	}, {
		{":regional_indicator_z:"},
		"🇿"
	}, {
		{":regional_indicator_y:"},
		"🇾"
	}, {
		{":regional_indicator_x:"},
		"🇽"
	}, {
		{":regional_indicator_w:"},
		"🇼"
	}, {
		{":regional_indicator_v:"},
		"🇻"
	}, {
		{":regional_indicator_u:"},
		"🇺"
	}, {
		{":regional_indicator_t:"},
		"🇹"
	}, {
		{":regional_indicator_s:"},
		"🇸"
	}, {
		{":regional_indicator_r:"},
		"🇷"
	}, {
		{":regional_indicator_q:"},
		"🇶"
	}, {
		{":regional_indicator_p:"},
		"🇵"
	}, {
		{":regional_indicator_o:"},
		"🇴"
	}, {
		{":regional_indicator_n:"},
		"🇳"
	}, {
		{":regional_indicator_m:"},
		"🇲"
	}, {
		{":regional_indicator_l:"},
		"🇱"
	}, {
		{":regional_indicator_k:"},
		"🇰"
	}, {
		{":regional_indicator_j:"},
		"🇯"
	}, {
		{":regional_indicator_i:"},
		"🇮"
	}, {
		{":regional_indicator_h:"},
		"🇭"
	}, {
		{":regional_indicator_g:"},
		"🇬"
	}, {
		{":regional_indicator_f:"},
		"🇫"
	}, {
		{":regional_indicator_e:"},
		"🇪"
	}, {
		{":regional_indicator_d:"},
		"🇩"
	}, {
		{":regional_indicator_c:"},
		"🇨"
	}, {
		{":regional_indicator_b:"},
		"🇧"
	}, {
		{":regional_indicator_a:"},
		"🇦"
	},
	{
		{":flag_ac:"},
		"🇦🇨"
	}, {
		{":flag_af:"},
		"🇦🇫"
	}, {
		{":flag_al:"},
		"🇦🇱"
	}, {
		{":flag_dz:"},
		"🇩🇿"
	}, {
		{":flag_ad:"},
		"🇦🇩"
	}, {
		{":flag_ao:"},
		"🇦🇴"
	}, {
		{":flag_ai:"},
		"🇦🇮"
	}, {
		{":flag_ag:"},
		"🇦🇬"
	}, {
		{":flag_ar:"},
		"🇦🇷"
	}, {
		{":flag_am:"},
		"🇦🇲"
	}, {
		{":flag_aw:"},
		"🇦🇼"
	}, {
		{":flag_au:"},
		"🇦🇺"
	}, {
		{":flag_at:"},
		"🇦🇹"
	}, {
		{":flag_az:"},
		"🇦🇿"
	}, {
		{":flag_bs:"},
		"🇧🇸"
	}, {
		{":flag_bh:"},
		"🇧🇭"
	}, {
		{":flag_bd:"},
		"🇧🇩"
	}, {
		{":flag_bb:"},
		"🇧🇧"
	}, {
		{":flag_by:"},
		"🇧🇾"
	}, {
		{":flag_be:"},
		"🇧🇪"
	}, {
		{":flag_bz:"},
		"🇧🇿"
	}, {
		{":flag_bj:"},
		"🇧🇯"
	}, {
		{":flag_bm:"},
		"🇧🇲"
	}, {
		{":flag_bt:"},
		"🇧🇹"
	}, {
		{":flag_bo:"},
		"🇧🇴"
	}, {
		{":flag_ba:"},
		"🇧🇦"
	}, {
		{":flag_bw:"},
		"🇧🇼"
	}, {
		{":flag_br:"},
		"🇧🇷"
	}, {
		{":flag_bn:"},
		"🇧🇳"
	}, {
		{":flag_bg:"},
		"🇧🇬"
	}, {
		{":flag_bf:"},
		"🇧🇫"
	}, {
		{":flag_bi:"},
		"🇧🇮"
	}, {
		{":flag_cv:"},
		"🇨🇻"
	}, {
		{":flag_kh:"},
		"🇰🇭"
	}, {
		{":flag_cm:"},
		"🇨🇲"
	}, {
		{":flag_ca:"},
		"🇨🇦"
	}, {
		{":flag_ky:"},
		"🇰🇾"
	}, {
		{":flag_cf:"},
		"🇨🇫"
	}, {
		{":flag_td:"},
		"🇹🇩"
	}, {
		{":flag_cl:"},
		"🇨🇱"
	}, {
		{":flag_cn:"},
		"🇨🇳"
	}, {
		{":flag_co:"},
		"🇨🇴"
	}, {
		{":flag_km:"},
		"🇰🇲"
	}, {
		{":flag_cg:"},
		"🇨🇬"
	}, {
		{":flag_cd:"},
		"🇨🇩"
	}, {
		{":flag_cr:"},
		"🇨🇷"
	}, {
		{":flag_hr:"},
		"🇭🇷"
	}, {
		{":flag_cu:"},
		"🇨🇺"
	}, {
		{":flag_cy:"},
		"🇨🇾"
	}, {
		{":flag_cz:"},
		"🇨🇿"
	}, {
		{":flag_dk:"},
		"🇩🇰"
	}, {
		{":flag_dj:"},
		"🇩🇯"
	}, {
		{":flag_dm:"},
		"🇩🇲"
	}, {
		{":flag_do:"},
		"🇩🇴"
	}, {
		{":flag_ec:"},
		"🇪🇨"
	}, {
		{":flag_eg:"},
		"🇪🇬"
	}, {
		{":flag_sv:"},
		"🇸🇻"
	}, {
		{":flag_gq:"},
		"🇬🇶"
	}, {
		{":flag_er:"},
		"🇪🇷"
	}, {
		{":flag_ee:"},
		"🇪🇪"
	}, {
		{":flag_et:"},
		"🇪🇹"
	}, {
		{":flag_fk:"},
		"🇫🇰"
	}, {
		{":flag_fo:"},
		"🇫🇴"
	}, {
		{":flag_fj:"},
		"🇫🇯"
	}, {
		{":flag_fi:"},
		"🇫🇮"
	}, {
		{":flag_fr:"},
		"🇫🇷"
	}, {
		{":flag_pf:"},
		"🇵🇫"
	}, {
		{":flag_ga:"},
		"🇬🇦"
	}, {
		{":flag_gm:"},
		"🇬🇲"
	}, {
		{":flag_ge:"},
		"🇬🇪"
	}, {
		{":flag_de:"},
		"🇩🇪"
	}, {
		{":flag_gh:"},
		"🇬🇭"
	}, {
		{":flag_gi:"},
		"🇬🇮"
	}, {
		{":flag_gr:"},
		"🇬🇷"
	}, {
		{":flag_gl:"},
		"🇬🇱"
	}, {
		{":flag_gd:"},
		"🇬🇩"
	}, {
		{":flag_gu:"},
		"🇬🇺"
	}, {
		{":flag_gt:"},
		"🇬🇹"
	}, {
		{":flag_gn:"},
		"🇬🇳"
	}, {
		{":flag_gw:"},
		"🇬🇼"
	}, {
		{":flag_gy:"},
		"🇬🇾"
	}, {
		{":flag_ht:"},
		"🇭🇹"
	}, {
		{":flag_hn:"},
		"🇭🇳"
	}, {
		{":flag_hk:"},
		"🇭🇰"
	}, {
		{":flag_hu:"},
		"🇭🇺"
	}, {
		{":flag_is:"},
		"🇮🇸"
	}, {
		{":flag_in:"},
		"🇮🇳"
	}, {
		{":flag_id:"},
		"🇮🇩"
	}, {
		{":flag_ir:"},
		"🇮🇷"
	}, {
		{":flag_iq:"},
		"🇮🇶"
	}, {
		{":flag_ie:"},
		"🇮🇪"
	}, {
		{":flag_il:"},
		"🇮🇱"
	}, {
		{":flag_it:"},
		"🇮🇹"
	}, {
		{":flag_ci:"},
		"🇨🇮"
	}, {
		{":flag_jm:"},
		"🇯🇲"
	}, {
		{":flag_jp:"},
		"🇯🇵"
	}, {
		{":flag_je:"},
		"🇯🇪"
	}, {
		{":flag_jo:"},
		"🇯🇴"
	}, {
		{":flag_kz:"},
		"🇰🇿"
	}, {
		{":flag_ke:"},
		"🇰🇪"
	}, {
		{":flag_ki:"},
		"🇰🇮"
	}, {
		{":flag_xk:"},
		"🇽🇰"
	}, {
		{":flag_kw:"},
		"🇰🇼"
	}, {
		{":flag_kg:"},
		"🇰🇬"
	}, {
		{":flag_la:"},
		"🇱🇦"
	}, {
		{":flag_lv:"},
		"🇱🇻"
	}, {
		{":flag_lb:"},
		"🇱🇧"
	}, {
		{":flag_ls:"},
		"🇱🇸"
	}, {
		{":flag_lr:"},
		"🇱🇷"
	}, {
		{":flag_ly:"},
		"🇱🇾"
	}, {
		{":flag_li:"},
		"🇱🇮"
	}, {
		{":flag_lt:"},
		"🇱🇹"
	}, {
		{":flag_lu:"},
		"🇱🇺"
	}, {
		{":flag_mo:"},
		"🇲🇴"
	}, {
		{":flag_mk:"},
		"🇲🇰"
	}, {
		{":flag_mg:"},
		"🇲🇬"
	}, {
		{":flag_mw:"},
		"🇲🇼"
	}, {
		{":flag_my:"},
		"🇲🇾"
	}, {
		{":flag_mv:"},
		"🇲🇻"
	}, {
		{":flag_ml:"},
		"🇲🇱"
	}, {
		{":flag_mt:"},
		"🇲🇹"
	}, {
		{":flag_mh:"},
		"🇲🇭"
	}, {
		{":flag_mr:"},
		"🇲🇷"
	}, {
		{":flag_mu:"},
		"🇲🇺"
	}, {
		{":flag_mx:"},
		"🇲🇽"
	}, {
		{":flag_fm:"},
		"🇫🇲"
	}, {
		{":flag_md:"},
		"🇲🇩"
	}, {
		{":flag_mc:"},
		"🇲🇨"
	}, {
		{":flag_mn:"},
		"🇲🇳"
	}, {
		{":flag_me:"},
		"🇲🇪"
	}, {
		{":flag_ms:"},
		"🇲🇸"
	}, {
		{":flag_ma:"},
		"🇲🇦"
	}, {
		{":flag_mz:"},
		"🇲🇿"
	}, {
		{":flag_mm:"},
		"🇲🇲"
	}, {
		{":flag_na:"},
		"🇳🇦"
	}, {
		{":flag_nr:"},
		"🇳🇷"
	}, {
		{":flag_np:"},
		"🇳🇵"
	}, {
		{":flag_nl:"},
		"🇳🇱"
	}, {
		{":flag_nc:"},
		"🇳🇨"
	}, {
		{":flag_nz:"},
		"🇳🇿"
	}, {
		{":flag_ni:"},
		"🇳🇮"
	}, {
		{":flag_ne:"},
		"🇳🇪"
	}, {
		{":flag_ng:"},
		"🇳🇬"
	}, {
		{":flag_nu:"},
		"🇳🇺"
	}, {
		{":flag_kp:"},
		"🇰🇵"
	}, {
		{":flag_no:"},
		"🇳🇴"
	}, {
		{":flag_om:"},
		"🇴🇲"
	}, {
		{":flag_pk:"},
		"🇵🇰"
	}, {
		{":flag_pw:"},
		"🇵🇼"
	}, {
		{":flag_ps:"},
		"🇵🇸"
	}, {
		{":flag_pa:"},
		"🇵🇦"
	}, {
		{":flag_pg:"},
		"🇵🇬"
	}, {
		{":flag_py:"},
		"🇵🇾"
	}, {
		{":flag_pe:"},
		"🇵🇪"
	}, {
		{":flag_ph:"},
		"🇵🇭"
	}, {
		{":flag_pl:"},
		"🇵🇱"
	}, {
		{":flag_pt:"},
		"🇵🇹"
	}, {
		{":flag_pr:"},
		"🇵🇷"
	}, {
		{":flag_qa:"},
		"🇶🇦"
	}, {
		{":flag_ro:"},
		"🇷🇴"
	}, {
		{":flag_ru:"},
		"🇷🇺"
	}, {
		{":flag_rw:"},
		"🇷🇼"
	}, {
		{":flag_sh:"},
		"🇸🇭"
	}, {
		{":flag_kn:"},
		"🇰🇳"
	}, {
		{":flag_lc:"},
		"🇱🇨"
	}, {
		{":flag_vc:"},
		"🇻🇨"
	}, {
		{":flag_ws:"},
		"🇼🇸"
	}, {
		{":flag_sm:"},
		"🇸🇲"
	}, {
		{":flag_st:"},
		"🇸🇹"
	}, {
		{":flag_sa:"},
		"🇸🇦"
	}, {
		{":flag_sn:"},
		"🇸🇳"
	}, {
		{":flag_rs:"},
		"🇷🇸"
	}, {
		{":flag_sc:"},
		"🇸🇨"
	}, {
		{":flag_sl:"},
		"🇸🇱"
	}, {
		{":flag_sg:"},
		"🇸🇬"
	}, {
		{":flag_sk:"},
		"🇸🇰"
	}, {
		{":flag_si:"},
		"🇸🇮"
	}, {
		{":flag_sb:"},
		"🇸🇧"
	}, {
		{":flag_so:"},
		"🇸🇴"
	}, {
		{":flag_za:"},
		"🇿🇦"
	}, {
		{":flag_kr:"},
		"🇰🇷"
	}, {
		{":flag_es:"},
		"🇪🇸"
	}, {
		{":flag_lk:"},
		"🇱🇰"
	}, {
		{":flag_sd:"},
		"🇸🇩"
	}, {
		{":flag_sr:"},
		"🇸🇷"
	}, {
		{":flag_sz:"},
		"🇸🇿"
	}, {
		{":flag_se:"},
		"🇸🇪"
	}, {
		{":flag_ch:"},
		"🇨🇭"
	}, {
		{":flag_sy:"},
		"🇸🇾"
	}, {
		{":flag_tw:"},
		"🇹🇼"
	}, {
		{":flag_tj:"},
		"🇹🇯"
	}, {
		{":flag_tz:"},
		"🇹🇿"
	}, {
		{":flag_th:"},
		"🇹🇭"
	}, {
		{":flag_tl:"},
		"🇹🇱"
	}, {
		{":flag_tg:"},
		"🇹🇬"
	}, {
		{":flag_to:"},
		"🇹🇴"
	}, {
		{":flag_tt:"},
		"🇹🇹"
	}, {
		{":flag_tn:"},
		"🇹🇳"
	}, {
		{":flag_tr:"},
		"🇹🇷"
	}, {
		{":flag_tm:"},
		"🇹🇲"
	}, {
		{":flag_tv:"},
		"🇹🇻"
	}, {
		{":flag_ug:"},
		"🇺🇬"
	}, {
		{":flag_ua:"},
		"🇺🇦"
	}, {
		{":flag_ae:"},
		"🇦🇪"
	}, {
		{":flag_gb:"},
		"🇬🇧"
	}, {
		{":flag_us:"},
		"🇺🇸"
	}, {
		{":flag_vi:"},
		"🇻🇮"
	}, {
		{":flag_uy:"},
		"🇺🇾"
	}, {
		{":flag_uz:"},
		"🇺🇿"
	}, {
		{":flag_vu:"},
		"🇻🇺"
	}, {
		{":flag_va:"},
		"🇻🇦"
	}, {
		{":flag_ve:"},
		"🇻🇪"
	}, {
		{":flag_vn:"},
		"🇻🇳"
	}, {
		{":flag_wf:"},
		"🇼🇫"
	}, {
		{":flag_eh:"},
		"🇪🇭"
	}, {
		{":flag_ye:"},
		"🇾🇪"
	}, {
		{":flag_zm:"},
		"🇿🇲"
	}, {
		{":flag_zw:"},
		"🇿🇼"
	}, {
		{":flag_re:"},
		"🇷🇪"
	}, {
		{":flag_ax:"},
		"🇦🇽"
	}, {
		{":flag_ta:"},
		"🇹🇦"
	}, {
		{":flag_io:"},
		"🇮🇴"
	}, {
		{":flag_bq:"},
		"🇧🇶"
	}, {
		{":flag_cx:"},
		"🇨🇽"
	}, {
		{":flag_cc:"},
		"🇨🇨"
	}, {
		{":flag_gg:"},
		"🇬🇬"
	}, {
		{":flag_im:"},
		"🇮🇲"
	}, {
		{":flag_yt:"},
		"🇾🇹"
	}, {
		{":flag_nf:"},
		"🇳🇫"
	}, {
		{":flag_pn:"},
		"🇵🇳"
	}, {
		{":flag_bl:"},
		"🇧🇱"
	}, {
		{":flag_pm:"},
		"🇵🇲"
	}, {
		{":flag_gs:"},
		"🇬🇸"
	}, {
		{":flag_tk:"},
		"🇹🇰"
	}, {
		{":flag_bv:"},
		"🇧🇻"
	}, {
		{":flag_hm:"},
		"🇭🇲"
	}, {
		{":flag_sj:"},
		"🇸🇯"
	}, {
		{":flag_um:"},
		"🇺🇲"
	}, {
		{":flag_ic:"},
		"🇮🇨"
	}, {
		{":flag_ea:"},
		"🇪🇦"
	}, {
		{":flag_cp:"},
		"🇨🇵"
	}, {
		{":flag_dg:"},
		"🇩🇬"
	}, {
		{":flag_as:"},
		"🇦🇸"
	}, {
		{":flag_aq:"},
		"🇦🇶"
	}, {
		{":flag_vg:"},
		"🇻🇬"
	}, {
		{":flag_ck:"},
		"🇨🇰"
	}, {
		{":flag_cw:"},
		"🇨🇼"
	}, {
		{":flag_eu:"},
		"🇪🇺"
	}, {
		{":flag_gf:"},
		"🇬🇫"
	}, {
		{":flag_tf:"},
		"🇹🇫"
	}, {
		{":flag_gp:"},
		"🇬🇵"
	}, {
		{":flag_mq:"},
		"🇲🇶"
	}, {
		{":flag_mp:"},
		"🇲🇵"
	}, {
		{":flag_sx:"},
		"🇸🇽"
	}, {
		{":flag_ss:"},
		"🇸🇸"
	}, {
		{":flag_tc:"},
		"🇹🇨"
	}, {
		{":flag_mf:"},
		"🇲🇫"
	}, {
		{":gay_pride_flag:", ":rainbow_flag:"},
		"🏳️‍🌈"
	}
}

