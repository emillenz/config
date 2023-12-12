return {
	"nvim-telescope/telescope.nvim",

	opts = function()
		local actions = require("telescope.actions")
		return {
			defaults = {
				mappings = {
					i = {
						["<Tab>"] = actions.select_default,
						["<S-Tab>"] = actions.select_default,
						["<CR>"] = actions.select_default,
					},
					n = {
						["<Tab>"] = actions.select_default,
						["<S-Tab>"] = actions.select_default,
						["<CR>"] = actions.select_default,
						["m"] = actions.toggle_selection + actions.move_selection_better,
						["M"] = actions.toggle_selection + actions.move_selection_worse,
					},
				},
			},
		}
	end,
}
