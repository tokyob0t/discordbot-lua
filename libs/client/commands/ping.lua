return {
	name = "ping",
	description = "replies with 'Pong!'",
	callback = function(interaction)
		interaction:reply("Pong!")
	end,
}
