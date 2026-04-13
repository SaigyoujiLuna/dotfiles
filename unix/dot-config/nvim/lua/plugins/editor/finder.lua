return {
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
  {
    "nvim-telescope/telescope.nvim",
    version = vim.version.range("*"),
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- find_files grep support
      "BurntSushi/ripgrep",
      -- finder
      "sharkdp/fd",
      -- icons
      "nvim-tree/nvim-web-devicons",
      -- sorting performance
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    config = function()
      require("telescope").setup({

        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })
      require("telescope").load_extension("fzf")
    end,
    keys = {
      {
        "<leader><Space>",
        function()
          vim.notify("Finder is not available in this version", vim.log.levels.WARN)
          require("telescope.builtin").find_files()
        end,
        mode = { "n" },
        desc = "Find in files",
        -- remap = false,
      },
      {
        "<leader>/",
        function()
          require("telescope.builtin").live_grep()
        end,
        -- remap = false,
        mode = { "n" },
        desc = "Live grep",
      },
      {
        "gs",
        function()
          require("telescope.builtin").lsp_document_symbols({ symbols = YukiVim.config.get_kind_filter() })
        end,
        -- remap = false,
        mode = { "n" },
        desc = "Goto Symbol",
      },
      {
        "gS",
        function()
          require("telescope.builtin").lsp_workspace_symbols({ symbols = YukiVim.config.get_kind_filter() })
        end,
        -- remap = false,
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
