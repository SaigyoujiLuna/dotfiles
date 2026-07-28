---@class yukivim.utils.lsp
local M = {}

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
