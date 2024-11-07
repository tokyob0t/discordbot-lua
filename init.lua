local ENV = require("utils/dotenv")

if not ENV.TOKEN then
	return os.exit(0)
end

local client = require("client")

client:run("Bot " .. ENV.TOKEN)
