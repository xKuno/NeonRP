-- DiscordWebhookSystemInfos = 'https://discordapp.com/api/webhooks/754739828129792041/sSK9kuvbRf_huRC8ZV-OY6ImSSpI0MTqkEkyl9ynwh1iMi55cjLOUHg9Sjag8EhQ85Cm'
-- DiscordWebhookKillinglogs = 'https://discordapp.com/api/webhooks/754739753903063120/Cmlz4vpAB367LZHDmLC3xkKOkGKxXynBN1NF0ysoRmExLSCIhI-cIA29PP8lbMXyW9do'
-- DiscordWebhookChat = 'https://discordapp.com/api/webhooks/754739583861915778/xDVzI5Mo4cYj9lSSkUIK2HPOtHorgiHzeb0yQ9o7QjkY-x_Y2-54hdEuutah_yFeHBAh'

SystemAvatar = 'https://wiki.fivem.net/w/images/d/db/FiveM-Wiki.png'

UserAvatar = 'https://i.imgur.com/nyIfOUN.png'

SystemName = 'SYSTEM'


--[[ Special Commands formatting
		 *YOUR_TEXT*			--> Make Text Italics in Discord
		**YOUR_TEXT**			--> Make Text Bold in Discord
	   ***YOUR_TEXT***			--> Make Text Italics & Bold in Discord
		__YOUR_TEXT__			--> Underline Text in Discord
	   __*YOUR_TEXT*__			--> Underline Text and make it Italics in Discord
	  __**YOUR_TEXT**__			--> Underline Text and make it Bold in Discord
	 __***YOUR_TEXT***__		--> Underline Text and make it Italics & Bold in Discord
		~~YOUR_TEXT~~			--> Strikethrough Text in Discord
]]
-- Use 'USERNAME_NEEDED_HERE' without the quotes if you need a Users Name in a special command
-- Use 'USERID_NEEDED_HERE' without the quotes if you need a Users ID in a special command


-- These special commands will be printed differently in discord, depending on what you set it to
SpecialCommands = {
				   {'/ooc', '**[OOC]:**'},
				   {'/911', '**[911]: (CALLER ID: [ USERNAME_NEEDED_HERE | USERID_NEEDED_HERE ])**'},
				  }

						
-- These blacklisted commands will not be printed in discord
BlacklistedCommands = {
					   '/AnyCommand',
					   '/AnyCommand2',
					  }

-- These Commands will use their own webhook
OwnWebhookCommands = {
					  {'/do', 'WEBHOOK_LINK_HERE'},
					  {'/me', 'WEBHOOK_LINK_HERE'},
					 }

-- These Commands will be sent as TTS messages
TTSCommands = {
			   '/ban',
			   '/kick',
			  }

