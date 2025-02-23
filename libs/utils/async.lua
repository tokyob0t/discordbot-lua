---@generic T: function
---@param fn T
---@return T
return function(fn)
    return function(...) return coroutine.wrap(fn)(...) end
end
