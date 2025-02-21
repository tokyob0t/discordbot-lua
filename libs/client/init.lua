local discordia = require('discordia')
local tools = require('discordia-slash').util.tools()
local CLIENT = discordia.Client({
    dateTime = '| %T ',
})

CLIENT:useApplicationCommands()

require('utils/globals')

local onReady = require('client/onReady')
local onSlashCommand = require('client/onSlashCommand')

local onMessageCreate = function(message) end

CLIENT:on('ready', function()
    return onReady(CLIENT)
end)

CLIENT:on('slashCommand', function(...)
    return onSlashCommand(...)
end)

CLIENT:on('messageCreate', function(...)
    return onMessageCreate(...)
end)

return CLIENT
