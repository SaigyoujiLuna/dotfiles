return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branch = "main",
    lazy = false,
    opts = {
      ensure_installed = {
        "cpp",
        "c",
        "lua",
        "vim",
        "vimdoc",
        "java",
        "rust",
        "ron",
        "python",
        "ninja",
        "rst",
      },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    },
    config = function(_, opts)
      local treesitter = require("nvim-treesitter")
      YukiVim.treesitter.setup({
        incremental_selection = {
          enable = true,
          keymaps = {
            node_incremental = "]x",
            node_decremental = "[x",
          },
        },
      })
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
    opts = {},
    config = function()
      require("nvim-treesitter-textobjects").setup({
        move = {
          enable = true,
          set_jumps = true,
        },
      })
      vim.keymap.set({ "n" }, "]m", function()
        require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
      end, {
        desc = "Go to next function start",
      })
      vim.keymap.set({ "n" }, "[m", function()
        require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
      end, {
        desc = "Go to previous function start",
      })
      vim.keymap.set({ "n" }, "]M", function()
        require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
      end, {
        desc = "Go to next function end",
      })
      vim.keymap.set({ "n" }, "[M", function()
        require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
      end, {
        desc = "Go to previous function end",
      })
      vim.keymap.set({ "n" }, "]]", function()
        require("nvim-treesitter-textobjects.move").goto_next_start(
          { "@class.outer", "@function.outer" },
          "textobjects"
        )
      end, {
        desc = "Go to next section",
      })
      vim.keymap.set({ "n" }, "[[", function()
        require("nvim-treesitter-textobjects.move").goto_previous_start(
          { "@class.outer", "@function.outer" },
          "textobjects"
        )
      end, {
        desc = "Go to previous section",
      })
      vim.keymap.set({ "n" }, "][", function()
        require("nvim-treesitter-textobjects.move").goto_next_end({ "@function.outer", "@class.outer" }, "textobjects")
      end, {
        desc = "Go to next section end",
      })
      vim.keymap.set({ "n" }, "[]", function()
        require("nvim-treesitter-textobjects.move").goto_previous_end(
          { "@function.outer", "@class.outer" },
          "textobjects"
        )
      end, {
        desc = "Go to previous section end",
      })
      vim.keymap.set({ "n" }, "]/", function()
        require("nvim-treesitter-textobjects.move").goto_next_start("@comment.outer", "textobjects")
      end, {
        desc = "Go to next comment start",
      })
      vim.keymap.set({ "n" }, "[/", function()
        require("nvim-treesitter-textobjects.move").goto_previous_start("@comment.outer", "textobjects")
      end, {
        desc = "Go to previous comment start",
      })
      vim.keymap.set({ "n" }, "[*", function()
        require("nvim-treesitter-textobjects.move").goto_previous_start("@comment.outer", "textobjects")
      end, {
        desc = "Go to previous comment start",
      })
      vim.keymap.set({ "n" }, "]*", function()
        require("nvim-treesitter-textobjects.move").goto_next_start("@comment.outer", "textobjects")
      end, {
        desc = "Go to next comment start",
      })
      vim.keymap.set({ "v" }, "ac", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
      end, {
        desc = "Select around class",
      })
      vim.keymap.set({ "v" }, "ic", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
      end, {
        desc = "Select inner class",
      })
      vim.keymap.set({ "v" }, "af", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
      end, {
        desc = "Select around method",
      })
      vim.keymap.set({ "v" }, "if", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
      end, {
        desc = "Select inner method",
      })
    end,
  },
}
