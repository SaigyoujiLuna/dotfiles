return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "mikavilpas/blink-ripgrep.nvim",
      { "saghen/blink.compat", optinal = true, opts = {}, version = "*" },
    },
    build = "cargo build --release",
    version = "*",
    event = "InsertEnter",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "enter",
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      },

      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = false,
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
          auto_show = true,

          border = "rounded",

          draw = {
            treesitter = { "lsp" },
          },
        },
        list = {
          selection = {
            preselect = false,
            auto_insert = false,
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 600,
          window = { border = "rounded" },
        },
        ghost_text = {
          enabled = true,
        },
      },
      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "ripgrep" },
        providers = {
          ripgrep = {
            module = "blink-ripgrep",
            name = "Ripgrep",
            opts = {
              prefix_min_len = 3,
              context_size = 5,
              max_filesize = "512K",
              project_root_marker = { ".git", "package.json" },
              project_root_fallback = false,
              search_casing = "--smart-case",
              future_features = {
                on_off = "<leader>tg",
              },
            },
          },
        },
      },

      -- Blink.cmp uses a Rust fuzzy matcher by default for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" },
      signature = { window = { border = "rounded" } },
    },
    opts_extend = {
      "sources.compat",
      "sources.default",
    },
    config = function(_, opts)
      local enabled = opts.sources.default
      for _, source in ipairs(opts.sources.compat or {}) do
        opts.sources.providers[source] = vim.tbl_deep_extend(
          "force",
          { name = source, module = "blink.compat.source" },
          opts.sources.providers[source] or {}
        )
        if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
          table.insert(enabled, source)
        end
      end
      opts.sources.compat = nil
      require("blink.cmp").setup(opts)
    end,
  },
  {
    "saghen/blink.compat",
    version = "*",
    lazy = true,
    opts = {},
  },
}
