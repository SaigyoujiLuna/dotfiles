if vim.g.vscode then
  return
end

local keymap = vim.keymap.set


require("bufferline").setup({
  highlights = require("catppuccin.special.bufferline").get_theme(),
  options = {
    -- separator_style = "slant",
    always_show_bufferline = false,
    close_command = function(n)
      -- Snacks.bufdelete(n)
    end,
    right_mouse_command = function(n)
      -- Snacks.bufdelete(n)
    end,
    diagnostics = "nvim_lsp",
    offsets = {
      {
        filetype = "neo-tree",
        text = "NeoTree",
        highlight = "Directory",
        text_align = "left",
      },
      {
        filetype = "snacks_layout_box",
      },
      {
        filetype = "NvimTree",
        text = "NvimTree",
        highlight = "Directory",
        text_align = "left",
      },
    },
  },
})

vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
  callback = function()
    vim.schedule(function()
      pcall(nvim_bufferline)
    end)
  end,
})
keymap({ "n" }, "[b", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev Buffer" })
keymap({ "n" }, "]b", "<cmd>BufferLineCycleNext<CR>", { desc = "Next Buffer" })
keymap({ "n" }, "<S-h>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev Buffer" })
keymap({ "n" }, "<S-l>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next Buffer" })
keymap({ "n" }, "<leader>bp", "<cmd>BufferLineTogglePin<CR>", { desc = "Toggle Pin" })
keymap({ "n" }, "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<CR>", { desc = "Delete Non-Pinned Buffers" })
