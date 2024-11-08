local discordia = require('discordia')
local tools = require('discordia-slash').util.tools()
local client = discordia.Client():useApplicationCommands()
require('utils/globals')

local onReady = require('client/onReady')
local onSlashCommand = require('client/onSlashCommand')

local onMessageCreate = function(message) end

client:on('ready', function()
    return onReady(client)
end)

client:on('slashCommand', function(...)
    return onSlashCommand(...)
end)

client:on('messageCreate', function(...)
    return onMessageCreate(...)
end)

return client
