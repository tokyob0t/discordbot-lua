local commands = require('client/commands')

return function(client)
    client:info(string.format('Logged in as %s', client.user.name))

    for key in pairs(client:getGlobalApplicationCommands()) do
        client:deleteGlobalApplicationCommand(key)
    end

    for _, tbl in pairs(commands) do
        client:createGlobalApplicationCommand(tbl[2])
    end

    local count = #client:getGlobalApplicationCommands()

    if count > 0 then
        client:info(string.format('Loaded across %d commands', count))
    end

    return client:info('Ready!')
end
