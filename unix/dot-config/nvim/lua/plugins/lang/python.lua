return {
  {
    "linux-cultist/venv-selector.nvim",
    cmd = "VenvSelect",
    cond = not vim.g.vscode,
    opts = {
      options = {
        notify_user_on_venv_activation = true,
        override_notify = false,
      },
    },
    ft = "python",
  },
}
