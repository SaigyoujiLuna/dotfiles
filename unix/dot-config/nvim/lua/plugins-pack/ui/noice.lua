require("noice").setup({
  preset = {
    lsp_doc_border = true,
    bottom_search = true,
  },
  cmdline = {
    format = {
      search_down = {
        view = "cmdline",
      },
      search_up = {
        view = "cmdline",
      },
    },
  },
  lsp = {
    hover = {
      enabled = true,
      ---@type NoiceViewOptions
      opts = {
        border = "rounded",
      },
    },
  },
  routes = {
    {
      filter = {
        event = "msg_show",
        find = "vim.pack",
      },
    },
  },
})
