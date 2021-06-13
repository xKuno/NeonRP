
local ACTIVE = false
local GPS_PEOPLE = {}
local blip = {}
ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end
	
    PlayerData = ESX.GetPlayerData()

end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job

end)

RegisterNetEvent("kaiser_infinity:toggle")
AddEventHandler("kaiser_infinity:toggle", function(on)
	ACTIVE = on
	if ACTIVE == false then
		for k,v in pairs (blip) do
			RemoveBlip(k)	
			RemoveBlip(v)	
			blip[k] = nil
		end		
	end
end)


RegisterNetEvent("kaiser_infinity:updateAll")
AddEventHandler("kaiser_infinity:updateAll", function(personnel)
	GPS_PEOPLE = personnel
end)

RegisterNetEvent("kaiser_infinity:update")
AddEventHandler("kaiser_infinity:update", function(person)
	GPS_PEOPLE[person.src] = person
end)

Citizen.CreateThread(function()
	while true do
		if ACTIVE then	
		if PlayerData and PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'police' then
			local coords = GetEntityCoords(PlayerPedId())		
			for src, info in pairs(GPS_PEOPLE) do
						if blip[src] == nil then

							local distance = GetDistanceBetweenCoords(coords, info.x,info.y,info.z, true)
							--if distance > 200 then
							blip[src] = AddBlipForCoord(info.x,info.y,info.z)
							SetBlipSprite(blip[src], 1)
							SetBlipColour(blip[src], info.color)
							SetBlipAsShortRange(blip[src], true)
							SetBlipDisplay(blip[src], 4)
							-- SetBlipShowCone(blip, true)
							BeginTextCommandSetBlipName("STRING")
							AddTextComponentString(info.name)
							EndTextCommandSetBlipName(blip[src])
							--end
						else
							if info.x ~= nil then
								SetBlipCoords(blip[src] ,info.x,info.y,info.z)
							end
						end
				end
			end
		end
		Wait(100)
	end
end)

RegisterNetEvent('kaiser_infinity:remove')
AddEventHandler('kaiser_infinity:remove', function(src)
		Citizen.Wait(200)

		RemoveBlip(blip[src])		
		blip[src] = nil
		GPS_PEOPLE[src] = nil
		
		TriggerServerEvent("iluka:utraconosygnal", src)	
end)

RegisterNetEvent('iluka:playsound')
AddEventHandler('iluka:playsound', function(source)
	TriggerServerEvent("InteractSound_SV:PlayOnSource", "detector", 0.5)	
end)

RegisterNetEvent('kaisergps:zabranogps')
AddEventHandler('kaisergps:zabranogps', function()
		TriggerServerEvent("kaiser_infinity:remove", GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))))

		for k,v in pairs (blip) do
				RemoveBlip(k)	
				RemoveBlip(v)	
			blip[k] = nil
		end		
		ACTIVE = false
end)

RegisterNetEvent('kaisergps:menugpsa')
AddEventHandler('kaisergps:menugpsa', function()
ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'gpsmen',
	{
		title    = 'GPS',
		align    = 'center',
		elements = {
			{label = 'Wlacz GPS', value = '1'},
			{label = 'Wylacz GPS', value = '2'},
		}
	},
	function(data2, menu2)
		if data2.current.value == '1' then
		menu2.close()
		TriggerServerEvent("kaiser:dodajgpsa", GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))))
		Citizen.Wait(1500)
		elseif data2.current.value == '2' then
		menu2.close()
		TriggerServerEvent("kaiser_infinity:remove", GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))))
		Citizen.Wait(2500)
		for k,v in pairs (blip) do
				RemoveBlip(k)	
				RemoveBlip(v)	
			blip[k] = nil
		end				
		end		
	end,
	function(data2, menu2)
		menu2.close()
end)
end)
