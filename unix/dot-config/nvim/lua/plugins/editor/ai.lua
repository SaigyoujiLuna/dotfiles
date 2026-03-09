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
    keys = {
      {
        "<C-x><C-a>",
        function()
          local origin_mode = vim.fn.mode()
          if origin_mode == "i" then
              
              vim.cmd("stopinsert")
          end
          if origin_mode == "n" or origin_mode == "i" then
            local pos = vim.api.nvim_win_get_cursor(0)
            vim.api.nvim_win_set_cursor(0, { pos[1], 0 })
            vim.cmd("normal! v$")
          end
          -- open a dialog get the prompt and then call the inline interaction
          local prompt = vim.fn.input("Prompt: ")
          -- if exit, do nothing,
          if prompt == "" then
            return
          end

          require("codecompanion").inline({ args = prompt })
          -- recovery to origin cursor and origin mode
          -- vim.cmd("normal! " .. origin_mode)
        end,
        mode = { "n", "v", "i" },
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
