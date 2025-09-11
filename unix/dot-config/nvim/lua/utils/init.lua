---@class yukivim.utils
---@field cmp yukivim.utils.cmp
---@field lsp yukivim.utils.lsp
---@field lazy yukivim.utils.lazy
local M = {}

setmetatable(M, {
    __index = function(t, k)
        t[k] = require("utils." .. k)
        return t[k]
    end
})

function M.get_pkg_path(pkg, path, opts)
    pcall(require, "mason")
    local root = vim.env.MASON or (vim.fn.stdpath("data") .. "/mason")
    opts = opts or {}
    path = path or ""
    local ret = root .. "/packages" .. pkg .. path
    return ret
end
M.CREATE_UNDO = vim.api.nvim_replace_termcodes("<C-g>u", true, true, true)
function M.create_undo()
    if vim.api.nvim_get_mode().mode == "i" then
        vim.api.nvim_feedkeys(M.CREATE_UNDO, "n", false)
    end
end
return M
