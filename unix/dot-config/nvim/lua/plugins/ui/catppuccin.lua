return {
  {
    "catppuccin/nvim",
    lazy = false,
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
      auto_integrations = true,
      integrations = {
        dashboard = true,
        fidget = true,
        flash = true,
        indent_blankline = {
          enabled = true,
          colored_indent_levels = true,
        },
        lsp_saga = true,
        mason = true,
        mini = {
          enabled = true,
          indentscope_color = "macchiato",
        },
        -- neotree = true,
        nvimtree = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
            ok = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
            ok = { "underline" },
          },
          inlay_hints = {
            background = true,
          },
        },
        notify = true,
        semantic_tokens = true,
        snacks = {
          enabled = true,
          -- indent_scope_color = "lavender",
        },
        treesitter_context = true,
        treesitter = true,
        rainbow_delimiters = true,
        telescope = {
          enabled = true,
        },
        gitsigns = true,
        noice = true,
        blink_cmp = true,
        which_key = true,
      },
    },
	config = function (_, opts)
		require("catppuccin").setup(opts)
		vim.cmd.colorscheme("catppuccin")
	end
  },
  {

    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = {
      options = {
        theme = "catppuccin",
      },
    },
  },
  {
    "j-hui/fidget.nvim",
    opts = {
      notification = {
        window = {
          winblend = 0,
        },
      },
    },
  },
  {
  	"akinsho/bufferline.nvim",
  	dependencies = "catppuccin",
    optional = true,
  	opts = function(_, opts)
  		opts.highlights = require("catppuccin.special.bufferline").get_theme()
    end
  }
}
