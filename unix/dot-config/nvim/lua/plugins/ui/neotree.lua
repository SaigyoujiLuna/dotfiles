return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      vim.g.neovide and {} or { "3rd/image.nvim", opts = {} } -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    opts = {
      close_if_last_window = false,
      popup_border_style = "rounded",

      filesystem = {
        filtered_items = {
          visible = true,
        },
      },
    },
    keys = {
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({

            toggle = true,
            source = "filesystem",
            position = "left",
          })
        end,
        desc = "NeoTree",
      },
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute({
            toggle = true,
            source = "filesystem",
            position = "left",
          })
        end,
        desc = "NeoTree(Cwd)",
      },
      {
        "<leader>fg",

        function()
          require("neo-tree.command").execute({
            toggle = true,
            source = "git_status",
            position = "left",
          })
        end,

        desc = "NeoTree (Git)",
      },
      {
        "<leader>fb",
        function()
          require("neo-tree.command").execute({
            toggle = true,
            source = "buffers",
            position = "left",
          })
        end,

        desc = "NeoTree (Buffer)",
      },
    },
  },
}
