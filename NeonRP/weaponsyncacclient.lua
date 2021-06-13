Config = {}
Config.BlacklistedWeapons = { "WEAPON_PISTOL", "WEAPON_COMBATPISTOL", "WEAPON_SNSPISTOL_MK2", "WEAPON_HEAVYPISTOL", "WEAPON_SNSPISTOL", "WEAPON_PISTOL_MK2", "WEAPON_VINTAGEPISTOL" }

CreateThread(function()
  while true do
    Citizen.Wait(2500)
    for _,theWeapon in ipairs(Config.BlacklistedWeapons) do
      Wait(1)
      if HasPedGotWeapon(PlayerPedId(),GetHashKey(theWeapon),false) == 1 then
          TriggerServerEvent("jebacpkdef", theWeapon)
      end
    end
  end
end)



local strike = 0 

RegisterNetEvent('antycheat:klamastrike')
AddEventHandler('antycheat:klamastrike', function(bronka)
    if strike <= 2 then 
        strike = strike + 1 
    else
        TriggerServerEvent("jebacpolice123", bronka) 
    end
end)

CreateThread(function()
    while true do 
        Wait(60000)
        strike = 0
    end
end)