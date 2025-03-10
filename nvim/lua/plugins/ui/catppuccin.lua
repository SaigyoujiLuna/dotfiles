return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        opts = {
            flavour = "macchiato", -- latte, frappe, macchiato, mocha
            transparent_background = true,
            show_end_of_buffer = true,
            no_italic = false,
            no_bold = false,
            no_underline = false,
            integrations = {
                treesitter = true,
                gitsigns = true,
                neotree = true,
                noice = true,
                blink_cmp = true
            }
        }
    },
    {

        'nvim-lualine/lualine.nvim',
        opts = {
            theme = "catppuccin"
        }
    }
}
