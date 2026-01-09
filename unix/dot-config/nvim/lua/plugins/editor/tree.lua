vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
return {
  {
    "nvim-tree/nvim-tree.lua",
    opts = {},
    lazy = false,
    keys = {
      {
        "<leader>e",
        function()
          require("nvim-tree.api").tree.toggle()
        end,
        mode = { "n" },
        desc = "File Explorer",
      },
      {
        "<leader>E",
        function()
          require("nvim-tree.api").tree.toggle({ find_file = true })
        end,
        mode = { "n" },
        desc = "File Explorer(Location File)",
      },
    },
  },
}
