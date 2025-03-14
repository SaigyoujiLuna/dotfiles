return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "catppuccin", "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        -- separator_style = "slant",
        offsets = {
          {
            filetype = "neo-tree",
            text = "NeoTree",
            highlight = "Directory",
            text_align = "left"
          }
        }
      },
    },
  },
}
