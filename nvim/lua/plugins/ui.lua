return {
	{
		"craftzdog/solarized-osaka.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			vim.cmd([[colorscheme solarized-osaka]])
		end,
	},

	-- {
	-- 	"EdenEast/nightfox.nvim",
	-- 	config = function()
	-- 		vim.cmd([[colorscheme nordfox]])
	-- 	end,
	-- },

	{
		"akinsho/bufferline.nvim",
		keys = {
			{
				"<leader>bo",
				"<cmd>BufferLineCloseOthers<cr>",
				mode = "n",
				desc = "Delete other buffers",
			},
			{ "[b", "<cmd>BufferLineCyclePrev<cr>", mode = { "n", "i" }, desc = "Prev buffer" },
			{ "]b", "<cmd>BufferLineCycleNext<cr>", mode = { "n", "i" }, desc = "Next buffer" },
			{ "<a-j>", "<cmd>BufferLineCyclePrev<cr>", mode = { "n", "i" }, desc = "Prev buffer" },
			{
				"<a-S-j>",
				"<cmd>BufferLineMovePrev<cr>",
				mode = { "n", "i" },
				desc = "Move Buffer next",
			},
			{ "<a-k>", "<cmd>BufferLineCycleNext<cr>", mode = { "n", "i" }, desc = "Next buffer" },
			{
				"<a-S-k>",
				"<cmd>BufferLineMoveNext<cr>",
				mode = { "n", "i" },
				desc = "Move Buffer prev",
			},
			{ "<a-1>", "<cmd>BufferLineGoToBuffer 1<cr>", mode = { "n", "i" }, desc = "Goto buffer 1" },
			{ "<a-2>", "<cmd>BufferLineGoToBuffer 2<cr>", mode = { "n", "i" }, desc = "Goto buffer 2" },
			{ "<a-3>", "<cmd>BufferLineGoToBuffer 3<cr>", mode = { "n", "i" }, desc = "Goto buffer 3" },
			{ "<a-4>", "<cmd>BufferLineGoToBuffer 4<cr>", mode = { "n", "i" }, desc = "Goto buffer 4" },
			{ "<a-5>", "<cmd>BufferLineGoToBuffer 5<cr>", mode = { "n", "i" }, desc = "Goto buffer 5" },
			{ "<a-6>", "<cmd>BufferLineGoToBuffer 6<cr>", mode = { "n", "i" }, desc = "Goto buffer 6" },
			{ "<a-7>", "<cmd>BufferLineGoToBuffer 7<cr>", mode = { "n", "i" }, desc = "Goto buffer 7" },
			{ "<a-8>", "<cmd>BufferLineGoToBuffer 8<cr>", mode = { "n", "i" }, desc = "Goto buffer 8" },
			{ "<a-9>", "<cmd>BufferLineGoToBuffer 9<cr>", mode = { "n", "i" }, desc = "Goto buffer 9" },
		},
		opts = {
			options = {
				mode = "tabs",
				numbers = "ordinal",
				indicator = {
					style = "underline",
				},
				show_buffer_close_icons = false,
				show_close_icon = false,
				color_icons = true,
				always_show_bufferline = true,
				show_duplicate_prefix = false,
				separator_style = "thick",
			},
		},
	},
}
