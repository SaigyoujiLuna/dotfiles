return {
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        menu = { border = "rounded" },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 800,
          window = { border = "rounded" },
        },
        -- list = { selection = "auto_insert" },
        ghost_text = {
          enabled = true,
        },
        list = {
          selection = {
            preselect = false,
            auto_insert = false,
          },
        },
        trigger = {
          show_in_snippet = false
        }
      },
      signature = { window = { border = "rounded" } },
      keymap = {
        preset = "enter",
        -- ["<Tab>"] = {
        --   function(cmp)
        --     if cmp.snippet_active() then
        --       return cmp.accept()
        --     else
        --       return cmp.select_and_accept()
        --     end
        --   end,
        --   "snippet_forward",
        --   "fallback",
        -- },
        -- ["<C-d>"] = { "scroll_docs", "-4" }, 
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
      },
    },
  },
}
