require('utils/globals')
require('discordia-slash').util.tools() -- if i remove this line, the bot wont use commands; wtf???

local CLIENT = require('discordia').Client({
    dateTime = '| %T ',
})

CLIENT:useApplicationCommands()

local onReady = require('client/onReady')
local onSlashCommand = require('client/onSlashCommand')
local onMessageCreate = function(message) end

CLIENT:on('ready', function() return onReady(CLIENT) end)

CLIENT:on('slashCommand', function(...) return onSlashCommand(...) end)

CLIENT:on('messageCreate', function(...) return onMessageCreate(...) end)

return CLIENT
