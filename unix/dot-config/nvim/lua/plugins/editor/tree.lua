vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
return {
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
    },
    lazy = false,
    keys = {
      { "<leader>e", ":NvimTreeToggle<CR>", mode = { "n" }, desc = "File Explorer"},
      { "<leader>E", ":NvimTreeFindFileToggle<CR>", mode = { "n" }, desc = "File Explorer(Location File)" },
    },
  },
}
