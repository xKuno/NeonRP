

ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
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

local zatankowane = false


local PodczasSluzby = false
local BlipCelu = nil
local BlipZakonczenia = nil
local BlipAnulowania = nil
local PozycjaCelu = nil
local ObokVana = false
local OstatniCel = 0
local moneydistance = 0
local xxx = nil
local yyy = nil
local zzz = nil
local Blipy = {}
local JuzBlip = false
local DostarczaPaczke = false
local posiadaTrucka = false
local powrot = false
local LiczbaDostaw = 0


-- Spawn Samochodu
function WyciagnijPojazd()
    if ESX.Game.IsSpawnPointClear(Config.Strefy.Spawn.Pos, 7) then
        if posiadaTrucka == true then
            --TriggerEvent('pNotify:SendNotification', {text = 'Wypożyczyłeś/aś już pojazd! Anuluj lub zakończ aktualne zlecenie, aby otrzymać nowy!', timeout = 20000})
        elseif posiadaTrucka == false then
            ESX.Game.SpawnVehicle('burrito3', Config.Strefy.Spawn.Pos, Config.Strefy.Spawn.Heading, function(vehicle)
                platenum = math.random(10, 99)
                SetVehicleNumberPlateText(vehicle, "523 ")
                SetVehicleCustomPrimaryColour(vehicle, 211, 187, 124)
                plaquevehicule = "523 "
				TriggerEvent('ls:dodajklucze', GetVehicleNumberPlateText(vehicle))
            end)		
			ESX.ShowNotification("Wyciągnięto Pojazd")
            PodczasSluzby = true
            posiadaTrucka = true
			LosujCel()	
			DodajBlipaZakonczenia()			
        end
    else
        TriggerEvent("pNotify:SendNotification", {text = 'Jakiś truck już stoi na miejscu!'})
    end
end





-- Garaz
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
			local letsleep = true
            local Gracz = GetPlayerPed(-1)
            local Pozycja = GetEntityCoords(Gracz)
            local Dystans = GetDistanceBetweenCoords(Pozycja, Config.Strefy.Pojazd.Pos.x, Config.Strefy.Pojazd.Pos.y, Config.Strefy.Pojazd.Pos.z, true)
            	
			local Hajs = GetDistanceBetweenCoords(Pozycja, Config.Strefy.Hajs.Pos.x, Config.Strefy.Hajs.Pos.y, Config.Strefy.Hajs.Pos.z, true)				
			local BezHajs = GetDistanceBetweenCoords(Pozycja, Config.Strefy.BezHajs.Pos.x, Config.Strefy.BezHajs.Pos.y, Config.Strefy.BezHajs.Pos.z, true)				

			if Dystans <= 5.0 then
				letsleep = false
				DrawMarker(1, Config.Strefy.Pojazd.Pos.x, Config.Strefy.Pojazd.Pos.y, Config.Strefy.Pojazd.Pos.z+0.1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 0, 0, 255, 100, false, true, 2, false, nil, nil, false)
                if Dystans <= 3.0 then
                    if IsControlJustReleased(0, 38) then
                        WyciagnijPojazd()
                    end
                end
            end	
	
		if Hajs <= 5.0 then
				letsleep = false
				DrawMarker(1, Config.Strefy.Hajs.Pos.x, Config.Strefy.Hajs.Pos.y, Config.Strefy.Hajs.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 0, 0, 255, 100, false, true, 2, false, nil, nil, false)
                if Hajs <= 3.0 then
                    if IsControlJustReleased(0, 38) then
						local Van = GetVehiclePedIsIn(Gracz, false)
						 KoniecPracy()
                    end
                end
            end		
			
			if letsleep then
				Citizen.Wait(1500)
			end
    end
end)

-----------------------
-- WYSZUKIWANIE CELU --
-----------------------

function LosujCel()
local LosowyPunkt = math.random(2,25)
if LosowyPunkt == 2 then
					xxx =-461.827
					yyy =-60.0124
					zzz =43.5633
	OstatniCel = 2	
elseif LosowyPunkt == 3 then
					xxx =1458.7005
					yyy =6550.53
					zzz =13.7259
	OstatniCel = 3		
elseif LosowyPunkt == 4 then
					xxx =-1323.5798
					yyy =-239.7494
					zzz =41.6581
	OstatniCel = 4		
elseif LosowyPunkt == 5 then
					xxx =-1452.2783
					yyy =-381.8236
					zzz =37.4799
	OstatniCel =5		
elseif LosowyPunkt == 6 then
					xxx =-1571.5199
					yyy =447.412
					zzz =107.3151
	OstatniCel = 6		
elseif LosowyPunkt == 7 then
					xxx =-1405.0564
					yyy =-635.8328
					zzz =27.7236
	OstatniCel = 7		
elseif LosowyPunkt == 8 then
					xxx =-1342.5547
					yyy =-756.3865
					zzz =21.5173
	OstatniCel = 8		
elseif LosowyPunkt == 9 then
					xxx =-1173.8654
					yyy =-900.679
					zzz =12.7746
	OstatniCel = 9		
elseif LosowyPunkt == 10 then
					xxx =-1316.1689
					yyy =-1263.4374
					zzz =3.6253
	OstatniCel = 10		
elseif LosowyPunkt == 11 then
					xxx =-10.0159
					yyy =-1081.5001
					zzz =25.7221
	OstatniCel = 11	
elseif LosowyPunkt == 12 then
					xxx =140.645
					yyy =-1280.0018
					zzz =28.3858
	OstatniCel = 12			
elseif LosowyPunkt == 13 then
					xxx =157.227
					yyy =-1485.8795
					zzz =28.1916
	OstatniCel = 13		
elseif LosowyPunkt == 14 then
					xxx =-22.3037
					yyy =-1677.3386
					zzz =28.5357
	OstatniCel = 14	
elseif LosowyPunkt == 15 then
					xxx =95.7565
					yyy =-1746.031
					zzz =28.3639
	OstatniCel = 15	
elseif LosowyPunkt == 16 then
					xxx =616.2508
					yyy =2800.4573
					zzz =40.9489
	OstatniCel = 16	
elseif LosowyPunkt == 17 then
					xxx =262.4566
					yyy =2579.3071
					zzz =44.1076
	OstatniCel = 17	
elseif LosowyPunkt == 18 then
					xxx =462.6886
					yyy =3548.2366
					zzz =32.2886
	OstatniCel = 18	
elseif LosowyPunkt == 19 then
					xxx =919.1589
					yyy =3660.834
					zzz =31.6226
	OstatniCel = 19	
elseif LosowyPunkt == 20 then
					xxx =1964.7406
					yyy =3755.8154
					zzz =31.2942
	OstatniCel = 20	
elseif LosowyPunkt == 21 then
					xxx =1698.4475
					yyy =4912.8872
					zzz =41.1281
	OstatniCel = 21	
elseif LosowyPunkt == 22 then
					xxx =45.194
					yyy =6301.4204
					zzz =30.2782
	OstatniCel = 22	
elseif LosowyPunkt == 23 then
					xxx =-61.5245
					yyy =6499.6926
					zzz =30.5409
	OstatniCel = 23	
elseif LosowyPunkt == 24 then
					xxx =-231.9932
					yyy =6351.7275
					zzz =31.476
	OstatniCel = 24	
elseif LosowyPunkt == 25 then
					xxx =-288.2047
					yyy =6303.4414
					zzz =30.5422
	OstatniCel = 25		
end
local Gracz = GetPlayerPed(-1)
local Pozycja = GetEntityCoords(Gracz)
moneydistance = GetDistanceBetweenCoords(xxx, yyy, zzz, Pozycja.x, Pozycja.y, Pozycja.z, true)
DodajBlipaDoCelu(PozycjaCelu)
end

----------------------
-- TWORZENIE BLIPÓW --
----------------------

-- Blip celu podrózy
function DodajBlipaDoCelu(PozycjaCelu)
    Blipy['cel'] = AddBlipForCoord(xxx, yyy, zzz)
    SetBlipRoute(Blipy['cel'], true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Punkt')
	EndTextCommandSetBlipName(Blipy['cel'])
end
function DodajBlipa(x,y,z)
    Blipy['cel'] = AddBlipForCoord(x, y, z)
    SetBlipRoute(Blipy['cel'], true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Punkt')
	EndTextCommandSetBlipName(Blipy['cel'])
end

-- Blip zakonczenia pracy
function DodajBlipaZakonczenia()
    Blipy['zakonczenie'] = AddBlipForCoord(170.63, 471.14, 4.8351)
		SetBlipColour(Blipy['zakonczenie'], 2)
    --SetBlipRoute(Blipy['zakonczenie'], true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Zakończ Pracę')
	EndTextCommandSetBlipName(Blipy['zakonczenie'])
end

---------------------
-- USUWANIE BLIPÓW --
---------------------

function UsunBlipaCelu()
    RemoveBlip(Blipy['cel'])
end

function UsunBlipaAnulowania()
    RemoveBlip(Blipy['anulowanie'])
end

function UsunWszystkieBlipy()
    RemoveBlip(Blipy['cel'])
    RemoveBlip(Blipy['anulowanie'])
    RemoveBlip(Blipy['zakonczenie'])
end



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if xxx ~= nil then
			local letsleep = true
            local Gracz = GetPlayerPed(-1)
            local Pozycja = GetEntityCoords(Gracz)
            local Dystans = GetDistanceBetweenCoords(Pozycja, xxx, yyy, zzz, true)
			if Dystans <= 20.0 then
				letsleep = false
				DrawMarker(1, xxx, yyy, zzz, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 0, 0, 255, 100, false, true, 2, false, nil, nil, false)
                if Dystans <= 3.5 then
				local Van = GetVehiclePedIsIn(GetPlayerPed(-1), false)
					if IsVehicleModel(Van, GetHashKey('burrito3')) and IsControlJustReleased(0, 38) then	
						DostarczPaczke()
					end
                end
            end
		else
			Citizen.Wait(1500)
        end
		if letsleep then
			Citizen.Wait(1500)
		end
    end
end)




function DostarczPaczke()
LiczbaDostaw = LiczbaDostaw + 1
DostarczaPaczke = true
local Gracz = GetPlayerPed(-1)
if IsPedInAnyVehicle(Gracz, false) then
	local Van = GetVehiclePedIsIn(Gracz, false)
	if IsVehicleModel(Van, GetHashKey('burrito3')) then
		TriggerServerEvent("Kaiser:praca", moneydistance)
	end
end
moneydistance = 0
UsunBlipaCelu()
DostarczaPaczke = false
powrot = true
zatankowane = false	
if LiczbaDostaw > 9 then
ESX.ShowNotification("Teraz wroc na baze")
xxx = nil
yyy = nil
zzz = nil
else
LosujCel()
end
end


------------------
-- KONIEC PRACY --
------------------
function KoniecPracyBezKasy()
    UsunWszystkieBlipy()
    local Gracz = GetPlayerPed(-1)
    if IsPedInAnyVehicle(Gracz, false) then
        local Van = GetVehiclePedIsIn(Gracz, false)

            ESX.Game.DeleteVehicle(Van)
     
            PodczasSluzby = false
            BlipCelu = nil
            BlipZakonczenia = nil
            BlipAnulowania = nil
            PozycjaCelu = nil
            MaPaczke = false
            OstatniCel = nil
            LiczbaDostaw = 0
            xxx = nil
            yyy = nil
            zzz = nil
            posiadaTrucka = false
            Rozwieziono = false
			zatankowane = false
    else
       -- TriggerEvent('pNotify:SendNotification', {text = "Kaucja nie została zwrócona!"})
        PodczasSluzby = false
        BlipCelu = nil
        BlipZakonczenia = nil
        BlipAnulowania = nil
        PozycjaCelu = nil
        MaPaczke = false
        OstatniCel = nil
        LiczbaDostaw = 0
        xxx = nil
        yyy = nil
        zzz = nil
        posiadaTrucka = false
        Rozwieziono = false
		zatankowane = false		
    end
end


function KoniecPracy()
    UsunWszystkieBlipy()
    local Gracz = GetPlayerPed(-1)
    if IsPedInAnyVehicle(Gracz, false) then
        local Van = GetVehiclePedIsIn(Gracz, false)
        if IsVehicleModel(Van, GetHashKey('burrito3')) then
            ESX.Game.DeleteVehicle(Van)
			if LiczbaDostaw > 9 then
				TriggerServerEvent("Kaiser:praca", 11900)
			end
            PodczasSluzby = false
            BlipCelu = nil
            BlipZakonczenia = nil
            BlipAnulowania = nil
            PozycjaCelu = nil
            MaPaczke = false
            OstatniCel = nil
            LiczbaDostaw = 0
            xxx = nil
            yyy = nil
            zzz = nil
            posiadaTrucka = false
            Rozwieziono = false
			zatankowane = false			
        else

        end
    else
       -- TriggerEvent('pNotify:SendNotification', {text = "Kaucja nie została zwrócona!"})
        PodczasSluzby = false
        BlipCelu = nil
        BlipZakonczenia = nil
        BlipAnulowania = nil
        PozycjaCelu = nil
        MaPaczke = false
        OstatniCel = nil
        LiczbaDostaw = 0
        xxx = nil
        yyy = nil
        zzz = nil
        posiadaTrucka = false
        Rozwieziono = false
		zatankowane = false		
    end
end
