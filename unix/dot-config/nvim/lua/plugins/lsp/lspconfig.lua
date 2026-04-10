return {
  {
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    cond = not vim.g.vscode,
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
      "mason-org/mason.nvim",
      { "mason-org/mason-lspconfig.nvim", config = function() end },
    },
    cond = not vim.g.vscode,
    opts = {
      -- stylua: ignore
      keys = {
        { "gd", function() vim.lsp.buf.definition() end, desc = "Goto Definition", has = "definition" },
        { "gD", function() vim.lsp.buf.declaration() end, desc = "Goto Declaration" },
        { "gy", function() vim.lsp.buf.type_definition() end, desc = "Goto Type Definition" },
        { "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" },
        { "cd", function() vim.lsp.buf.rename() end , desc = "Rename", nowait = true },
        { "gA", vim.lsp.buf.references, desc = "Goto References", nowait = true },
        { "K", function() vim.lsp.buf.hover() end, desc = "Hover", },
        { "gh", function() return vim.lsp.buf.hover() end, desc = "Hover", },
        { "gk", function() return vim.lsp.buf.signature_help() end, desc = "Signature Help", has = "signatureHelp", },
        { "g.", function() return vim.lsp.buf.code_action() end, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
        { "<C-k>", function() return vim.lsp.buf.signature_help() end, mode = "i", desc = "Signature Help", has = "signatureHelp", },
        { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v", }, has = "codeAction", },
        { "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v", }, has = "codeLens", },
        { "<leader>cN", function() Snacks.rename.rename_file() end, desc = "Rename File", mode = { "n", }, has = { "workspace/didRenameFiles", "workspace/willRenameFiles", }, },
        { "<leader>cd", vim.lsp.buf.rename, desc = "Rename", has = "rename", },
      },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          -- keymaps
          YukiVim.lsp.set_keymap({ name = nil }, opts.keys)
          -- inlay hints
          Snacks.util.lsp.on({ method = "textDocument/inlayHint" }, function(buffer)
            if
              vim.api.nvim_buf_is_valid(buffer)
              and vim.bo[buffer].filetype == ""
              and not vim.tbl_contains({ "vue" }, vim.bo[buffer].filetype)
            then
              vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
            end
            -- code lens
            vim.lsp.codelens.enable(true)
            -- diagnostics
            vim.diagnostic.config({
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
            })
          end)
        end,
      })

      vim.lsp.enable("vtsls", true)
      vim.lsp.config("vtsls", {
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
      })

      vim.lsp.enable("rust_analyzer", false)
      vim.lsp.enable("bacon-ls", true)
      vim.lsp.config("bacon-ls", {
        init_options = {
          undateOnSave = true,
          undateOnSaveWaitMillis = 1000,
        },
      })
      vim.lsp.config("ruff", {
        enabled = true,
        cmd_env = { RUFF_TRACE = "messages" },
        init_options = {
          settings = {
            logLevel = "error",
          },
        },
      })
      Snacks.util.lsp.on({ name = "ruff" }, function(_, client)
        client.server_capabilities.hoverProvider = false
      end)
      vim.lsp.enable("stylua", false)
      vim.lsp.config("basedpyright", {
        enabled = true,
      })
      vim.lsp.enable("lua_ls", true)
      vim.lsp.config("lua_ls", {
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
      })

      vim.lsp.config("ruff_lsp", {})
      vim.lsp.enable("copilot", true)
      vim.lsp.inline_completion.enable(true)
      vim.lsp.config("marksman", {})
      vim.lsp.config("sourcekit", {
        rootdir = function(_, callback)
          callback(
            require("lspconfig.util").root_pattern("Package.swift")(vim.fn.getcwd())
              or vim.fs.dirname(vim.fs.find("git", { path = vim.fn.getcwd(), upward = true })[1])
          )
        end,
        cmd = { vim.trim(vim.fn.system("xcrun -f sourcekit-lsp")) },
      })
      vim.lsp.enable("sourcekit", true)
      Snacks.util.lsp.on({ name = "sourcekit" }, function(client)
        if vim.lsp.is_enabled("clangd") then
          vim.lsp.enable("clangd", false)
        end
      end)
      YukiVim.cmp.actions.ai_accept = function()
        return vim.lsp.inline_completion.get()
      end

      require("mason-lspconfig").setup({
        ensure_installed = { "jsonls" },
      })
    end,
  },
}
