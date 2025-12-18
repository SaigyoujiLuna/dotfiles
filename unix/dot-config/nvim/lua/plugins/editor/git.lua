return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufEnter" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      current_line_blame = true,
    },
    keys = {
      {
        "[c",
        function()
          require("gitsigns").nav_hunk("prev", {
            wrap = true,
          })
        end,
      },
      {
        "]c",
        function()
          require("gitsigns").nav_hunk("next", {
            wrap = true,
          })
        end,
      },
      {
        "do",
        function()
          require("gitsigns").preview_hunk()
        end,
        desc = "diff hunk",
      },
      {
        "dp",
        function()
          require("gitsigns").reset_hunk()
        end,
        desc = "Restore change",
      },
    },
  },
}
