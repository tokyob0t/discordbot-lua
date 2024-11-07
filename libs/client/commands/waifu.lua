local Color = require("discordia").Color
local requests = require("utils/requests")

return {
	name = "waifu",
	description = "fetches a random waifu",
	callback = function(interaction)
		return requests.get("https://api.jikan.moe/v4/random/characters", function(res, err)
			if err ~= nil then
				interaction:reply(err)
			else
				local data = res:json().data

				local img = data.images.webp.image_url

				interaction:reply({
					embed = {
						title = data.name,
						description = data.name_kanji,
						image = { url = img },
					},
				})
			end
		end)
	end,
}
