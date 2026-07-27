return {
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = function()
      local api = require("nvim-tree.api")
      local function on_attach(bufnr)
        api.map.on_attach.default(bufnr)
        vim.keymap.set("n", "y", api.fs.copy.node, { buffer = bufnr, noremap = true, silent = true, nowait = true })
        vim.keymap.set("n", "/", api.filter.toggle, { buffer = bufnr, noremap = true, silent = true, nowait = true })
        vim.keymap.set("n", "l", api.node.open.edit, { buffer = bufnr, noremap = true, silent = true, nowait = true })
        vim.keymap.set("n", "h", api.node.collapse, { buffer = bufnr, noremap = true, silent = true, nowait = true })
      end
      ---@type nvim_tree.config
      return {
        on_attach = on_attach,
        sort = {
          sorter = "case_sensitive",
        },
        git = {
          enable = true,
          show_on_dirs = true,
          show_on_open_dirs = true,
        },
        view = {
          width = {
            min = 30,
            max = "30%",
            padding = 1,
          },
        },
      }
    end,
    config = function(_, opts)
      require("nvim-tree").setup(opts)
    end,
    keys = {
      {
        "<leader>e",
        function()
          require("nvim-tree.api").tree.toggle()
        end,
        desc = "Toggle Explorer",
      },
      {
        "<leader>E",
        function()
          require("nvim-tree.api").tree.toggle({ find_file = true })
        end,
        desc = "Toggle Explorer(Current)",
      },
    },
  },
}
