return {
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"sindrets/diffview.nvim",
			"ibhagwan/fzf-lua",
		},
		config = true,
	},
	{
		"nvim-telescope/telescope.nvim",

		opts = function()
			local actions = require("telescope.actions")
			return {
				-- HACK: ivy-wrapper -> use it for all pickers (consistency with the os)
				defaults = require("telescope.themes").get_ivy({
					path_display = smart,
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
				}),
			}
		end,
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			local fb_actions = require("telescope._extensions.file_browser.actions")

			require("telescope").setup({
				extensions = {
					file_browser = {
						path = vim.loop.cwd(),
						cwd = vim.loop.cwd(),
						cwd_to_path = true,
						grouped = false,
						files = true,
						add_dirs = true,
						depth = 1,
						auto_depth = false,
						select_buffer = false,
						hidden = { file_browser = false, folder_browser = true },
						respect_gitignore = vim.fn.executable("fd") == 1,
						no_ignore = false,
						follow_symlinks = false,
						browse_files = require("telescope._extensions.file_browser.finders").browse_files,
						browse_folders = require("telescope._extensions.file_browser.finders").browse_folders,
						hide_parent_dir = false,
						collapse_dirs = false,
						prompt_path = false,
						quiet = false,
						dir_icon = "",
						dir_icon_hl = "Default",
						display_stat = { date = true, size = true, mode = true },
						hijack_netrw = true,
						use_fd = true,
						git_status = true,
						-- NOTE: disable most insert bindings & make more sensible
						mappings = {
							["i"] = {
								-- ["<C-e>"] = fb_actions.create,
								-- ["<S-CR>"] = fb_actions.create_from_prompt,
								-- ["<C-r>"] = fb_actions.rename,
								-- ["<C-m>"] = fb_actions.move,
								-- ["<C-c>"] = fb_actions.copy,
								-- ["<C-d>"] = fb_actions.remove,
								-- ["<C-o>"] = fb_actions.open,
								-- ["<C-p>"] = fb_actions.goto_parent_dir,
								-- ["<C-s-p>"] = fb_actions.goto_home_dir,
								-- ["<C-w>"] = fb_actions.goto_cwd,
								-- ["<C-t>"] = fb_actions.change_cwd,
								-- ["<C-f>"] = fb_actions.toggle_browser,
								-- ["<C-.>"] = fb_actions.toggle_hidden,
								-- ["<C-s>"] = fb_actions.toggle_all,
								["<bs>"] = fb_actions.backspace,
							},
							["n"] = {
								["/"] = function()
									vim.cmd("startinsert")
								end,
								["e"] = fb_actions.create,
								["r"] = fb_actions.rename,
								["m"] = fb_actions.move,
								["c"] = fb_actions.copy,
								["d"] = fb_actions.remove,
								["o"] = fb_actions.open,
								["p"] = fb_actions.goto_parent_dir,
								["P"] = fb_actions.goto_home_dir,
								["w"] = fb_actions.goto_cwd,
								["t"] = fb_actions.change_cwd,
								["f"] = fb_actions.toggle_browser,
								["."] = fb_actions.toggle_hidden,
								["v"] = fb_actions.toggle_all,
							},
						},
					},
				},
			})
			require("telescope").load_extension("file_browser")
		end,
	},
}
