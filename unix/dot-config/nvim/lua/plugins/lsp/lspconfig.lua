local diagnostics = {
  Error = " ",
  Warn = " ",
  Hint = " ",
  Info = " ",
}

return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
      },
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")

      mr:on("package:install::success", function()
        vim.defer_fn(function()
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)

      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts_extend = { "ensure_installed" },
    opts = {
      automatic_enable = true,
      ensure_installed = {
        "lua_ls",
        "bashls",
      },
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
    },
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    opts = {
      inlay_hints = {
        enabled = true,
      },
      codelens = {
        enabled = true,
      },
      ---@type vim.diagnostic.Opts
      diagnostics = {
        virtual_text = {
          spacing = 4,
          prefix = "●",
        },
        float = {
          severity_sort = true,
          border = "single",
          source = "if_many",
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        sign = {
          [vim.diagnostic.severity.ERROR] = diagnostics.Error,
          [vim.diagnostic.severity.WARN] = diagnostics.Warn,
          [vim.diagnostic.severity.INFO] = diagnostics.Info,
          [vim.diagnostic.severity.HINT] = diagnostics.Hint,
        },
      },
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              hint = {
                enable = true,
                setType = true,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
            },
          },
        },
      },
      -- setup = {},
    },
    config = function(_, opts)
      -- diagnostics
      opts.diagnostics = opts.diagnostics or {}
      vim.diagnostic.config(opts.diagnostics)
      -- inlay hints
      opts.inlay_hints = opts.inlay_hints or {}
      if opts.inlay_hints.enabled then
        YukiVim.lsp.on_attach(function(client, bufnr)
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end)
      end
      -- codelen
      opts.codelens = opts.codelens or {}
      if opts.codelens.enabled and vim.lsp.codelens then
        YukiVim.lsp.on_attach(function(client, bufnr)
          vim.lsp.codelens.refresh()
          vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
            buffer = bufnr,
            callback = vim.lsp.codelens.refresh,
          })
        end)
      end

      for server, config in pairs(opts.servers) do
        vim.lsp.config(server, config)
      end
    end,
    opts_extend = {
      "servers",
      "setup",
    },
  },
}
