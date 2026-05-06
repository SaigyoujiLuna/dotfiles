local config = require("config")
config.init()
config.setup()

vim.g.neovide_opacity = 0.85 -- window chrome + title bar opacity
vim.g.neovide_normal_opacity = 0.7 -- buffer content opacity (0.14.0+)
vim.g.neovide_window_blurred = true
vim.g.neovide_show_border = true
vim.g.neovide_input_ime = true
