return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"BurntSushi/ripgrep",
			"sharkdp/fd",
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		keys = {
			{ "<leader> ", require("telescope.builtin").find_files, desc = "Find in files" },
			{ "<leader>/", require("telescope.builtin").live_grep, desc = "Live grep" },
		},
	},
}
