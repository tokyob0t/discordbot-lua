local Command = require('utils/command')

local muteCommand = Command('mute', 'Mutes a user for a certain amount of time')

muteCommand:addUserOption('user', 'user nickname', true)

---@param args { user: User }
return muteCommand:setCallback(function(interaction, args)
    local name, disc = args.user.username, args.user.discriminator

    interaction:reply(
        string.format('Muting user: `%s`', string.format('%s#%s', name, disc))
    )
end)
