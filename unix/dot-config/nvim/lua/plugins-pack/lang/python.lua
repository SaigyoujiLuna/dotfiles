if vim.g.vscode then
  return
end
vim.pack.add({
  "https://github.com/linux-cultist/venv-selector.nvim",
})
require("venv-selector").setup({
  options = {
    notify_user_on_venv_activation = true,
    override_notify = false,
  },
})

vim.lsp.config("ruff", {
  enabled = true,
  cmd_env = { RUFF_TRACE = "messages" },
  init_options = {
    settings = {
      logLevel = "error",
    },
  },
})
Snacks.util.lsp.on({ name = "ruff" }, function(_, client)
  client.server_capabilities.hoverProvider = false
end)

vim.lsp.config("basedpyright", {
  enabled = true,
})
