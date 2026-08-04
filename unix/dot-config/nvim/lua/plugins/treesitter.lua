local M = {}
M.packages = {
  "nvim-treesitter/nvim-treesitter",
  "nvim-treesitter/nvim-treesitter-context",
  "nvim-treesitter/nvim-treesitter-textobjects",
}
local treesitter_opts = {
  incremental_selection = {
    enable = true,
    keymaps = {
      node_incremental = "]x",
      node_decremental = "[x",
    },
  },
  ensure_installed = {
    "bash",
    "c",
    "cpp",
    "diff",
    "html",
    "java",
    "javascript",
    "jsdoc",
    "json",
    "lua",
    "luadoc",
    "luap",
    "markdown",
    "markdown_inline",
    "ninja",
    "printf",
    "python",
    "query",
    "regex",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "rust",
    "ron",
    "rst",
    "xml",
    "yaml",
  },
}
M.build = {
  ["nvim-treesitter"] = function()
    vim.cmd("TSUpdate")
  end,
}
M.config = function()
  local ts = require("nvim-treesitter")
  YukiVim.treesitter.setup(treesitter_opts)
  ts.setup(treesitter_opts)
  vim.schedule(function()
    ts.install(treesitter_opts.ensure_installed)
  end)
  vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

  vim.api.nvim_create_autocmd("FileType", {
    group = YukiVim.augroup("treesitter"),
    callback = function(ev)
      local ft = vim.bo[ev.buf].filetype
      if vim.tbl_contains(treesitter_opts.ensure_installed, ft) then
        vim.treesitter.start(ev.buf)
      end
    end,
  })

  local textobjects = require("nvim-treesitter-textobjects")
  textobjects.setup({ move = {
    enable = true,
    set_jumps = true,
  } })
  local keymap = vim.keymap.set
  local move = require("nvim-treesitter-textobjects.move")
  -- stylua: ignore
  keymap({ "n" }, "]m", function() move.goto_next_start("@function.outer", "textobjects") end, { desc = "Go to next function start", })
  -- stylua: ignore
  keymap({ "n" }, "[m", function() move.goto_previous_start("@function.outer", "textobjects") end, { desc = "Go to previous function start", })
  -- stylua: ignore
  keymap({ "n" }, "]M", function() move.goto_next_end("@function.outer", "textobjects") end, { desc = "Go to next function end", })
  -- stylua: ignore
  keymap({ "n" }, "[M", function() move.goto_previous_end("@function.outer", "textobjects") end, { desc = "Go to previous function end", })
  -- stylua: ignore
  keymap({ "n" }, "]]", function() move.goto_next_start({ "@class.outer", "@function.outer" }, "textobjects") end, { desc = "Go to next section", })
  -- stylua: ignore
  keymap({ "n" }, "[[", function() move.goto_previous_start({ "@class.outer", "@function.outer" }, "textobjects") end, { desc = "Go to previous section", })
  -- stylua: ignore
  keymap({ "n" }, "][", function() move.goto_next_end({ "@function.outer", "@class.outer" }, "textobjects") end, { desc = "Go to next section end", })
  -- stylua: ignore
  keymap({ "n" }, "[]", function() move.goto_previous_end({ "@function.outer", "@class.outer" }, "textobjects") end, { desc = "Go to previous section end", })
  -- stylua: ignore
  keymap({ "n" }, "]/", function() move.goto_next_start("@comment.outer", "textobjects") end, { desc = "Go to next comment start", })
  -- stylua: ignore
  keymap({ "n" }, "[/", function() move.goto_previous_start("@comment.outer", "textobjects") end, { desc = "Go to previous comment start", })
  -- stylua: ignore
  keymap({ "n" }, "[*", function() move.goto_previous_start("@comment.outer", "textobjects") end, { desc = "Go to previous comment start", })
  -- stylua: ignore
  keymap({ "n" }, "]*", function() move.goto_next_start("@comment.outer", "textobjects") end, { desc = "Go to next comment start", })

  local select = require("nvim-treesitter-textobjects.select")
  local function sel(lhs, capture, desc)
    keymap({ "v", "o" }, lhs, function()
      select.select_textobject(capture, "textobjects")
    end, { desc = desc })
  end

  -- class / definition
  sel("ac", "@class.outer", "Around class/definition")
  sel("ic", "@class.inner", "Inside class/definition")

  -- function / method
  sel("af", "@function.outer", "Around function/method")
  sel("if", "@function.inner", "Inside function/method")

  -- argument / parameter
  sel("ia", "@parameter.inner", "Inside argument/list item")
  sel("aa", "@parameter.outer", "Around argument/list item (with comma)")

  -- HTML-like tag
  sel("at", "@attribute.outer", "Around HTML-like tag")
  sel("it", "@attribute.inner", "Inside HTML-like tag")
end
return M
