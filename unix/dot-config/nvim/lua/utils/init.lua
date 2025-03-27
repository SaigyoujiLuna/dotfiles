---@class yukivim.utils
---@field cmp yukivim.utils.cmp
---@field lsp yukivim.utils.lsp
local M = {}

setmetatable(M, {
    __index = function(t, k)
        t[k] = require("utils." .. k)
        return t[k]
    end
})
return M
