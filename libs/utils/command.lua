---@alias Option { name: string, description: string, type: "number" | "string" | "boolean" ,required: boolean, choices?: table<string, string> }

---@class Command
---@field name string
---@field description string
---@field callback function
---@field options Option[]
---@overload fun(name: string, description: string): Command
local Command = {}

---@param name string
---@param description string
Command.new = function(name, description)
    local new = setmetatable({}, { __index = Command })

    new.name = name
    new.description = description
    new.options = {}

    return new
end

---@param name string
---@param description string
---@param required boolean?
---@param type "string"|"integer"|"boolean"|"user"|"channel"|"role"|"mentionable"|"number"|"attachment"
---@param choices? table<string, string> | string[]
function Command:addOption(name, description, type, required, choices)
    if _G.type(required) == 'nil' then
        required = false
    end

    table.insert(self.options, {
        name = name,
        description = description,
        required = required,
        choices = choices,
        type = type,
    })

    return self
end

---@param name string
---@param description string
---@param required boolean?
---@param choices? table<string, string> | string[]
function Command:addStrOption(name, description, required, choices)
    return self:addOption(name, description, 'string', required, choices)
end

---@param name string
---@param description string
---@param required boolean?
---@param choices? table<string, string> | string[]
function Command:addIntOption(name, description, required, choices)
    return self:addOption(name, description, 'integer', required, choices)
end

---@param name string
---@param description string
---@param required boolean?
---@param choices? table<string, string> | string[]
function Command:addBoolOption(name, description, required, choices)
    return self:addOption(name, description, 'boolean', required, choices)
end

---@param name string
---@param description string
---@param required boolean?
---@param choices? table<string, string> | string[]
function Command:addUserOption(name, description, required, choices)
    return self:addOption(name, description, 'user', required, choices)
end

---@param name string
---@param description string
---@param required boolean?
---@param choices? table<string, string> | string[]
function Command:addChannelOption(name, description, required, choices)
    return self:addOption(name, description, 'channel', required, choices)
end

---@param name string
---@param description string
---@param required boolean?
---@param choices? table<string, string> | string[]
function Command:addRoleOption(name, description, required, choices)
    return self:addOption(name, description, 'role', required, choices)
end

---@param name string
---@param description string
---@param required boolean?
---@param choices? table<string, string> | string[]
function Command:addMentionableOption(name, description, required, choices)
    return self:addOption(name, description, 'mentionable', required, choices)
end

---@param name string
---@param description string
---@param required boolean?
---@param choices? table<string, string> | string[]
function Command:addNumOption(name, description, required, choices)
    return self:addOption(name, description, 'number', required, choices)
end

---@param name string
---@param description string
---@param required boolean?
---@param choices? table<string, string> | string[]
function Command:addAttachmentOption(name, description, required, choices)
    return self:addOption(name, description, 'attachment', required, choices)
end

---@param callback fun(interaction: Interaction, args?: table): any
function Command:setCallback(callback)
    self.callback = callback
    return self
end

return setmetatable({}, {
    __index = Command,
    __call = function(_, name, description)
        return Command.new(name, description)
    end,
})
