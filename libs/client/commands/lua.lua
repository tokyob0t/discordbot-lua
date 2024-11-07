local code = function(s)
	return string.format("```\n%s```", s)
end

local print_line = function(...)
	local ret = {}
	for i = 1, select("#", ...) do
		local args = tostring(select(i, ...))
		table.insert(ret, args)
	end
	return table.concat(ret, "\t")
end

return {
	name = "lua",
	description = "run a string as lua code",
	options = {
		{ name = "code", description = "code", required = true },
	},
	callback = function(interaction, args)
		local lines = {}
		local sandbox = setmetatable({ os = {} }, { __index = _G })

		sandbox.print = function(...) -- intercept printed lines with this
			table.insert(lines, print_line(...))
		end

		local fn, sintax_error = load(args.code, "DiscordBot", "t", sandbox)

		if not fn then
			return interaction:reply(code(sintax_error))
		end

		local success, runtime_error = pcall(fn)

		if not success then
			return interaction:reply(code(runtime_error))
		end

		local str_lines = table.concat(lines, "\n")

		if #str_lines > 1990 then
			str_lines = string.sub(str_lines, 1, 1990)
		end

		interaction:reply(code(str_lines))
	end,
}
