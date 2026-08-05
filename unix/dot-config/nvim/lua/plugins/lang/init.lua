local M = {}
M.packages = {
  "https://github.com/dchinmay2/clangd_extensions.nvim",
  "https://github.com/terrastruct/d2-vim",
  "https://github.com/mfussenegger/nvim-jdtls",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
  "https://github.com/iamcco/markdown-preview.nvim",
  "https://github.com/linux-cultist/venv-selector.nvim",
  "https://github.com/Saecki/crates.nvim",
  { src = "https://github.com/mrcjkb/rustaceanvim", version = vim.version.range("^9") },
  "https://github.com/wojciech-kulik/xcodebuild.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
}

if vim.g.vscode then
  return M
end

M.config = function()
  local group = YukiVim.augroup("plugins-lang")
  vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    group = group,
    once = true,
    callback = function()
      require("plugins.lang.lsp")
      require("plugins.lang.clangd")
      require("plugins.lang.d2")
      require("plugins.lang.java")
      require("plugins.lang.markdown")
      require("plugins.lang.python")
      require("plugins.lang.rust")
      require("plugins.lang.typescript")
    end,
  })
end
return M
