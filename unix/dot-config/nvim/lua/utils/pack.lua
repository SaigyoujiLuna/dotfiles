---@class yukivim.utils.pack
local M = {}

---@alias yukivim.utils.pack.Config fun(opts: table)
---@alias yukivim.utils.pack.OptsSource table|fun():table|nil

---@class yukivim.utils.pack.Spec
---@field [1] string
---@field url string|nil
---@field dependencies (yukivim.utils.pack.Spec|string)[]|nil
---@field opts yukivim.utils.pack.OptsSource|nil
---@field config yukivim.utils.pack.Config|nil
---@field lazy boolean|nil
---@field build fun()|nil

---@class yukivim.utils.pack.LegacySpec
---@field packages (string|vim.pack.Spec)[]|nil
---@field config fun()|nil
---@field build table<string, fun()>|nil

---@class yukivim.utils.pack.SetupOpts
---@field imports string[]|nil
---@field after_load fun()|nil

---@class yukivim.utils.pack.Node
---@field name string
-- ---@field url string
---@field status "preload"|"loading"|"loaded"
---@field depends string[]
---@field opts yukivim.utils.pack.OptsSource[]
---@field config yukivim.utils.pack.Config|nil
---@field lazy_load boolean

---@type table<string, yukivim.utils.pack.Node>
local node_map = {}
---@type yukivim.utils.pack.Node[]
local node_list = {}
---@type (string|vim.pack.Spec)[]
local pack_list = {}
---@type table<string, true>
local spec_pack_set = {}
---@type fun()[]
local config_list = {}
---@type table<string, fun()>
local build_list = {}
---@type table<string, true>
local resolving = {}

---@param spec yukivim.utils.pack.Spec
local function build_node(spec)
  local name = spec[1]
  local node = node_map[name]
  if not node then
    node = {
      name = name,
      depends = {},
      opts = {},
      config = spec.config,
      status = "preload",
      lazy_load = spec.lazy or false,
    }
    node_map[name] = node
    node_list[#node_list + 1] = node
    local src = spec.url or ("https://github.com/" .. name)
    if not spec_pack_set[src] then
      spec_pack_set[src] = true
      pack_list[#pack_list + 1] = src
    end
  elseif spec.config then
    node.config = spec.config
  end
  if spec.opts then
    node.opts[#node.opts + 1] = spec.opts
  end
  if spec.build then
    build_list[name] = spec.build
  end
  if resolving[name] then
    return
  end
  resolving[name] = true
  for _, dep in ipairs(spec.dependencies or {}) do
    local dep_spec ---@type yukivim.utils.pack.Spec
    if type(dep) == "string" then
      dep_spec = { dep }
    else
      dep_spec = dep
    end
    if vim.list_contains(node.depends, dep_spec) then
      node.depends[#node.depends + 1] = dep_spec[1]
    end
    build_node(dep_spec)
  end
  resolving[name] = nil
end

---@param path string
local function resolve(path)
  ---@type yukivim.utils.pack.Spec[]|yukivim.utils.pack.Spec|yukivim.utils.pack.LegacySpec|true
  local imported = require(path)
  if imported == true then
    return
  end
  if imported[1] == nil then
    if imported.packages then
      vim.list_extend(pack_list, imported.packages)
    end
    if imported.build then
      build_list = vim.tbl_extend("force", build_list, imported.build)
    end
    if imported.config then
      config_list[#config_list + 1] = imported.config
    end
    return
  end

  ---@type yukivim.utils.pack.Spec[]
  local specs
  if type(imported[1]) == "string" then
    specs = {
      imported --[[@as yukivim.utils.pack.Spec]],
    }
  else
    specs = imported --[[@as yukivim.utils.pack.Spec[] ]]
  end
  for _, item in ipairs(specs) do
    build_node(item)
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

---@param node yukivim.utils.pack.Node
local function load_node(node)
  if node.status == "loaded" then
    return
  end
  if node.status == "loading" then
    error("node.status == loading")
    return
  end
  node.status = "loading"

  for _, dep in ipairs(node.depends) do
    local dep_node = node_map[dep]
    load_node(dep_node)
  end

  local opts = {}
  for _, source in ipairs(node.opts) do
    local value = type(source) == "function" and source() or source
    if value then
      opts = vim.tbl_deep_extend("force", opts, value)
    end
  end
  if node.config then
    node.config(opts)
  end
  node.status = "loaded"
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
  for _, node in ipairs(node_list) do
    if node.lazy_load then
      return
    end
    load_node(node)
  end
  if opts.after_load then
    opts.after_load()
  end
end

return M
