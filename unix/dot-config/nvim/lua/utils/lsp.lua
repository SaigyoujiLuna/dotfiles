---@class yukivim.utils.lsp
local M = {}

---@param filter vim.lsp.get_clients.Filter
---@param spec LazyKeysSpec[]
function M.set_keymap(filter, spec)
  local Keys = require("lazy.core.handler.keys")
  for _, keys in pairs(Keys.resolve(spec)) do
    ---@cast keys LazyKeysLsp
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
      local opts = Keys.opts(keys)
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
