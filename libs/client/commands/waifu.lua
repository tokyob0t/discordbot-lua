local Color = require('discordia').Color
local Command = require('utils/command')
local requests = require('utils/requests')

local waifuCommand = Command('waifu', 'fetches a random waifu')
waifuCommand:addStrOption('tags', 'The tag names, comma-delimited')

return waifuCommand:setCallback(function(interaction, args)
    if type(args) == 'nil' then
        args = {}
    end

    return requests.get({
        url = 'https://api.nekosapi.com/v4/images/random',
        params = {
            limit = 1,
            rating = args.rating,
            tags = args.tags,
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
end)
