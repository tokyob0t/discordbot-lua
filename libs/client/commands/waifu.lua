local Color = require('discordia').Color
local requests = require('utils/requests')

return {
    name = 'waifu',
    description = 'fetches a random waifu',
    -- options = {
    --     {
    --         name = 'tags',
    --         description = 'The tags names, comma-delimited.',
    --     },
    -- },
    callback = function(interaction, _, args)
        args = args or {}

        return requests.get({
            url = 'https://api.nekosapi.com/v4/images/random',
            params = {
                rating = args.rating,
                tags = args.tags,
                limit = 1,
            },
        }, function(res)
            if not res.ok then
                return interaction:reply(res.reason_phrase)
            end

            local data = res:json()

            if not data then
                return interaction:reply('json bad format')
            end

            data = data[1]

            local img = data.url
            local rgb = data.color_dominant
            print(rgb)

            interaction:reply({
                embed = {
                    title = data.artist_name or 'Artist Unknown',
                    description = 'Tags: ' .. table.concat(data.tags, ', '),
                    image = { url = img },
                    -- color =
                },
            })
        end)
    end,
}
