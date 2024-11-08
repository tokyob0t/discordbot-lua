local SONG_QUEUE = {}

local voice_channel, connection

local add_song = function(song)
    table.insert(SONG_QUEUE, song)
end

---@return string | nil
local skip_song = function()
    return table.remove(SONG_QUEUE, 1)
end

---@return string | nil
local del_song = function(index, s)
    if not index then
        _, index = table.find(SONG_QUEUE, function(name, i)
            return string.has(name, s)
        end)
    end

    return table.remove(SONG_QUEUE, index)
end

local get_queue = function() end

return {
    {
        name = 'music_play',
        description = 'Play a song or add it to the queue',
        options = {
            {
                name = 'name',
                description = 'song name or link',
                required = true,
            },
        },
        callback = function(interaction, args)
            voice_channel = interaction.member.voiceChannel

            if not voice_channel then
                return interaction:reply(
                    'You need to be in a voice channel to play music!',
                    true
                )
            end

            add_song(args.name)

            if not connection then
                connection = voice_channel:join()

                interaction:reply(string.format('Now playing `%s`', args.name))
            else
                interaction:reply(
                    string.format('`%s` added to the queue', args.name),
                    true
                )
            end
        end,
    },
    {
        name = 'music_skip',
        description = 'Skip the current song',
        options = {
            { name = 'n', description = 'n times to skip', type = 'integer' },
        },
        callback = function(interaction, args)
            local n_times = (args.n and args.n > 0) and args.n or 1
            for _ = 1, n_times do
                local skipped = skip_song()

                interaction:reply(string.format('Skipped `%s`', skipped), true)
            end
        end,
    },
    {
        name = 'music_delete',
        description = 'Delete a song from the queue',
        options = {
            {
                name = 'pos',
                description = 'delete by its position in the queue',
                type = 'integer',
            },
            { name = 'name', description = 'delete by its name' },
        },
        callback = function(interaction, args)
            if not args.pos and not args.name then
                return interaction:reply('Provide at least one option')
            end

            local deleted = args.name and del_song(nil, args.name)
                or del_song(args.pos)

            if deleted then
                return interaction:reply(
                    string.format('Removed `%s` from the queue', deleted),
                    true
                )
            end

            local error_message = args.name
                    and string.format(
                        'Song `%s` not found in the queue',
                        args.name
                    )
                or string.format(
                    'Song in the position `%d` not found in the queue',
                    args.pos
                )

            return interaction:reply(error_message, true)
        end,
    },
    {
        name = 'music_queue',
        description = 'Show the queue',
        callback = function(interaction)
            if #SONG_QUEUE == 0 then
                return interaction:reply('queue is empty')
            end

            local songs = table.map(SONG_QUEUE, function(v, i)
                return string.format('%d. %s', i, v)
            end)

            return interaction:reply(table.concat(songs, '\n'))
        end,
    },
}
