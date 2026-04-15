return {
  {
    "saghen/blink.cmp",
    cond = not vim.g.vscode,
    dependencies = {
      "rafamadriz/friendly-snippets",
      "neovim/nvim-lspconfig",
      "huijiro/blink-cmp-supermaven",
      "supermaven-inc/supermaven-nvim",
    },
    build = function(plugin)
      local obj = vim.system({ "cargo", "build", "--release" }, { cwd = plugin.path }):wait()
      if obj.code == 0 then
        vim.notify("Building blink.cmp done", vim.log.levels.INFO)
      else
        vim.notify("Building blink.cmp failed", vim.log.levels.ERROR)
      end
    end,
    sem_version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "super-tab",
        ["<Tab>"] = {
          "accept",
          YukiVim.cmp.map({ "snippet_forward", "ai_accept" }),
          "select_and_accept",
          "fallback",
        },
        ["<C-Tab>"] = { "hide" },
        ["<CR>"] = { "select_and_accept", "fallback" },
      },

      appearance = {
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },
      completion = {
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          border = "rounded",

          draw = {
            gap = 2,
            treesitter = { "lsp" },
          },
        },
        list = {
          selection = {
            preselect = false,
            auto_insert = false,
          },
          cycle = {
            from_top = false,
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 300,
          window = { border = "rounded", winblend = vim.o.winblend },
        },
        ghost_text = {
          enabled = false,
          show_with_menu = false,
        },
      },
      -- Default list of enabled providers defined so that you can extend it
      -- add lazydev to your completion providers
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "lazydev" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            fallbacks = { "lsp" },
            score_offset = 100,
          },
        },
      },

      -- Blink.cmp uses a Rust fuzzy matcher by default for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust" },
      signature = {
        enabled = true,
        window = { border = "rounded", winblend = vim.o.winblend },
      },
    },
    opts_extend = {
      "sources.completion.enabled_providers",
      "sources.compat",
      "sources.default",
    },
  },
}
