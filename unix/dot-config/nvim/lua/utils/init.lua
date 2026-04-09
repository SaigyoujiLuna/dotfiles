-- local lazyUtil = require("lazy.core.util")
---@class yukivim.utils
---@field cmp yukivim.utils.cmp
---@field lsp yukivim.utils.lsp
---@field config yukivim.config
---@field treesitter yukivim.utils.treesitter
local M = {}

setmetatable(M, {
    __index = function(t, k)
        -- if lazyUtil[k] then
        --     return lazyUtil[k]
        -- end
        t[k] = require("utils." .. k)
        return t[k]
    end
})

---@param pkg string
---@param path? string
function M.get_pkg_path(pkg, path, opts)
    pcall(require, "mason")
    local root = vim.env.MASON or (vim.fn.stdpath("data") .. "/mason")
    if pkg.sub(1, 1) ~= "/" then
        pkg = "/" .. pkg
    end
    opts = opts or {}
    path = path or ""
    local ret = root .. "/packages" .. pkg .. path
    return ret
end

---@private
M.CREATE_UNDO = vim.api.nvim_replace_termcodes("<C-g>u", true, true, true)

function M.create_undo()
    if vim.api.nvim_get_mode().mode == "i" then
        vim.api.nvim_feedkeys(M.CREATE_UNDO, "n", false)
    end
end
function M.augroup(name)
    return vim.api.nvim_create_augroup("yukinvim_" .. name, { clear = true })
end

return M
