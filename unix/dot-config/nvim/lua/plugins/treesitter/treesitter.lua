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
      local select = require("nvim-treesitter-textobjects.select")
      local function sel(lhs, capture, desc)
        vim.keymap.set({ "v", "o" }, lhs, function()
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

    end,
  },
}
