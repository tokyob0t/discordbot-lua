local tools = require('discordia-slash').util.tools()

return table.map(
    {
        require('client/commands/ping'),
        require('client/commands/example'),
        require('client/commands/waifu'),
        require('client/commands/lua'),
        require('client/commands/mute'),
    },
    ---@param args Command
    function(args)
        args.description = args.description or ''
        args.options = args.options or {}

        local slash_command = tools.slashCommand(args.name, args.description)

        args.options = table.map(args.options, function(opt)
            opt.choices = opt.choices or {}

            opt.type = opt.type or 'string'

            local new_opt = tools[opt.type](opt.name, opt.description)

            if opt.required ~= nil then
                new_opt:setRequired(opt.required)
            end

            for key, value in pairs(opt.choices) do
                if type(key) == 'number' then
                    key = value
                end
                new_opt:addChoice(tools.choice(value, key))
            end
            return new_opt
        end)

        for _, value in ipairs(args.options) do
            slash_command:addOption(value)
        end

        return { args.name, slash_command, callback = args.callback }
    end
)
