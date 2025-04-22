return {
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({})
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
      "nvim-tree/nvim-web-devicons", -- optional
    },
    keys = {
      -- { "<C-/>", "<cmd>Lspsaga term_toggle<CR>", mode = { "n", "i", "t" }, desc = "Toggle terminal" },
      -- { "<C-_>", "<cmd>Lspsaga term_toggle<CR>", mode = { "n", "i", "t" }, desc = "Toggle terminal" },
    },
  },
}
