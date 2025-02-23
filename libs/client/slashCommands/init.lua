local tools = require('discordia-slash').util.tools()

return table.map({
    -- require('client/slashCommands/example'),
    require('client/slashCommands/ping'),
    require('client/slashCommands/waifu'),
    require('client/slashCommands/lua'),
    require('client/slashCommands/mute'),
}, function(args)
    args.description = args.description or ''
    args.options = args.options or {}

    local slash_command = tools.slashCommand(args.name, args.description)

    table.iterate(args.options, function(opt)
        local new_option = tools[opt.type](opt.name, opt.description)

        new_option:setRequired(opt.required)

        for key, value in pairs(opt.choices) do
            new_option:addChoice(tools.choice(value, key))
        end

        slash_command:addOption(new_option)
    end)

    return { args.name, slash_command, callback = args.callback }
end)
