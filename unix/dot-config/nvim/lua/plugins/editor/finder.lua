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
			{ "<leader> ", function() require("telescope.builtin").find_files() end,  desc = "Find in files" },
			{ "<leader>/", function() require("telescope.builtin").live_grep() end,   desc = "Live grep" },
		},
	},
}
