return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    branch="master",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "BurntSushi/ripgrep",
      "sharkdp/fd",
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = function(plugin)
          local res = vim
            .system({
              "make",
            }, { cwd = plugin.path })
            :wait()
          if res.code == 0 then
            vim.notify("Build Telescope Fzf succeed", vim.log.levels.INFO)
          else
            vim.notify("Build Telescope Fzf failed", vim.log.levels.ERROR)
          end
        end,
      },
    },
    opts = {
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("fzf")
    end,
    keys = {
      {
        "<leader><Space>",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = "Find in files",
        remap = false,
      },
      {
        "<leader>/",
        function()
          require("telescope.builtin").live_grep()
        end,
        remap = false,
        desc = "Live grep",
      },
      {
        "gs",
        function()
          require("telescope.builtin").lsp_document_symbols({ symbols = YukiVim.config.get_kind_filter() })
        end,
        remap = false,
        desc = "Goto Symbol",
      },
      {
        "gS",
        function()
          require("telescope.builtin").lsp_workspace_symbols({ symbols = YukiVim.config.get_kind_filter() })
        end,
        remap = false,
        desc = "Goto Symbol (Workspace)",
      },
      -- {
      --   "<leader>x",
      --   function()
      --     require("telescope.builtin").diagnostics()
      --   end,
      -- },
    },
  },
}
