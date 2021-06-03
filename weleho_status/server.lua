local locales = Config.Locales[Config.Locale]

Citizen.CreateThread(function()
    while true do

		if Config.MessageId ~= nil and Config.MessageId ~= '' then
			UpdateStatusMessage()
		else
			DeployStatusMessage()
			break
		end

		Citizen.Wait(Config.UpdateTime)
    end
end)


function DeployStatusMessage()
	local footer = nil

	if Config.Use24hClock then
		footer = os.date(locales['date']..': %d/%m/%Y  |  '..locales['time']..': %H:%M')
	else
		footer = os.date(locales['date']..': %d/%m/%Y  |  '..locales['time']..': %I:%M %p')
	end

	print('Deplying Status Message ['..footer..']')

	local embed = {
		{
			["color"] = Config.EmbedColor,
			["title"] = "** Deploying Status Message!**",
			["description"] = 'Copy this message id and put it into Config and restart script!',
			["footer"] = {
				["text"] = footer,
			},
		}
	}

	PerformHttpRequest(Config.Webhook, function(err, text, headers) end, 'POST', json.encode({
		embeds = embed, 
	}), { ['Content-Type'] = 'application/json' })
end


function UpdateStatusMessage()
	local players = #GetPlayers()
	local maxplayers = GetConvarInt('sv_maxclients', 0)
	local footer = nil

	if Config.Use24hClock then
		footer = os.date(locales['date']..': %d/%m/%Y  |  '..locales['time']..': %H:%M')
	else
		footer = os.date(locales['date']..': %d/%m/%Y  |  '..locales['time']..': %I:%M %p')
	end

	print('Updating Status Message ['..footer..']')


	local message = json.encode({
		embeds = {
			{

				["color"] = Config.EmbedColor,
				["title"] = '**'..Config.ServerName..'**',
				["description"] = ':busts_in_silhouette: '..locales['players']..': `'..players..' / '..maxplayers..'`',
				["footer"] = {
					["text"] = footer,
				},
			}
		},

		components = {
			{
				["type"] = 1,
				["components"] = {
					{
						["type"] = 2,
						["label"] = locales['connect'],
						["style"] = 5,
						["url"] = Config.JoinLink,
					}
				},
			}
		}
	})

	PerformHttpRequest(Config.Webhook..'/messages/'..Config.MessageId, function(err, text, headers) 
		if Config.Debug then
			print('[DEBUG] err=', err)
			print('[DEBUG] text=', text)
		end
	end, 'PATCH', message, { ['Content-Type'] = 'application/json' })
end



