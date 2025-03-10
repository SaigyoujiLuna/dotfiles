return { {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	opts = {
		options = {
			icons_enabled = true,
			globalstatus = vim.o.laststatus == 3,
			disabled_filetypes = {
				statusline = { "neo-tree", "netrw" }
			},
			sections = {
				lualine_a = "mode",

			}
		}
	}
}
}
