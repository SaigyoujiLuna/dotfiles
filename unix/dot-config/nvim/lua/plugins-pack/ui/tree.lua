if vim.g.vscode then
    return
end
local api = require("nvim-tree.api")

local function on_attach(bufnr)
  api.map.on_attach.default(bufnr)
  vim.keymap.set("n", "y", api.fs.copy.node, { buffer = bufnr, noremap = true, silent = true, nowait = true })
  vim.keymap.set("n", "/", api.filter.toggle, { buffer = bufnr, noremap = true, silent = true, nowait = true })
  vim.keymap.set("n", "l", api.node.open.edit, { buffer = bufnr, noremap = true, silent = true, nowait = true })
  vim.keymap.set("n", "h", api.node.collapse, { buffer = bufnr, noremap = true, silent = true, nowait = true })
end

require("nvim-tree").setup({
  on_attach = on_attach,
  sort = {
    sorter = "case_sensitive",
  },
  git = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = true,
  },
  view = {
    width = {
      min = 30,
      max = "30%",
      padding = 1,
    },
  },
})
vim.keymap.set({ "n" }, "<leader>e", api.tree.toggle, { desc = "Toggle Explorer" })
vim.keymap.set({ "n" }, "<leader>E", function() api.tree.toggle({ find_file = true }) end, { desc = "Toggle Explorer(Current)" })
