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
