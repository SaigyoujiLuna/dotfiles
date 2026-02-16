return {
  {
    "mfussenegger/nvim-lint",
    lazy = false,
    opts = {
      events = { "BufWritePost", "BufReadPost", "InsertLeave" },
      linters_by_ft = {},
    },
    config = function(_, opts)
      local M = {}
      local lint = require("lint")

      function M.lint()
        local names = lint._resolve_linter_by_ft(vim.bo.filetype)
        names = vim.list_extend({}, names)

        if #names == 0 then
          vim.list_extend(names, lint.linters_by_ft["_"] or {})
        end

        vim.list_extend(names, lint.linters_by_ft["*"] or {})

        local ctx = { filename = vim.api.nvim_buf_get_name(0) }
        ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
        names = vim.tbl_filter(function(name)
          local linter = lint.linters[name]
          return linter and not (type(linter) == "table")
        end, names)
        if #names > 0 then
            lint.try_lint(names)
        end
      end
      lint.linters_by_ft = opts.linters_by_ft
      vim.api.nvim_create_autocmd(opts.events, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = function()
            M.lint()
        end,
      })
    end,
  },
}
