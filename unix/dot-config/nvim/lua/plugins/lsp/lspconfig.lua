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
    "neovim/nvim-lspconfig",
    dependencies = {
      { "mason.nvim" },
      { "williamboman/mason-lspconfig.nvim", config = function() end },
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
              { "]]", function() Snacks.words.jump(vim.v.count1, true) end,  has = "documentHighlight", desc = "Next Reference", cond = function() return Snacks.words.is_enabled() end },
              { "[[", function() Snacks.words.jump(-vim.v.count1, true) end, has = "documentHighlight", },
            },
        },
        stylua = { enabled = false },
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
      },
      ---@type table<string, fun(server: string, opts: vim.lsp.Config): boolean?>
      setup = {},
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
          vim.lsp.codelens.refresh()
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
        ensure_installed = vim.list_extend(install, YukiVim.opts("mason-lspconfig.nvim").ensure_installed or {}),
        automatic_enable = { exclude = mason_exclude },
      })
    end),
  },
}
