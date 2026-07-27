if vim.g.vscode then
  return
end

require("catppuccin").setup({
  flavour = "macchiato", -- latte, frappe, macchiato, mocha
  transparent_background = true,
  float = {
    solid = false,
    transparent = true,
  },
  show_end_of_buffer = true,
  term_colors = true,
  dim_inactive = {
    enabled = true,
  },
  no_italic = false,
  no_bold = false,
  no_underline = false,
  integrations = {
    blink_cmp = true,
    fidget = true,
    mason = true,
    mini = {
      enabled = true,
    },
    snacks = {
      enabled = true,
    },
    treesitter_context = true,
    treesitter = true,
    rainbow_delimiters = true,
    gitsigns = true,
    noice = true,
    which_key = true,
  },
})
vim.cmd.colorscheme("catppuccin-nvim")
