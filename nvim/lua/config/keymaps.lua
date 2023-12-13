local map = vim.keymap.set
local opts = { noremap = true, silent = true } -- defaults

vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- relative-line-number-jumps
map(
	{ "n", "v", "o" },
	"j",
	[[v:count == 0 ? "gj" : "m'" . v:count . "gj"]],
	{ expr = true, noremap = true, silent = true }
)
map(
	{ "n", "v", "o" },
	"k",
	[[v:count == 0 ? "gk" : "m'" . v:count . "gk"]],
	{ expr = true, noremap = true, silent = true }
)

-- Move lines
map("n", "<c-j>", "<cmd>m .+1<cr>==", opts)
map("n", "<c-k>", "<cmd>m .-2<cr>==", opts)
map("v", "<c-j>", ":m '>+1<cr>gv=gv", opts)
map("v", "<c-k>", ":m '<-2<cr>gv=gv", opts)

-- stronger, more ergonomic hl
map({ "n", "v", "o" }, "H", "^", opts)
map({ "n", "v", "o" }, "L", "$", opts)

-- Clear search with <esc> (and normal mode)
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>")

-- less disorienting jumps out of screen
map({ "n", "v", "o" }, "gg", "ggzz", opts)
map({ "n", "v", "o" }, "n", "nzz", opts)
map({ "n", "v", "o" }, "N", "Nzz", opts)
map({ "i", "n", "v", "o" }, "<c-o>", "<c-o>zz", opts)
map({ "i", "n", "v", "o" }, "<c-i>", "<c-i>zz", opts)

-- Add undo break-points
map("i", ",", ",<c-g>u", opts)
map("i", ".", ".<c-g>u", opts)
map("i", ";", ";<c-g>u", opts)

-- buffer save / quit (frequent commands -> remap sensibly)
map({ "i", "n" }, "<c-s>", "<cmd>w!<cr><esc>")
map({ "i", "n", "v" }, "<c-q>", "<cmd>bdelete<cr><esc>")

-- better indenting
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- better defaults
map("n", "x", '"_x', opts)
map("n", "U", "<c-r>", opts)
map({ "n", "v" }, "Q", "@q", opts) -- record and execute macro
map("n", "<TAB>", "za", opts)

-- search for line in buffer (very helpful)
map({ "n", "v" }, "g/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", opts)

-- git interface
map("n", "<leader>gg", "<cmd>Neogit<cr>")

-- more sensible assignments of +/-
map({ "n", "v" }, "+", "<c-a>", opts)
map({ "n", "v" }, "-", "<c-x>", opts)
map({ "n", "v" }, "g+", "g<c-a>", opts)
map({ "n", "v" }, "g-", "g<c-x>", opts)

-- global navigation
map("n", "<M-TAB>", "<cmd>wincmd w<cr>")
map("n", "<M-q>", "<cmd>q<cr>")
map("n", "<M-S-q>", "<cmd>wqa<cr>")
map("n", "<M-o>", "<cmd>Telescope file_browser path=%:p:h<cr>")
map("n", "<M-f>", "<cmd>Telescope find_files<cr>")
map("n", "<M-S-f>", "<cmd>Telescope find_files cwd=~/<cr>")
map("n", "<M-g>", "<cmd>Telescope buffers<cr>")
map("n", "<M-r>", "<cmd>Telescope oldfiles<cr>")
map("n", "<M-t>", "<cmd>$tabnew<cr>")

-- HACK: new tmux window with the current buffer's working directory as path (name: cmd, os-consistent)
-- NOTE: never emulate a terminal inside vim.
map({ "i", "n" }, "<M-c>", function()
	local path = vim.fn.expand("%:p:h")
	vim.fn.system("tmux new-window -S -n cmd -c " .. path)
end)
