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
      local builtin = require("telescope.builtin")
      vim.keymap.set({ "n" }, "<leader><Space>", builtin.find_files, {
        desc = "Find in files",
      })
      vim.keymap.set({ "n" }, "<leader>/", builtin.live_grep, {
        desc = "Live grep",
      })
      vim.keymap.set({ "n" }, "gs", function()
        builtin.lsp_document_symbols({ symbols = YukiVim.config.get_kind_filter() })
      end, {
        desc = "Goto Symbol",
      })
      vim.keymap.set({ "n" }, "gS", function()
        builtin.lsp_workspace_symbols({ symbols = YukiVim.config.get_kind_filter() })
      end, {
        desc = "Goto Symbol (Workspace)",
      })
      vim.keymap.set({ "n" }, "<leader>x", builtin.diagnostics, {
        desc = "Diagnostics",
      })
    end,
  },
}
