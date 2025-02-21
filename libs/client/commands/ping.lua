local Command = require('utils/command')

return Command('ping', 'replies with \'Pong!\''):setCallback(
    function(interaction)
        interaction:reply('Pong!', true)
    end
)
