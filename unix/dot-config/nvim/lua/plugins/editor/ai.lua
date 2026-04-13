return {
  {
    "copilotlsp-nvim/copilot-lsp",
    init = function()
      vim.g.copilot_nes_debounce = 500
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    build = ":Copilot auth",
    dependencies = {
      "copilotlsp-nvim/copilot-lsp",
    },
    opts = function()
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
    version = vim.version.range("^19.0.0"),
    -- opts = {
    --   interactions = {
    --     chat = {
    --       adapter = "opencode",
    --     },
    --   },
    -- },
    config = function()
      require("codecompanion").setup({
        interactions = {
          chat = {
            adapter = "opencode",
          },
        },
      })
    end,
  },
  {
    "nickjvandyke/opencode.nvim",
    version = vim.version.range("*"),
    config = function()
      local opencode_cmd = "opencode --port"
      ---@type snacks.terminal.Opts
      local snacks_terminal_opts = {
        win = {
          position = "right",
          enter = false,
          on_win = function(win)
            -- Set up keymaps and cleanup for an arbitrary terminal
            require("opencode.terminal").setup(win.win)
          end,
        },
      }
      vim.g.opencode_opts = {
        lsp = {
          enabled = true,
        },
        server = {
          start = function()
            require("snacks.terminal").open(opencode_cmd, snacks_terminal_opts)
          end,
          stop = function()
            require("snacks.terminal").get(opencode_cmd, snacks_terminal_opts):close()
          end,
          toggle = function()
            require("snacks.terminal").toggle(opencode_cmd, snacks_terminal_opts)
          end,
        },
      }
    end,
  },
  -- {
  --   "yetone/avante.nvim",
  --   build = function(plugin)
  --     local res = vim.system({ "make" }, { cwd = plugin.path }):wait()
  --     if res.code == 0 then
  --       vim.notify("avante built successfully", vim.log.levels.INFO)
  --     else
  --       vim.notify("Failed to build avante: " .. res.stderr, vim.log.levels.ERROR)
  --     end
  --   end,
  --   event = "VeryLazy",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     "zbirenbaum/copilot.lua",
  --   },
  --   ---@module 'avante'
  --   ---@type avante.Config
  --   opts = {
  --     instructions_file = "AGENTS.md",
  --     provider = "copilot",
  --     behavior = {
  --       auto_suggestions = false,
  --     },
  --   },
  -- },
}
