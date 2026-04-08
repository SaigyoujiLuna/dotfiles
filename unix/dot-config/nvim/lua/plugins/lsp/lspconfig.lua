return {
  {
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    ---@type MasonSettings
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        "java-debug-adapter",
        "java-test",
        "codelldb",
        "markdownlint-cli2",
        "markdown-toc",
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
    "neovim/nvim-lspconfig",
    dependencies = {
      { "mason-org/mason.nvim" },
      { "mason-org/mason-lspconfig.nvim", config = function() end },
    },
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    opts_extend = { "servers.*.keys" },
    opts = {
      ---@type vim.diagnostic.Opts
      diagnostics = {
        virtual_text = {
          spacing = 2,
          source = "if_many",
          prefix = "●",
        },
        float = {
          severity_sort = true,
          border = "rounded",
          source = "if_many",
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = YukiVim.config.icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = YukiVim.config.icons.diagnostics.Warn,
            [vim.diagnostic.severity.INFO] = YukiVim.config.icons.diagnostics.Info,
            [vim.diagnostic.severity.HINT] = YukiVim.config.icons.diagnostics.Hint,
          },
        },
      },
      inlay_hints = {
        enabled = true,
        exclude = { "vue" },
      },
      codelens = {
        enabled = true,
      },
      folds = {
        enabled = false,
      },
      -- format = {
      --   formatting_options = nil,
      --   timeout_ms = nil,
      -- },
      servers = {
        marksman = {},
        copilot = {
          enabled = false,
        },
        clangd = {
          capabilities = {
            offsetEncoding = { "utf-16" },
          },
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        },

        ["*"] = {
          -- stylua: ignore
            keys = {
              { "gd", vim.lsp.buf.definition, desc = "Goto Definition", has = "definition" },
              { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
              { "gy", vim.lsp.buf.type_definition, desc = "Goto Type Definition" },
              { "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" },
              { "cd", vim.lsp.buf.rename, desc = "Rename", nowait = true },
              { "gA", vim.lsp.buf.references, desc = "Goto References", nowait = true },
              { "K", function() return vim.lsp.buf.hover() end, desc = "Hover", },
              { "gh", function() return vim.lsp.buf.hover() end, desc = "Hover", },
              { "gk", function() return vim.lsp.buf.signature_help() end, desc = "Signature Help", has = "signatureHelp", },
              { "g.", function() return vim.lsp.buf.code_action() end, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
              { "<C-k>", function() return vim.lsp.buf.signature_help() end, mode = "i", desc = "Signature Help", has = "signatureHelp", },
              { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v", }, has = "codeAction", },
              { "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v", }, has = "codeLens", },
              { "<leader>cC", vim.lsp.codelens.refresh, desc = "Refresh Codelens", mode = { "n", }, has = "codeLens", },
              { "<leader>cN", function() Snacks.rename.rename_file() end, desc = "Rename File", mode = { "n", }, has = { "workspace/didRenameFiles", "workspace/willRenameFiles", }, },
              { "<leader>cd", vim.lsp.buf.rename, desc = "Rename", has = "rename", },
            },
        },
        vtsls = {
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
          },
          settings = {
            complete_function_calls = true,
            vtsls = {
              enableMoveToFileCodeAction = true,
              autoUseWorkspaceTsdk = true,
              experimental = {
                maxInlayHintLength = 30,
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
            },
            typescript = {
              updateImportsOnFileMove = { enabled = "always" },
              suggest = {
                completeFunctionCalls = true,
              },
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
            },
          },
        },
        bacons_ls = {
          enabled = false,
        },
        rust_analyzer = {
          enabled = false,
        },
        ruff = {
          enabled = true,
          cmd_env = { RUFF_TRACE = "messages" },
          init_options = {
            settings = {
              logLevel = "error",
            },
          },
        },
        ruff_lsp = {},

        stylua = { enabled = false },
        basedpyright = {
          enabled = true,
        },
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              codeLens = {
                enabled = true,
              },
              completion = {
                callSnippet = "Replace",
              },
              doc = {
                privateName = { "^_" },
              },
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
        jdtls = {},
      },
      ---@type table<string, fun(server: string, opts: vim.lsp.Config): boolean?>
      setup = {
        jdtls = function()
          return true -- avoid duplicate servers
        end,

        ["ruff"] = function()
          Snacks.util.lsp.on({ name = "ruff" }, function(_, client)
            client.server_capabilities.hoverProvider = false
          end)
        end,
        clangd = function(_, opts)
          require("clangd_extensions").setup({ server = opts })
          return false
        end,
      },
    },
    config = vim.schedule_wrap(function(_, opts)
      -- keymaps
      for server, server_opts in pairs(opts.servers) do
        if type(server_opts) == "table" and server_opts.keys then
          YukiVim.lsp.set_keymap({ name = server ~= "*" and server or nil }, server_opts.keys)
        end
      end
      -- inlay hints
      if opts.inlay_hints.enabled then
        Snacks.util.lsp.on({ method = "textDocument/inlayHint" }, function(buffer)
          if
            vim.api.nvim_buf_is_valid(buffer)
            and vim.bo[buffer].filetype == ""
            and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
          then
            vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
          end
        end)
      end
      -- folds
      if opts.folds.enabled then
        Snacks.util.lsp.on({ method = "textDocument/foldingRange" }, function()
          vim.api.nvim_set_option_value("foldmethod", "expr", { scope = "local" })
          vim.api.nvim_set_option_value("foldexpr", "v:lua.vim.lsp.foldexpr()", { scope = "local" })
        end)
      end

      -- code lens
      if opts.codelens.enabled and vim.lsp.codelens then
        Snacks.util.lsp.on({ method = "textDocument/codeLens" }, function(buffer)
          vim.lsp.codelens.refresh({ bufnr = buffer })
          vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
            buffer = buffer,
            callback = vim.lsp.codelens.refresh,
          })
        end)
      end
      -- diagnostics
      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
      if opts.servers["*"] then
        vim.lsp.config("*", opts.servers["*"])
      end
      local mason_all = vim.tbl_keys(require("mason-lspconfig.mappings").get_mason_map().lspconfig_to_package)
      local mason_exclude = {} ---@type string[]

      ---@return boolean? exclude automatic setup
      local function configure(server)
        if server == "*" then
          return false
        end
        local sopts = opts.servers[server]
        sopts = sopts == true and {} or (not sopts) and { enabled = false } or sopts

        if sopts.enabled == false then
          mason_exclude[#mason_exclude + 1] = server
          return
        end

        local use_mason = sopts.mason ~= false and vim.tbl_contains(mason_all, server)
        local setup = opts.setup[server] or opts.setup["*"]
        if setup and setup(server, sopts) then
          mason_exclude[#mason_exclude + 1] = server
        else
          vim.lsp.config(server, sopts) -- configure the server
          if not use_mason then
            vim.lsp.enable(server)
          end
        end
        return use_mason
      end
      local install = vim.tbl_filter(configure, vim.tbl_keys(opts.servers))
      require("mason-lspconfig").setup({
        ensure_installed = vim.list_extend(install, { "jsonls", "clangd" }),
        automatic_enable = { exclude = mason_exclude },
      })
    end),
  },
}
