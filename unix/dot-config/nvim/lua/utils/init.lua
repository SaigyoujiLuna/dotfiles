-- local lazyUtil = require("lazy.core.util")
---@class yukivim.utils
---@field cmp yukivim.utils.cmp
---@field lsp yukivim.utils.lsp
---@field lazy yukivim.utils.lazy
---@field config yukivim.config
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

---@param name string
function M.opts(name)
    local plugin = require("lazy.core.config").spec.plugins[name]
    if not plugin then
        return {}
    end
    local Plugin = require("lazy.core.plugin")
    return Plugin.values(plugin, "opts", false)
end

return M
