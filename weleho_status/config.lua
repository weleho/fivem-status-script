Config = {}

Config.Debug = false

Config.Webhook = ''
Config.ServerName = ''

Config.MessageId = '' --Copy messageid from deployed message and restart script!

Config.UpdateTime = 1000*60*1 -- 1 minute
Config.Use24hClock = true -- false = 12h clock
Config.JoinLink = 'https://cfx.re/join/'

Config.EmbedColor = 3158326

Config.Locale = 'en'

Config.Locales = {
    ['fi'] = {
        ['date'] = 'Päivä',
        ['time'] = 'Aika',
        ['players'] = 'Pelaajia',
        ['connect'] = 'Yhdistä palvelimelle',
    },
    ['en'] = {
        ['date'] = 'Date',
        ['time'] = 'Time',
        ['players'] = 'Players',
        ['connect'] = 'Connect to server',
    }
}