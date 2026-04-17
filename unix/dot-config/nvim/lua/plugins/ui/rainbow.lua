return {
  {
    "HiPhish/rainbow-delimiters.nvim",
    cond = not vim.g.vscode,
    main = "rainbow-delimiters.setup",
    opts = {
      condition = function(bufnr)
        local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
        return ok and parser ~= nil
      end,
    },
  },
}
