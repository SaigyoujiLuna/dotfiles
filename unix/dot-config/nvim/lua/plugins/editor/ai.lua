return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    dependencies = {
      "copilotlsp-nvim/copilot-lsp",
    },
    opts = function()
      YukiVim.cmp.actions.ai_accept = function()
        if require("copilot.suggestion").is_visible() then
          YukiVim.create_undo()
          require("copilot.suggestion").accept()
          return true
        end
      end
      return {
        suggestion = {
          enabled = true,
          auto_trigger = true,
          hide_during_completion = false,
          keymap = {
            accept = false,
          },
        },
        panels = {
          enabled = false,
        },
        filetypes = {
          markdown = true,
          help = true,
        },
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        copilot = {
          enabled = false,
        },
      },
    },
  },
  {
    "yetone/avante.nvim",
    build = "make",
    event = "VeryLazy",
    version = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "zbirenbaum/copilot.lua"
    },
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      instructions_file = "AGENTS.md",
      provider = "copilot",
      behavior = {
          auto_suggestions = false,
      }
    },
  },
}
