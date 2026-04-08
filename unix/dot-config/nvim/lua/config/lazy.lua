-- vim.pack.add({ "https://github.com/folke/lazy.nvim" })

vim.pack.add({ 'https://github.com/zuqini/zpack.nvim' })
require('zpack').setup({
    profiling = {
        loader = true,
        require = true,
    }
})
-- require("lazy").setup({
--   -- Configure any other settings here. See the documentation for more details.
--   -- colorscheme that will be used when installing plugins.
--   install = { colorscheme = { "catppuccin" } },
--   -- automatically check for plugin updates
--   spec = {
--     {
--       import = "plugins",
--     },
--   },
--   checker = { enabled = true },
-- })
