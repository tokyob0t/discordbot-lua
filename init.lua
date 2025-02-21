local ENV = require('utils/dotenv')

if not ENV.TOKEN then
    error('TOKEN not found')
end

local client = require('client')

client:run('Bot ' .. ENV.TOKEN, {})
