-- I don't suck for the shiny new tool, that makes my neovim look cool.. oooga-booga.
-- I like things, fast and bare-metal, Popups and minibuffers / commandline belong to the bottom of the screen, not distracting, nor obscuring the view with fancy animations. (this is exactly the reason why I don't use a gui).
-- This is a workstation, not some beatiful *artsy* config. This is designed to go fast.

return {
	{ "nvimdev/dashboard-nvim", enabled = false }, -- dashboards are bad for navigation and bloated bullshit
	{ "echasnovski/mini.surround", enabled = false }, -- more featured surround is used
	{ "nvim-neo-tree/neo-tree.nvim", enabled = false }, -- only vscucks use a filebrowser (fuzzyfinding is the champ in efficiency and speed here)

	{ "rcarriga/nvim-notify", enabled = false },
	{ "stevearc/dressing.nvim", enabled = false },
	{ "folke/noice.nvim", enabled = false },
}
