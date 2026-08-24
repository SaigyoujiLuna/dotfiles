if vim.g.vscode then
  return
end
require("clangd_extensions").setup({
  ast = {
    role_icons = {
      type = "",
      declaration = "",
      expression = "",
      specifier = "",
      statement = "",
      ["template argument"] = "",
    },
    kind_icons = {
      Compound = "",
      Recovery = "",
      TranslationUnit = "",
      PackExpansion = "",
      TemplateTypeParm = "",
      TemplateTemplateParm = "",
      TemplateParamObject = "",
    },
  },
})

vim.lsp.config("clangd", {
  root_markers = {
    "compile_commands.json",
    "compile_flags.txt",
    "configure.ac", -- AutoTools
    "Makefile",
    "configure.ac",
    "configure.in",
    "config.h.in",
    "meson.build",
    "meson_options.txt",
    "build.ninja",
    ".git",
  },
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
})

vim.lsp.enable("clangd", true)

-- dap config
local dap = require("dap")
if not dap.adapters["codelldb"] then
  dap.adapters["codelldb"] = {
    type = "server",
    host = "127.0.0.1",
    port = "${port}",
    executable = {
      command = "codelldb",
      args = { "--port", "${port}" },
    },
  }
end

---@type dap.Configuration[]
local dap_config = {
  {
    type = "codelldb",
    request = "launch",
    name = "Launch file",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
  },
  {
    type = "codelldb",
    request = "attach",
    name = "Attach to process",
    processId = require("dap.utils").pick_process,
    cwd = "${workspaceFolder}",
  },
}
dap.configurations.c = dap_config
dap.configurations.cpp = dap_config
