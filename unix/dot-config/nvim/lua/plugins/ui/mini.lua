require("mini.notify").setup({})
-- stylua: ignore
vim.keymap.set({ "n" }, "<leader>n", MiniNotify.show_history, { desc = "Notification History" })
