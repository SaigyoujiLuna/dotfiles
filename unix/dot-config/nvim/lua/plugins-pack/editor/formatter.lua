local conform = require("conform")
conform.setup({
  formatters_by_ft = { lua = { "stylua" }, rust = { "rustfmt" } },
  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_format = "fallback",
  -- },
  default_format_opts = {
    lsp_format = "fallback",
  },
})
vim.keymap.set({ "n" }, "<leader>cf", function()
  conform.format({}, function(err)
    if not err then
      local mode = vim.api.nvim_get_mode().mode
      if vim.startswith(string.lower(mode), "v") then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "n", true)
      end
    end
  end)
end, { desc = "Format" })
