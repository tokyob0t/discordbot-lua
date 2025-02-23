---@alias optionType "string"|"integer"|"boolean"|"user"|"channel"|"role"|"mentionable"|"number"|"attachment"

---@class Option
---@field name string
---@field description string
---@field type optionType
---@field required boolean
---@field choices table<string, string>

---@class SlashCommand
---@field name string
---@field description string
---@field options Option[]
---@field callback function
---@overload fun(name: string, description: string): SlashCommand
local SlashCommand = {}

---@param name string
---@param description string
SlashCommand.new = function(name, description)
    local new = setmetatable({}, { __index = SlashCommand })

    new.name = name
    new.description = description
    new.options = {}

    return new
end

---@param name string
---@param description? string
---@param required boolean?
---@param type optionType
---@param choices? table<string, string> | string[]
function SlashCommand:addOption(name, description, type, required, choices)
    if _G.type(required) == 'nil' then
        required = false
    end

    description = description or name
    choices = choices or {}

    for key, value in pairs(choices) do
        if _G.type(key) == 'number' then
            choices[value], choices[key] = value, nil
        end
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
---@param description? string
---@param required? boolean
---@param choices? table<string, string> | string[]
function SlashCommand:addStrOption(name, description, required, choices)
    return self:addOption(name, description, 'string', required, choices)
end

---@param name string
---@param description? string
---@param required? boolean
---@param choices? table<string, string> | string[]
function SlashCommand:addIntOption(name, description, required, choices)
    return self:addOption(name, description, 'integer', required, choices)
end

---@param name string
---@param description? string
---@param required? boolean
---@param choices? table<string, string> | string[]
function SlashCommand:addBoolOption(name, description, required, choices)
    return self:addOption(name, description, 'boolean', required, choices)
end

---@param name string
---@param description? string
---@param required? boolean
---@param choices? table<string, string> | string[]
function SlashCommand:addUserOption(name, description, required, choices)
    return self:addOption(name, description, 'user', required, choices)
end

---@param name string
---@param description? string
---@param required? boolean
---@param choices? table<string, string> | string[]
function SlashCommand:addChannelOption(name, description, required, choices)
    return self:addOption(name, description, 'channel', required, choices)
end

---@param name string
---@param description? string
---@param required? boolean
---@param choices? table<string, string> | string[]
function SlashCommand:addRoleOption(name, description, required, choices)
    return self:addOption(name, description, 'role', required, choices)
end

---@param name string
---@param description? string
---@param required? boolean
---@param choices? table<string, string> | string[]
function SlashCommand:addMentionableOption(
    name,
    description,
    required,
    choices
)
    return self:addOption(name, description, 'mentionable', required, choices)
end

---@param name string
---@param description? string
---@param required? boolean
---@param choices? table<string, string> | string[]
function SlashCommand:addNumOption(name, description, required, choices)
    return self:addOption(name, description, 'number', required, choices)
end

---@param name string
---@param description? string
---@param required? boolean
---@param choices? table<string, string> | string[]
function SlashCommand:addAttachmentOption(
    name,
    description,
    required,
    choices
)
    return self:addOption(name, description, 'attachment', required, choices)
end

---@param callback fun(interaction: Interaction, args?: table): any
function SlashCommand:setCallback(callback)
    self.callback = callback
    return self
end

return setmetatable({}, {
    __index = SlashCommand,
    __call = function(_, name, description)
        return SlashCommand.new(name, description)
    end,
})
