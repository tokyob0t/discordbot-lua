---@meta

---@generic T, R
---@param tbl T[] | table<string, T>
---@param fn fun(T, i:integer | string): R
---@return R[]
table.map = function(tbl, fn)
    local new_tbl = {}
    if #tbl >= 1 then
        for index, value in ipairs(tbl) do
            table.insert(new_tbl, fn(value, index))
        end
    else
        for key, value in pairs(tbl) do
            new_tbl[key] = fn(value, key)
        end
    end
    return new_tbl
end

---@generic T
---@param tbl T[]
---@param fn? fun(T, i:integer): boolean
---@return T, number | nil
table.find = function(tbl, fn)
    fn = fn or function(value, index)
        return value
    end

    for index, value in ipairs(tbl) do
        if fn(value, index) then
            return value, index
        end
    end
    return nil
end

---@param s string
---@param subs string
---@return boolean
string.has = function(s, subs)
    return string.find(s, subs, 1, true) ~= nil
end
