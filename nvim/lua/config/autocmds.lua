-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Example
-- vim.api.nvim_create_autocmd({ "FileType" }, {
-- 	pattern = { "json", "jsonc" },
-- 	callback = function()
-- 		vim.wo.conceallevel = 0
-- 	end,
-- })

-- Helper autocommand lasttab: save alternate tabnr in variable (switch between alternat tabs)
vim.api.nvim_create_autocmd({ "TabLeave" }, {
	callback = function()
		vim.g.alt_tab = vim.fn.tabpagenr()
	end,
})
