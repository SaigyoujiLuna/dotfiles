vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "blink.cmp" and (kind == "update" or kind == "install") then
      if not ev.data.active then
        vim.cmd.packadd("blink.cmp")
      end
      require("blink.cmp").build():pwait()
    end
  end,
})
vim.pack.add({
  "https://github.com/saghen/blink.lib",
  "https://github.com/saghen/blink.cmp",
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/huijiro/blink-cmp-supermaven",
  "https://github.com/supermaven-inc/supermaven-nvim",
})
local blink = require("blink.cmp")
blink.setup({
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
})
