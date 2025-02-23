local async = require('utils/async')
local http = require('coro-http')
local json = require('json')

---@class Response
---@field status_code number
---@field reason_phrase string
---@field ok boolean
---@field text string
---@field body string
---@field url string
local Response = {}

Response.new = function(tbl, body)
    local res = setmetatable({}, { __index = Response })

    res.text = body
    res.status_code = tbl.code
    res.reason_phrase = tbl.reason
    res.ok = res.status_code >= 200 and res.status_code < 300

    return res
end

Response.json = function(self) return json.parse(self.text) end

Response.toString = function(self)
    return json.encode({
        url = self.url,
        ok = self.ok,
        text = self.text,
        status_code = self.status_code,
        reason_phrase = self.reason_phrase,
    })
end

local R = {}

---@param tbl string | { url: string, params?: table<string, any>, headers?: table<string, string>}
---@param callback fun(res: Response): any
R.get = async(function(tbl, callback)
    if type(tbl) == 'string' then
        tbl = { url = tbl, headers = {}, params = {} }
    end

    tbl.headers = tbl.headers or {}
    tbl.params = tbl.params or {}

    local headers, params = {}, {}

    for key, value in pairs(tbl.headers) do
        table.insert(headers, { key, value })
    end

    for key, value in pairs(tbl.params) do
        local val

        if type(value) == 'table' then
            val = table.concat(value, ',')
        else
            val = tostring(value)
        end

        table.insert(params, string.format('%s=%s', key, val))
    end

    tbl.url = string.format('%s?%s', tbl.url, table.concat(params, '&'))

    local res, body = http.request('GET', tbl.url, headers, nil, nil)

    callback(Response.new(res, body))
end)

return R
