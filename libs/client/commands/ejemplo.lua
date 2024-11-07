return {
	name = "ejemplo",
	description = "ejemplo descripcion",
	options = {
		{
			name = "opcion_uno",
			description = "simple descripcion 1",
			choices = {
				choice_1 = "valor_1",
				choice_2 = "valor_2",
				choice_3 = "valor_3",
			},
		},
		{
			name = "opcion_dos",
			description = "simple descripcion 2",
		},
	},
	callback = function(interaction)
		interaction:reply("Comando ejecutado con éxito :)")
	end,
}
