vim.pack.add({
  "https://github.com/echasnovski/mini.indentscope",
})
local mis = require("mini.indentscope")
mis.setup({
  mappings = {
    object_scope = "ii",
    object_scope_with_border = "aI", -- handled manually below as ai/aI
    goto_top = "",
    goto_bottom = "",
  },
  options = {
    border = "both", -- default for ai: include only the header line above
  },
})

vim.keymap.set({ "x", "o" }, "ai", function()
  vim.b.miniindentscope_config = { options = { border = "top" } }
  mis.textobject(true)
  vim.b.miniindentscope_config = nil
end, { desc = "Around indent scope (with header line above)" })
