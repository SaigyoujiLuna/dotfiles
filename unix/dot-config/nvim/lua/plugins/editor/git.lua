
return {
  {
    "lewis6991/gitsigns.nvim",
    config = true,
    keys = {
      {
        '<leader>gb',function() require("gitsigns").toggle_current_line_blame() end , desc = "Current line blame"
      },
    },
  },
}
