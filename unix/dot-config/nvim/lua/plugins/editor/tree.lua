vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    lazy = false,
    keys = {
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({ toggle = true })
        end,
        mode = { "n" },
        desc = "File Explorer",
      },
      {
        "<leader>E",
        function()
          require("neo-tree.command").execute({ toggle = true, find_file = true, reveal = true })
        end,
        mode = { "n" },
        desc = "File Explorer(Location File)",
      },
    },
    opts = {
      open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
      filesystem = {
        bind_to_cwd = false,
        use_libuv_file_watcher = true,
      },
    },
  },
  -- {
  --   "nvim-tree/nvim-tree.lua",
  --   opts = {},
  --   lazy = false,
  --   keys = {
  --     {
  --       "<leader>e",
  --       function()
  --         require("nvim-tree.api").tree.toggle({
  --             find_file = true
  --         })
  --       end,
  --       mode = { "n" },
  --       desc = "File Explorer",
  --     },
  --     {
  --       "<leader>E",
  --       function()
  --         require("nvim-tree.api").tree.toggle({ find_file = true })
  --       end,
  --       mode = { "n" },
  --       desc = "File Explorer(Location File)",
  --     },
  --   },
  -- }
}
