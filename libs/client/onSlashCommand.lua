local commands = require('client/slashCommands')

---@param interaction Interaction
return function(interaction, command, args)
    local tbl = table.find(
        commands,
        function(tbl) return tbl[1] == command.name end
    )

    if tbl then
        return tbl.callback(interaction, args)
    end

    interaction:reply('Unknown Command!', true)
end
