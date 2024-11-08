local http = require('coro-http')
local json = require('json')

local R = {}

R.get = function(url, callback)
    coroutine.wrap(function()
        local res, body = http.request('GET', url)

        if res and res.code == 200 then
            callback({
                status = res.code,
                headers = res.headers,
                body = body,
                json = function()
                    return json.parse(body)
                end,
            })
        else
            callback(
                nil,
                'Request failed with status code: '
                    .. (res and res.code or 'unknown')
            )
        end
    end)()
end

return R
