local M = {}

---@type snacks.notifier.Config
M.opts = {
  enabled = true,
  style = "fancy",
  width = {
    min = 40,
    max = 0.7,
  },
}
M.keys = {
  {
    "<leader>n",
    function()
        Snacks.notifier.show_history()
    end,
    desc = "Notification History",
  },
}
return M
