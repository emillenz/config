return {
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				keymaps = {
					insert = "<C-o>'",
					insert_line = "<C-o>g'",
					normal = "'",
					normal_cur = "''",
					normal_line = "g'",
					normal_cur_line = "g''",
					visual = "'",
					visual_line = "g'",
					delete = "d'",
					change = "c'",
					change_line = "cg'",
				},
			})
		end,
	},
}
