local ENV_FILE = "../.env"

---@type { TOKEN: string }
local VARS = {}
local file = io.open(ENV_FILE, "r")

if not file then
	error("No se pudo abrir el archivo .env")
	return {}
end

for line in file:lines() do
	if line:sub(1, 1) ~= "#" and line:match("%S") then
		local key, value = line:match("([^=]+)=([^=]+)")
		if key and value then
			key = key:gsub("%s+", "")
			value = value:gsub("%s+", "")

			VARS[key] = value
		end
	end
end

file:close()

return VARS
