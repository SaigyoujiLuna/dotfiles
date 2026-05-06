local config = require("config")
config.init()
config.setup()

vim.g.neovide_opacity = 0.6 -- window chrome + title bar opacity
vim.g.neovide_normal_opacity = 0.6 -- buffer content opacity (requires Normal.bg=NONE)
vim.g.neovide_window_blurred = true -- macOS only: blur content behind window
vim.g.neovide_show_border = true
vim.g.neovide_input_ime = true
vim.g.neovide_floating_blur_amount_x = 2.0 -- floating window blur radius x
vim.g.neovide_floating_blur_amount_y = 2.0 -- floating window blur radius y
