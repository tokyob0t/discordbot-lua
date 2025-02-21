local commands = require('client/commands')

return function(interaction, command, args)
    local tbl = table.find(commands, function(tbl)
        return tbl[1] == command.name
    end)

    if tbl then
        tbl.callback(interaction, args)
    else
        interaction:reply('Unknown Command!')
    end
end
