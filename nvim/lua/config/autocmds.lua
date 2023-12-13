-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

local autocmd = vim.api.nvim_create_autocmd

autocmd({ "WinNew" }, {
	desc = "Vsplit helppages",
	callback = function()
		vim.cmd("wincmd L")
	end,
})

autocmd("CmdlineChanged", {
	desc = "Autoenable very-magic-mode",
	callback = function()
		local cmd = vim.fn.getcmdline()
		if
			string.match(cmd, [[^%%[sg]/$]])
			or string.match(cmd, [[^'<,'>[sg]/$]])
			or string.match(cmd, [[^%.,%.%+%d+[sg]/$]])
		then
			vim.fn.setcmdline(cmd .. [[\v]])
		end
	end,
})
