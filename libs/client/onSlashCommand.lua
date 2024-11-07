local _, template_table = table.unpack(require("client/commands"))

return function(interaction, command, args)
	local cmd = table.find(template_table, function(v)
		return v.name == command.name
	end)

	if cmd then
		cmd.callback(interaction, args)
	else
		interaction:reply("Unknown Command")
	end
end
