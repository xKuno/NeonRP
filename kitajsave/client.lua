ESX                           = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)
local stamina = false

RegisterCommand('pedy', function(source, args)
  TriggerServerEvent('kaiser:setped')

end)

RegisterCommand('stamina', function(source, args)
  TriggerServerEvent('kaiser:stam')
end)

RegisterCommand('psy', function(source, args)
  TriggerServerEvent('kaiser:setpedpies')

end)

RegisterCommand('animki', function(source, args)
Animka()
end)

RegisterNetEvent('kaiser:setped')
AddEventHandler('kaiser:setped', function(hash)


  while not HasModelLoaded(hash) do
    RequestModel(hash)
    Citizen.Wait(0)
  end

  if HasModelLoaded(hash) then
    SetPlayerModel(PlayerId(), hash)
	SetPedComponentVariation(GetPlayerPed(-1), 0, 0, 0, 2)
  else
    print('cant load skin!')
  end

end)

RegisterNetEvent('kaiser:stamina')
AddEventHandler('kaiser:stamina', function()
stamina = not stamina
end)

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1000)
		local Gracz = PlayerId()
		if stamina then
			RestorePlayerStamina(Gracz, 1.0)
		end
	end
end)

    local animations = {
        ['Normal'] = {
            sit = {
                dict = "creatures@rottweiler@amb@world_dog_sitting@idle_a",
                anim = "idle_c"
            },
			sitstart = {
				dict = "creatures@rottweiler@amb@world_dog_sitting@enter",
				anim = "enter"
			},
			sitstop = {
				dict = "creatures@rottweiler@amb@world_dog_sitting@exit",
				anim = "exit"
			},
            laydown = {
                dict = "creatures@rottweiler@amb@sleep_in_kennel@",
                anim = "sleep_in_kennel"
            },
            searchhit = {
                dict = "creatures@rottweiler@indication@",
                anim = "indicate_high"
            },
			getout = {
				dict = "creatures@rottweiler@incar@",
				anim = "get_out"
			},
			pawsitdown = {
				dict = "creatures@rottweiler@amb@world_dog_sitting@enter",
				anim = "enter"
			},
			pawsit = {
                dict = "creatures@rottweiler@amb@world_dog_sitting@idle_a",
                anim = "idle_b"
            },
			pawenter = {
				dict = "creatures@rottweiler@tricks@",
				anim = "paw_right_enter"
			},
			pawloop = {
				dict = "creatures@rottweiler@tricks@",
				anim = "paw_right_loop"
			},
			pawend = {
				dict = "creatures@rottweiler@tricks@",
				anim = "paw_right_exit"
			},
			pawstandup = {
				dict = "creatures@rottweiler@amb@world_dog_sitting@exit",
				anim = "exit"
			},
			begenter = {
				dict = "creatures@rottweiler@tricks@",
				anim = "beg_enter"
			},
			begloop = {
				dict = "creatures@rottweiler@tricks@",
				anim = "beg_loop"
			},
			begexit = {
				dict = "creatures@rottweiler@tricks@",
				anim = "beg_exit"
			},
        }
    }
	
function PlayAnimation(dict, anim)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end

    TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, -8.0, -1, 2, 0.0, 0, 0, 0)
end





RegisterNetEvent('kitaj:animki')
AddEventHandler('kitaj:animki', function()
Animka()
end)

RegisterNetEvent('kitaj:pedy')
AddEventHandler('kitaj:pedy', function()
Pedy()

end)

RegisterNetEvent('kitaj:pedypies')
AddEventHandler('kitaj:pedypies', function()
Pedy2()

end)

function Pedy2()
	local elements = {
		
	}
	for k,v in pairs(Config.Psy) do
		table.insert(elements, {label = v.label, value = v.value})
	end	

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'peds', {
		title    = "Psy",
		align    = 'left',
		elements = elements
	}, function(data, menu)

		if data.current.value ~= nil then
			TriggerEvent('kaiser:setped', GetHashKey(data.current.value))					
		end				
	

	end, function(data, menu)
		menu.close()

	end)
end	



function Pedy()
	
	local elements = {				
	}
	for k,v in pairs(Config.Pedy) do
		table.insert(elements, {label = v.label, value = v.value})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory', {
		title    = "Pedy",
		align    = 'left',
		elements = elements
	}, function(data, menu)

		if data.current.value ~= nil then
			TriggerEvent('kaiser:setped', GetHashKey(data.current.value))					
		end

	end, function(data, menu)
		menu.close()

	end)
end	


function Animka()
	local elements = {
		{label = 'Siedz', value = '1'},
		{label = 'Lez', value = '2'},
		{label = 'Daj Lape',  value = '3'},
		{label = 'Wstan', value = '4'},
		{label = 'Daj lape2', value = '5'},	
		{label = 'Cos', value = '6'},			
	}
	

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory', {
		title    = "Pedy",
		align    = 'left',
		elements = elements
	}, function(data, menu)

		if data.current.value == '1' then
PlayAnimation(animations['Normal'].sit.dict, animations['Normal'].sit.anim)
		elseif data.current.value == '2' then
PlayAnimation(animations['Normal'].laydown.dict, animations['Normal'].laydown.anim)
		elseif data.current.value == '3' then
            PlayAnimation(animations['Normal'].pawloop.dict, animations['Normal'].pawloop.anim)
		elseif data.current.value == '4' then
            PlayAnimation(animations['Normal'].pawstandup.dict, animations['Normal'].pawstandup.anim)
		elseif data.current.value == '5' then
                         					PlayAnimation(animations['Normal'].pawsitdown.dict, animations['Normal'].pawsitdown.anim)
					Citizen.Wait(1200)
					PlayAnimation(animations['Normal'].pawsit.dict, animations['Normal'].pawsit.anim)
					Citizen.Wait(150)
					PlayAnimation(animations['Normal'].pawenter.dict, animations['Normal'].pawenter.anim)
					Citizen.Wait(600)
					PlayAnimation(animations['Normal'].pawloop.dict, animations['Normal'].pawloop.anim)
					Citizen.Wait(3000)
					PlayAnimation(animations['Normal'].pawend.dict, animations['Normal'].pawend.anim)
					Citizen.Wait(450)
					PlayAnimation(animations['Normal'].pawsit.dict, animations['Normal'].pawsit.anim)
				elseif data.current.value == '6' then			
							PlayAnimation(animations['Normal'].begenter.dict, animations['Normal'].begenter.anim)
					Citizen.Wait(650)
					PlayAnimation(animations['Normal'].begloop.dict, animations['Normal'].begloop.anim)
					Citizen.Wait(450)
					PlayAnimation(animations['Normal'].begloop.dict, animations['Normal'].begloop.anim)
					Citizen.Wait(450)
					PlayAnimation(animations['Normal'].begexit.dict, animations['Normal'].begexit.anim)			

		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'menu_armory'
		CurrentActionData = {station = station}
	end)
end	
