local tools = require('discordia-slash').util.tools()

---@alias CommandTemplate {
--- name: string,
--- description?: string,
--- callback: fun(interaction, args),
--- options?: Option[],
---}

---@alias Option {
--- name: string,
--- description: string,
--- choices?: table<string, string>,
---}

---@type table<string, CommandTemplate>
local template_table = {
    require('client/commands/ping'),
    require('client/commands/example'),
    require('client/commands/waifu'),
    require('client/commands/lua'),
    table.unpack(require('client/commands/music')),
}

---@param args CommandTemplate
local slash_commands = table.map(template_table, function(args)
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
            new_opt:addChoice(tools.choice(value, key))
        end
        return new_opt
    end)

    for _, value in ipairs(args.options) do
        slash_command:addOption(value)
    end

    return slash_command
end)

return { slash_commands, template_table }
