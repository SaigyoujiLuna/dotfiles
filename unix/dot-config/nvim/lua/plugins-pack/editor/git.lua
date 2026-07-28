if vim.g.vscode then
  return
end
vim.pack.add({
  "https://github.com/lewis6991/gitsigns.nvim",
})
local gs = require("gitsigns")
gs.setup({
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
})
vim.keymap.set({ "n" }, "[c", function()
  gs.nav_hunk("prev", {
    wrap = true,
    target = "all",
  })
end, {
  desc = "Next Change",
})
vim.keymap.set({ "n" }, "]c", function()
  gs.nav_hunk("next", {
    wrap = true,
    target = "all",
  })
end, { desc = "Prev Change" })
vim.keymap.set({ "n" }, "do", function()
  gs.preview_hunk_inline()
end, {
  desc = "diff hunk",
})
vim.keymap.set({ "n" }, "dO", function()
  gs.stage_hunk()
end, { desc = "Toggle Staged" })
vim.keymap.set(
  { "n" },
  -- stage and next
  "du",
  function()
    gs.stage_hunk()
    gs.nav_hunk("next", {
      wrap = true,
      target = "unstaged",
    })
  end,
  { desc = "Stage and Next" }
)
vim.keymap.set({ "n" }, "dU", function()
  gs.stage_hunk()
  gs.nav_hunk("next", {
    wrap = true,
    target = "staged",
  })
end, { desc = "Unstage and Next" })
vim.keymap.set({ "n" }, "dp", function()
  gs.reset_hunk()
end, { desc = "Restore change" })
