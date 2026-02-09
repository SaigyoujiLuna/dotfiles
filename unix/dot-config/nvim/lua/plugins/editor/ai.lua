return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    dependencies = {
        -- "copilotlsp-nvim/copilot-lsp"
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
    "olimorris/codecompanion.nvim",
    event = "BufReadPost",
    dependencies = {
      "zbirenbaum/copilot.lua",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      adapters = {
        http = {
          gemini = function()
            return require("codecompanion.adapters").extend("gemini", {
              env = {
                api_key = "GEMINI_API_KEY",
              },
            })
          end,
        },
      },
      interactions = {
        chat = {
          adapter = "copilot",
          opts = {
            completion_providers = "blink",
          },
        },
        inline = {
          adapter = "copilot",
        },
        cmd = {
          adapter = "copilot",
        },
        background = {
          adapter = {
            name = "copilot",
          },
        },
      },
      opts = {
        log_level = "DEBUG", -- or "TRACE"
      },
    },
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
}
