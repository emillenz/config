vim.g.autoformat = true

-- LazyVim root dir detection
-- Each entry can be:
-- * the name of a detector function like `lsp` or `cwd`
-- * a pattern or array of patterns like `.git` or `lua`.
-- * a function with signature `function(buf) -> string|string[]`
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

local opt = vim.opt

vim.scriptencoding = "utf-8"
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.magic = true
opt.gdefault = true
opt.autowrite = true
opt.autochdir = true
opt.clipboard = "unnamedplus"
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 3
opt.confirm = true
opt.cursorline = true
opt.formatoptions = "jcroqlnt"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true
opt.inccommand = "nosplit"
opt.laststatus = 3
opt.list = true
opt.mouse = "a"
opt.number = true
opt.pumblend = 0
opt.pumheight = 10
opt.relativenumber = true
opt.scrolloff = 0
opt.textwidth = 100
opt.sessionoptions =
	{ "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false
opt.sidescrolloff = 10
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.spelllang = { "en" }
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200
opt.virtualedit = "block"
opt.wildmode = "longest:full,full"
opt.winminwidth = 5
opt.wrap = false
opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = "⸱",
	-- fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}
vim.o.formatexpr = "v:lua.require'lazyvim.util'.format.formatexpr()"
opt.foldlevel = 99
opt.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()"

if vim.fn.has("nvim-0.10") == 1 then
	opt.smoothscroll = true
end


if vim.fn.has("nvim-0.9.0") == 1 then
	opt.statuscolumn = [[%!v:lua.require'lazyvim.util'.ui.statuscolumn()]]
end

-- HACK: causes freezes on <= 0.9, so only enable on >= 0.10 for now
if vim.fn.has("nvim-0.10") == 1 then
	opt.foldmethod = "expr"
	opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
else
	opt.foldmethod = "indent"
end

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])
