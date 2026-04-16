return {
  {
    "catppuccin/nvim",
    lazy = false,
    cond = not vim.g.vscode,
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "macchiato", -- latte, frappe, macchiato, mocha
      transparent_background = true,
      float = {
        transparent = true,
      },
      show_end_of_buffer = true,
      term_colors = true,
      dim_inactive = {
        enalbed = true,
      },
      no_italic = false,
      no_bold = false,
      no_underline = false,
      integrations = {
        fidget = true,
        indent_blankline = {
          colored_indent_levels = true,
        },
        mason = true,
        mini = {
          indentscope_color = "macchiato",
        },
        snacks = {
          enabled = true,
          -- indent_scope_color = "lavender",
        },
        treesitter_context = true,
        treesitter = true,
        rainbow_delimiters = true,
        gitsigns = true,
        noice = true,
        which_key = true,
      },

    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin-nvim")
    end,
  },
}
