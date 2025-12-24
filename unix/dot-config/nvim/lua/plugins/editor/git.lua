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
            target = "all",
          })
        end,
        desc = "Next Change"
      },
      {
        "]c",
        function()
          require("gitsigns").nav_hunk("next", {
            wrap = true,
            target = "all",
          })
        end,
        desc = "Prev Change"
      },
      {
        "do",
        function()
          require("gitsigns").preview_hunk_inline()
        end,
        desc = "diff hunk",
      },
      {
        "dO",
        function()
          require("gitsigns").stage_hunk()
        end,
        desc = "Toggle Staged",
      },
      {
        -- stage and next
        "du",
        function()
          require("gitsigns").stage_hunk()
          require("gitsigns").nav_hunk("next", {
            wrap = true,
            target = "unstaged"
          })
        end,
        desc = "Stage and Next"
      },
      {
        "dU",
        function()
          require("gitsigns").stage_hunk()
          require("gitsigns").nav_hunk("next", {
              wrap = true,
              target = "staged"
          })
        end,
        desc = "Unstage and Next"
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
