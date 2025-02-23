local SlashCommand = require('utils/command')

local code = function(s) return string.format('```\n%s```', s) end

local printLine = function(...)
    local ret = {}
    for i = 1, select('#', ...) do
        local args = tostring(select(i, ...))
        table.insert(ret, args)
    end
    return table.concat(ret, '\t')
end

return SlashCommand('lua', 'run a string as lua code')
    :addStrOption('code', 'code', true)
    :setCallback(function(interaction, args)
        local lines = {}
        local sandbox = setmetatable({}, { __index = _G })

        sandbox.os, sandbox.io, sandbox.require = {}, {}, function() end

        sandbox.print = function(...) table.insert(lines, printLine(...)) end

        local fn, sintax_error = load(args.code, 'DiscordBot', 't', sandbox)

        if not fn then
            return interaction:reply(code(sintax_error))
        end

        local success, runtime_error = pcall(fn)

        if not success then
            return interaction:reply(code(runtime_error))
        end

        local str_lines = table.concat(lines, '\n')

        if #str_lines > 1990 then
            str_lines = string.sub(str_lines, 1, 1990)
        end

        return interaction:reply(code(str_lines))
    end)
