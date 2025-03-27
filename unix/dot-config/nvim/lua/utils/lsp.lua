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

return M
