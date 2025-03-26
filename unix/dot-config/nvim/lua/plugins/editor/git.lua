return {
  {
    "lewis6991/gitsigns.nvim",
    event = {"BufEnter"},
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
    },
    config = true,
    keys = {
      {
        "<leader>gb",
        function()
          require("gitsigns").toggle_current_line_blame()
        end,
        desc = "Current line blame",
      },
    },
  },
}
