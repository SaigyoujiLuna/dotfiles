if vim.g.vscode or vim.uv.os_uname().sysname ~= "Darwin" then
  return
end

vim.pack.add({
  "https://github.com/wojciech-kulik/xcodebuild.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/folke/snacks.nvim", -- (optional) to show previews
  "https://github.com/MunifTanjim/nui.nvim",
})

require("xcodebuild").setup({})

if vim.uv.os_uname().sysname == "Darwin" then
  vim.lsp.config("sourcekit", {
    rootdir = function(_, callback)
      callback(
        require("lspconfig.util").root_pattern("Package.swift")(vim.fn.getcwd())
          or vim.fs.dirname(vim.fs.find("git", { path = vim.fn.getcwd(), upward = true })[1])
      )
    end,
    cmd = function()
      return { vim.trim(vim.fn.system("xcrun -f sourcekit-lsp")) }
    end,
  })
  vim.lsp.enable("sourcekit", true)
end
