if vim.g.vscode then
  return
end

require("catppuccin").setup({
  flavour = "macchiato", -- latte, frappe, macchiato, mocha
  transparent_background = true,
  auto_integrations = true,
  float = {
    solid = false,
    transparent = true,
  },
  show_end_of_buffer = true,
  term_colors = true,
  dim_inactive = {
    enabled = false,
  },
  no_italic = false,
  no_bold = false,
  no_underline = false,
})
