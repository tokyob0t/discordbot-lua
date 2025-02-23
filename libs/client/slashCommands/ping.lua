local SlashCommand = require('utils/command')

return SlashCommand('ping', 'replies with \'Pong!\''):setCallback(
    function(interaction) interaction:reply('Pong!', true) end
)
