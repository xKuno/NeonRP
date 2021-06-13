Citizen.CreateThread(function()
	Wait(500)
	ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

end)
local Esbutton = {
    {index = 0,name = 'Strona serwera',url = 'https://neonrp.pl'},
    {index = 1,name = 'Discord serwera',url = 'https://discord.gg/neonrp'},
    {index = 2,name = 'Dolacz do gry',url = 'fivem://connect/ls.neonrp.pl:30120'}
}
-- local onlinePlayers = 0
-- local onlineEms = 0
-- local onlineLspd = 0
-- local onlineMec = 0

-- RegisterNetEvent('top_discordpresence:frakcjeliczba')
-- AddEventHandler('top_discordpresence:frakcjeliczba', function(policja, medycy, mechanicy)
-- 	onlineEms = medycy
-- 	onlineLspd = policja
-- 	onlineMec = mechanicy
-- end)

Citizen.CreateThread(function()
	while true do
		local onlinePlayers = exports['esx_scoreboard']:counter('players')
		local onlineLspd = exports['esx_scoreboard']:counter('police')
		local onlineEms = exports['esx_scoreboard']:counter('ambulance')
		local onlineMec = exports['esx_scoreboard']:counter('mecano')
		SetDiscordAppId(739189169082859561)
        SetDiscordRichPresenceAsset('icon')
		SetDiscordRichPresenceAssetText('🔹 discord.gg/neonrp 🔹')
		SetRichPresence('Graczy: ' .. onlinePlayers .. ' 💜 ID: ' .. GetPlayerServerId(PlayerId()) .. ' 💜 ')
		Wait(3000)
		SetRichPresence('LSPD: ' .. onlineLspd .. ' 🚓 LSFD: ' .. onlineEms .. ' 🚑 LSC: ' .. onlineMec .. ' 🔧 ')
		Wait(3000)
	end
end)

local firstSpawn = true
AddEventHandler('playerSpawned', function()
    if firstSpawn then
        for _, v in pairs(Esbutton) do
            SetDiscordRichPresenceAction(v.index, v.name, v.url)
        end
        firstSpawn = false
    end
end)