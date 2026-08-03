---@class yukivim.utils.lsp
local M = {}

---@class yukivim.lsp.attach_filter
---@field name? string only attach for this server name
---@field method? string|string[] only attach if the client supports one of these methods

---@param opts? yukivim.lsp.attach_filter
---@param on_attach fun(client: vim.lsp.Client, bufnr: number)
function M.on_attach(opts, on_attach)
  if on_attach == nil then
    on_attach = opts ---@type fun(client: vim.lsp.Client, bufnr: number)
    opts = nil
  end
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
      local bufnr = ev.buf ---@type number
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      if not client then
        return
      end
      if opts and opts.name and client.name ~= opts.name then
        return
      end
      if opts and opts.method then
        local methods = type(opts.method) == "table" and opts.method or { opts.method }
        local supported = vim.iter(methods):any(function(m)
          return client:supports_method(m, bufnr)
        end)
        if not supported then
          return
        end
      end
      on_attach(client, bufnr)
    end,
  })
end

---@alias lsp.Client.filter {id?: number, bufnr?:number, name?: string, method?: string, filter?: fun(client: vim.lsp.Client): boolean}

---@param opts? lsp.Client.filter
function M.get_clients(opts)
  return vim.lsp.get_clients(opts)
end


return M
