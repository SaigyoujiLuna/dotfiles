if vim.g.vscode then
  return
end
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

-- ruff handles lint/format only; let basedpyright provide hover
YukiVim.lsp.on_attach({ name = "ruff" }, function(client)
  client.server_capabilities.hoverProvider = false
end)

vim.lsp.config("basedpyright", {
  enabled = true,
})
