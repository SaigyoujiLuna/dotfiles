local map = vim.keymap.set
-- diagnostic
local diagnostic_goto = function(next, severity)
  return function()
    vim.diagnostic.jump({
      count = (next and 1 or -1) * vim.v.count1,
      severity = severity and vim.diagnostic.severity[severity] or nil,
      float = true,
    })
  end
end
map("n", "gh", vim.diagnostic.show, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "g[", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "g]", diagnostic_goto(true), { desc = "Next Diagnostic" })
