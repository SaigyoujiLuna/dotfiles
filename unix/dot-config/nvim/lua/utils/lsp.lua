---@class yukivim.utils.lsp
local M = {}

local tempLspparse = function(value, mode)
  value = type(value) == "string" and { value } or value --[[@as LazyKeysSpec]]
  local ret = vim.deepcopy(value) --[[@as LazyKeys]]
  ret.lhs = ret[1] or ""
  ret.rhs = ret[2]
  ---@diagnostic disable-next-line: no-unknown
  ret[1] = nil
  ---@diagnostic disable-next-line: no-unknown
  ret[2] = nil
  ret.mode = mode or "n"
  ret.id = vim.api.nvim_replace_termcodes(ret.lhs, true, true, true)

  if ret.ft then
    local ft = type(ret.ft) == "string" and { ret.ft } or ret.ft --[[@as string[] ]]
    ret.id = ret.id .. " (" .. table.concat(ft, ", ") .. ")"
  end

  if ret.mode ~= "n" then
    ret.id = ret.id .. " (" .. ret.mode .. ")"
  end
  return ret
end

local tempLspresolve = function(spec)
  ---@type LazyKeys[]
  local values = {}
  ---@diagnostic disable-next-line: no-unknown
  for _, value in ipairs(spec or {}) do
    value = type(value) == "string" and { value } or value --[[@as LazyKeysSpec]]
    value.mode = value.mode or "n"
    local modes = (type(value.mode) == "table" and value.mode or { value.mode }) --[=[@as string[]]=]
    for _, mode in ipairs(modes) do
      local keys = tempLspparse(value, mode)
      if keys.rhs == vim.NIL or keys.rhs == false then
        values[keys.id] = nil
      else
        values[keys.id] = keys
      end
    end
  end
  return values
end

local skip = { mode = true, id = true, ft = true, rhs = true, lhs = true }
local tempLspopts = function(keys)
  local opts = {} ---@type LazyKeysBase
  ---@diagnostic disable-next-line: no-unknown
  for k, v in pairs(keys) do
    if type(k) ~= "number" and not skip[k] then
      ---@diagnostic disable-next-line: no-unknown
      opts[k] = v
    end
  end
  return opts
end
---@param filter vim.lsp.get_clients.Filter
---@param spec LazyKeysSpec[]
function M.set_keymap(filter, spec)
  for _, keys in pairs(tempLspresolve(spec)) do
    local filters = {} ---@type vim.lsp.get_clients.Filter[]
    if keys.has then
      local methods = type(keys.has) == "string" and { keys.has } or keys.has --[[@as string[] ]]
      for _, method in ipairs(methods) do
        method = method:find("/") and method or ("textDocument/" .. method)
        filters[#filters + 1] = vim.tbl_extend("force", vim.deepcopy(filter), { method = method })
      end
    else
      filters[#filters + 1] = filter
    end
    for _, f in ipairs(filters) do
      local opts = tempLspopts(keys)
      ---@cast opts snacks.keymap.set.Opts
      opts.lsp = f
      opts.enabled = keys.enabled
      Snacks.keymap.set(keys.mode or "n", keys.lhs, keys.rhs, opts)
    end
  end
end
---@param on_attach fun(client: vim.lsp.Client, bufnr: number)
function M.on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
      local bufnr = ev.buf ---@type number
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      if client then
        on_attach(client, bufnr)
      end
    end,
  })
end

---@alias lsp.Client.filter {id?: number, bufnr?:number, name?: string, method?: string, filter?: fun(client: vim.lsp.Client): boolean}

---@param opts? lsp.Client.filter
function M.get_clients(opts)
  return vim.lsp.get_clients(opts)
end

return M
