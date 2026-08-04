---@class yukivim.utils.pack
local M = {}

---@class yukivim.utils.pack.Spec
---@field packages (string|vim.pack.Spec)[]
---@field config fun()|nil
---@field build table<string, fun()>|nil

---@class yukivim.utils.pack.Opts
---@field imports string[]|nil
---@field after_load fun()|nil

---@type (string|vim.pack.Spec)[]
local pack_list = {}
---@type fun()[]
local config_list = {}
---@type table<string, fun()>
local build_list = {}

local resolve = function(path)
  ---@type yukivim.utils.pack.Spec
  local item = require(path)
  if item.packages then
    vim.list_extend(pack_list, item.packages)
  end
  if item.build then
    build_list = vim.tbl_extend("force", build_list, item.build)
  end
  if item.config then
    config_list[#config_list + 1] = item.config
  end
end

local function process_autocmds()
  if #build_list > 0 then
    vim.api.nvim_create_autocmd("PackChanged", {
      callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if kind ~= "install" and kind ~= "update" then
          return
        end
        local build = build_list[name]
        if build then
          if not ev.data.active then
            vim.cmd.packadd(name)
          end
          build()
        end
      end,
    })
  end
end

---@param opts yukivim.utils.pack.Opts
function M.setup(opts)
  for _, path in ipairs(opts.imports or {}) do
    resolve(path)
  end
  process_autocmds()
  vim.pack.add(pack_list)
  for _, config in ipairs(config_list) do
    config()
  end
  if opts.after_load then
    opts.after_load()
  end
end

return M
