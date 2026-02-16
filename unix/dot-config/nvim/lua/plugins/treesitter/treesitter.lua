return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branch = "main",
    lazy = false,
    opts = {
      ensure_installed = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "java",
        "rust",
        "python",
      },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          node_incremental = "]x",
          node_decremental = "[x",
        },
      },
    },
    config = function(_, opts)
      local treesitter = require("nvim-treesitter")
      YukiVim.treesitter.setup(opts)
      treesitter.setup(opts)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "BufReadPost",
    opts = {
      move = {
        enable = true,
        set_jumps = true,
      },
    },
    keys = {
      {
        "]m",
        function()
          require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
        end,
        mode = "n",
      },
      {
        "[m",
        function()
          require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
        end,
        mode = { "n" },
        desc = "Go to previous function start",
      },
      {
        "]M",
        function()
          require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
        end,
        mode = { "n" },
        desc = "Go to next function end",
      },
      {
        "[M",
        function()
          require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
        end,
        mode = { "n" },
        desc = "Go to previous function end",
      },
      {
        "]/",
        function()
          require("nvim-treesitter-textobjects.move").goto_next_start("@comment.outer", "textobjects")
        end,
        mode = { "n" },
        desc = "Go to next comment start",
      },
      {
        "[/",
        function()
          require("nvim-treesitter-textobjects.move").goto_previous_start("@comment.outer", "textobjects")
        end,
        mode = { "n" },
        desc = "Go to previous comment start",
      },
      {
        "[*",
        function()
          require("nvim-treesitter-textobjects.move").goto_previous_start("@comment.outer", "textobjects")
        end,
        mode = { "n" },
        desc = "Go to previous comment start",
      },
      {
        "]*",
        function()
          require("nvim-treesitter-textobjects.move").goto_next_start("@comment.outer", "textobjects")
        end,
        mode = { "n" },
        desc = "Go to next comment start",
      },
      {
        "]]",
        function()
          require("nvim-treesitter-textobjects.move").goto_next_start(
            { "@class.outer", "@function.outer" },
            "textobjects"
          )
        end,
        mode = { "n" },
        desc = "Go to next section",
      },
      {
        "[[",
        function()
          require("nvim-treesitter-textobjects.move").goto_previous_start(
            { "@class.outer", "@function.outer" },
            "textobjects"
          )
        end,
        mode = { "n" },
        desc = "Go to previous section",
      },
      {
        "ac",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
        end,
        mode = { "n" },
        desc = "Select around class",
      },
      {
        "ic",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
        end,
        mode = { "n" },
        desc = "Select inner class",
      },
      {
        "af",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
        end,
        mode = { "n" },
        desc = "Select around method",
      },
      {
        "if",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
        end,
        mode = { "n" },
        desc = "Select inner method"
      },
    },
  },
}
