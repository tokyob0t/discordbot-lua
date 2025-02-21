---@meta

---@generic T, R
---@param tbl T[]
---@param fn fun(value: T, i: integer): R
---@return R[]
table.map = function(tbl, fn)
    local new_tbl = {}
    for index, value in ipairs(tbl) do
        table.insert(new_tbl, fn(value, index))
    end
    return new_tbl
end

---@generic T
---@param tbl T[]
---@param fn fun(value: T, i: integer, tbl: T[])
---@return nil
table.iterate = function(tbl, fn)
    for index, value in ipairs(tbl) do
        fn(value, index, tbl)
    end
end

---@generic T
---@param tbl T[]
---@param fn? fun(value: T, i:integer): boolean
---@return T?, number?
table.find = function(tbl, fn)
    fn = fn or function(value)
        return value
    end

    for index, value in ipairs(tbl) do
        if fn(value, index) then
            return value, index
        end
    end

    return nil, nil
end

---@param s string
---@param subs string
---@return boolean
string.has = function(s, subs)
    return string.find(s, subs, 1, true) ~= nil
end
