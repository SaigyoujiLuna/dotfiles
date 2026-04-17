return {
  {
    "echasnovski/mini.indentscope",
    branch = "main",
    opts = {
      mappings = {
        object_scope = "ii",
        object_scope_with_border = "aI", -- handled manually below as ai/aI
        goto_top = "",
        goto_bottom = "",
      },
      options = {
        border = "both", -- default for ai: include only the header line above
      },
    },
    config = function(_, opts)
      local mis = require("mini.indentscope")
      mis.setup(opts)

      -- ai: scope + top border only (header line, e.g. `if`/`case`)
      vim.keymap.set({ "x", "o" }, "ai", function()
        vim.b.miniindentscope_config = { options = { border = "top" } }
        mis.textobject(true)
        vim.b.miniindentscope_config = nil
      end, { desc = "Around indent scope (with header line above)" })
    end,
  },
}
