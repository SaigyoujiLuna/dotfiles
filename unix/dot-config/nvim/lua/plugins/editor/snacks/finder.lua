local M = {}
---@type snacks.picker.Config
M.opts = {
  enabled = true,
  config = function(opts)
    if opts.source == "explorer" then
      ---@type snacks.picker.explorer.Config
      ---@diagnostic disable-next-line: assign-type-mismatch
      local explorer_opts = opts
      explorer_opts.ignored = true
      explorer_opts.git_untracked = true
      explorer_opts.hidden = true
      explorer_opts.follow = false
      explorer_opts.watch = true
    end
    return opts
  end,
  sources = {
    explorer = {
      layout = {
        auto_hide = { "input" },
      },
    },
  },
}
M.keys = {
  {
    "<leader><Space>",
    function()
      Snacks.picker.files({
        ignored = true,
        hidden = true,
      })
    end,
    desc = "Find files",
  },
  {
    "<leader>/",
    function()
      Snacks.picker.grep()
    end,
    desc = "Live grep",
  },
  {
    "gs",
    function()
      Snacks.picker.lsp_symbols({ filter = YukiVim.config.kind_filter })
    end,
    desc = "LSP Symbols",
  },
  {
    "gS",
    function()
      Snacks.picker.lsp_workspace_symbols({ filter = YukiVim.config.kind_filter })
    end,
    desc = "LSP Workspace Symbols",
  },
}
return M
