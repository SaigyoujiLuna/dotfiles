---@class yukivim.utils.pack
local M = {}

---@class yukivim.utils.pack.LegacySpec
---@field packages (string|vim.pack.Spec)[]|nil
---@field config fun()|nil
---@field build table<string, fun()>|nil

---@class yukivim.utils.pack.SetupOpts
---@field imports string[]|nil
---@field after_load fun()|nil

---@type (string|vim.pack.Spec)[]
local pack_list = {}
---@type fun()[]
local config_list = {}
---@type table<string, fun()>
local build_list = {}

---@param path string
local function resolve(path)
  ---@type yukivim.utils.pack.LegacySpec|true
  local imported = require(path)
  if imported == true then
    return
  end
  if imported.packages then
    vim.list_extend(pack_list, imported.packages)
  end
  if imported.build then
    build_list = vim.tbl_extend("force", build_list, imported.build)
  end
  if imported.config then
    config_list[#config_list + 1] = imported.config
  end
end

local function process_autocmds()
  if next(build_list) then
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

---@param opts yukivim.utils.pack.SetupOpts
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
