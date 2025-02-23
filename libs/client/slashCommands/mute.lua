---https://glitchii.github.io/embedbuilder/
local slashCommand = require('utils/command')

local prefixTbl = {
    s = 'seconds',
    m = 'minutes',
    h = 'hours',
    d = 'days',
    w = 'weeks',
    y = 'years',
}

local durationFn = {
    s = function(d) return d end,
    m = function(d) return d * 60 end,
    h = function(d) return d * 3600 end,
    d = function(d) return d * 86400 end,
    w = function(d) return d * 604800 end,
    y = function(d) return d * 31536000 end,
}

local muteCommand =
    slashCommand('mute', 'Mutes a user for a certain amount of time')

muteCommand
    :addUserOption('user', 'user nickname', true)
    :addStrOption('reason', 'reason for being muted')

for key, value in pairs(prefixTbl) do
    muteCommand:addIntOption(key, value)
end

---@param duration integer
---@param time "s"|"m"|"h"|"d"|"w"|"y"
local parseDuration = function(duration, time)
    local fn = durationFn[time]
    return fn and fn(duration) or 0
end

---@param args {
---user: User,
---reason?: string,
---seconds?: integer,
---minutes?: integer,
---hours?: integer,
---days?: integer,
---weeks?: integer,
---years?: integer,
---}
return muteCommand:setCallback(function(interaction, args)
    local user, reason = args.user, args.reason
    args.user, args.reason = nil, nil
    local time = 0

    if user.bot then
        return interaction:reply('You must choose a valid user.', true)
    end

    local description = string.format('%s for', user.mentionString)

    for key, value in pairs(args) do
        if type(value) == 'number' then
            time = time + parseDuration(value, key)

            description = description
                .. string.format(' `%d %s`', value, prefixTbl[key])
        end
    end

    interaction:reply({
        embed = {
            color = 0xffffff,
            description = description,
            author = {
                name = 'Muting',
            },
            fields = reason and {
                name = 'Reason',
                value = string.format('```%s```', reason),
            },
            -- footer = { -- doesn't werk for some reason
            --     text = user.name,
            -- icon_url = user:getAvatarURL(16, 'png'),
            -- },
        },
    })
end)
