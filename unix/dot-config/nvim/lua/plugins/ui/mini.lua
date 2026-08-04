require("mini.notify").setup({})
require("mini.pairs").setup()
require("mini.surround").setup({})
local md = require("mini.diff")
md.setup({})

local mc = require("mini.icons")
mc.setup()
mc.mock_nvim_web_devicons()
-- stylua: ignore
vim.keymap.set({ "n" }, "<leader>n", MiniNotify.show_history, { desc = "Notification History" })
-- stylua: ignore
vim.keymap.set({ "n" }, "[c", function() md.goto_hunk("prev", { wrap = true, }) end, { desc = "Next Change" })
-- stylua: ignore
vim.keymap.set({ "n" }, "]c", function() md.goto_hunk("next", { wrap = true, }) end, { desc = "Prev Change" })
-- stylua: ignore
vim.keymap.set({ "n" }, "do", function() md.toggle_overlay(vim.api.nvim_get_current_buf()) end)

local function do_current_hunk(action)
  local line = vim.api.nvim_win_get_cursor(vim.api.nvim_get_current_win())[1]
  md.do_hunks(vim.api.nvim_get_current_buf(), action, {
    line_start = line,
    line_end = line,
  })
end

-- stylua: ignore
vim.keymap.set({ "n" }, "dO", function() do_current_hunk("apply") end, { desc = "Stage hunk" })
-- stylua: ignore
vim.keymap.set({ "n" }, "du", function() md.do_hunks(vim.api.nvim_get_current_buf(), "apply" ) md.goto_hunk("next", { wrap = true }) end, { desc = "Stage and next" })
-- stylua: ignore
vim.keymap.set({ "n" }, "dp", function() md.do_hunks(vim.api.nvim_get_current_buf(), "reset") end, { desc = "Restore hunk" })
