local slash_commands = table.unpack(require('client/commands'))

return function(client)
    client:info('Logged in as ' .. client.user.name)

    for key in pairs(client:getGlobalApplicationCommands()) do
        client:deleteGlobalApplicationCommand(key)
    end

    for _, value in pairs(slash_commands) do
        client:createGlobalApplicationCommand(value)
    end

    local count = #client:getGlobalApplicationCommands()

    if count > 0 then
        client:info(string.format('Loaded across %d commands', count))
    end

    return client:info('Ready!')
end
