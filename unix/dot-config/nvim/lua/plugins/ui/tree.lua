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
      end
      return {
        on_attach = on_attach,
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
