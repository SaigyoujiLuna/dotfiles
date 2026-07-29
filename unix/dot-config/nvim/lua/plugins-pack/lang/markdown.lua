if vim.g.vscode then
  return
end

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "markdown-preview.nvim" and (kind == "install" or kind == "update") then
      vim.fn["mkdp#util#install"]()
    end
  end,
})
require("render-markdown").setup({})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "md", "markdown" },
  callback = function(ev)
    local buf = ev.buf
    vim.keymap.set({ "n" }, "<leader>cp", "<cmd>MarkdownPreviewToggle<cr>", { buf = buf, desc = "Markdown Preview" })
  end,
})
