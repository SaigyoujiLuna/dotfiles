local M = {}

---@type snacks.explorer.Config
M.opts = {
  enabled = true,
}

M.keys = {
  {
    "<leader>e",
    function()
      Snacks.explorer({
        cmd = "fd",
        follow = false,
        follow_file = false,
        git_untracked = true,
        ignored = true,
        hidden = true,
      })
    end,
  },
  {
    "<leader>E",
    function()
      Snacks.explorer({
        cmd = "fd",
        follow = false,
        follow_file = true,
        git_untracked = true,
        ignored = true,
        hidden = true,
      })
    end,
  },
}
return M
