if vim.g.vscode then
  return
end
require("rainbow-delimiters.setup").setup({
  condition = function(bufnr)
    local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
    return ok and parser ~= nil
  end,
})
