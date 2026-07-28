if vim.g.vscode then
  return
end
local keymap = vim.keymap.set

vim.pack.add({
  "https://github.com/saghen/blink.cmp",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
})
local ensure_installed = {
  "stylua",
  "shfmt",
  "java-debug-adapter",
  "java-test",
  "codelldb",
  "markdownlint-cli2",
  "markdown-toc",
}
local mason = require("mason")
mason.setup({
  ensure_installed = ensure_installed,
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})
local mr = require("mason-registry")
mr.refresh(function()
  for _, tool in ipairs(ensure_installed) do
    local p = mr.get_package(tool)
    if not p:is_installed() then
      p:install()
    end
  end
end)

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local buf = ev.buf
    keymap({ "n" }, "gd", function() vim.lsp.buf.definition() end, { desc = "Goto Definition", buf = buf })
    keymap({ "n" }, "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration", buf = buf })
    keymap({ "n" }, "gy", vim.lsp.buf.type_definition, { desc = "Goto Type Definition", buf = buf })
    keymap({ "n" }, "gI", vim.lsp.buf.implementation, { desc = "Goto Implementation" })
    keymap({ "n" }, "cd", vim.lsp.buf.rename, { desc = "Rename", nowait = true })
    keymap({ "n" }, "gA", vim.lsp.buf.references, { desc = "Goto References", nowait = true })
    keymap({ "n" }, "K", function() vim.lsp.buf.hover() end, { desc = "Hover" })
    keymap({ "n" }, "gh", vim.lsp.buf.hover, { desc = "Hover" })
    keymap({ "n" }, "gk", vim.lsp.buf.signature_help, { desc = "Signature Help" })
    keymap({ "n", "v" }, "g.", vim.lsp.buf.code_action, { desc = "Code Action" })
    keymap({ "i" }, "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
    keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
    keymap({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run, { desc = "Run Codelens" })
    keymap({ "n" }, "<leader>cN", function() Snacks.rename.rename_file() end, { desc = "Rename File" })
    keymap({ "n" }, "<leader>cd", vim.lsp.buf.rename, { desc = "Rename" })
    -- inlay hints
    Snacks.util.lsp.on({ method = "textDocument/inlayHint" }, function(buffer)
      if
        vim.api.nvim_buf_is_valid(buffer)
        and vim.bo[buffer].filetype ~= ""
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

vim.lsp.enable("stylua", false)
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

vim.lsp.config("marksman", {})

require("mason-lspconfig").setup({
  ensure_installed = { "jsonls" },
})
