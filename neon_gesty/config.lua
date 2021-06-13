Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

Config = {
	handsUp = Keys["X"],
	pointing = Keys["B"],
	kabura = Keys["LEFTALT"],
	crosshands = Keys["G"]
}

Ped = {
	Active = false,
	Locked = false,
	Id = 0,
	Alive = false,
	Available = false,
	Visible = false,
	InVehicle = false,
	OnFoot = false,
	Collection = false
}
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(200)

		Ped.Active = not IsPauseMenuActive()
		if Ped.Active then
			Ped.Id = PlayerPedId()
			if not IsEntityDead(Ped.Id) then
				Ped.Alive = true
				Ped.Available = (Ped.Alive and not Ped.Locked)
				Ped.Visible = IsEntityVisible(Ped.Id)
				Ped.InVehicle = IsPedInAnyVehicle(Ped.Id, false)
				Ped.OnFoot = IsPedOnFoot(Ped.Id)

				if Ped.Available and not Ped.InVehicle and Ped.Visible then
					Ped.Collection = not IsPedFalling(Ped.Id) and not IsPedDiving(Ped.Id) and not IsPedSwimming(Ped.Id) and not IsPedSwimmingUnderWater(Ped.Id) and not IsPedInCover(Ped.Id, false) and not IsPedInParachuteFreeFall(Ped.Id) and (GetPedParachuteState(Ped.Id) == 0 or GetPedParachuteState(Ped.Id) == -1) and not IsPedBeingStunned(Ped.Id)
				else
					Ped.Collection = false
				end
			else
				Ped.Alive = false
				Ped.Available = false
				Ped.Visible = IsEntityVisible(Ped.Id)
				Ped.InVehicle = false
				Ped.OnFoot = true
				Ped.Collection = false
			end
		end
	end
end)

function PedStatus()
	return Ped.Collection
end