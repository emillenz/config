-- dont be a greedy fucking fuck, be efficient
local greedy = require("lenz.greedy")
greedy.greedy()

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- always relative lines
-- add relative line-number jumps to the jumplist (hop back quickly)
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

-- Stronger HJKL
map("n", "J", "<cmd>m .+1<cr>==", opts)
map("n", "K", "<cmd>m .-2<cr>==", opts)
map("v", "J", ":m '>+1<cr>gv=gv", opts)
map("v", "K", ":m '<-2<cr>gv=gv", opts)
map({ "n", "v", "o" }, "H", "^", opts)
map({ "n", "v", "o" }, "L", "$", opts)

-- Clear search with <esc> (and normal mode)
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>")

-- less disorienting jumps out of screen
map({ "n", "v", "o" }, "gg", "ggzz", opts)
map({ "n", "v", "o" }, "n", "nzz", opts)
map({ "n", "v", "o" }, "N", "Nzz", opts)
map({ "n", "v", "o" }, "'", "'zz", opts)
map({ "i", "n", "v", "o" }, "<c-o>", "<c-o>zz", opts)
map({ "i", "n", "v", "o" }, "<c-i>", "<c-i>zz", opts)

-- Add undo break-points
map("i", ",", ",<c-g>u", opts)
map("i", ".", ".<c-g>u", opts)
map("i", ";", ";<c-g>u", opts)

-- save file & normal mode
map({ "i", "n" }, "<c-s>", "<cmd>w<cr><esc>")

-- splits
map({ "i", "n", "v" }, "<c-q>", "<cmd>bdelete<cr>")
map({ "i", "n", "v" }, "<c-w>", "<cmd>wincmd w<cr>")

-- better indenting
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

map("n", "<leader>xl", "<cmd>lopen<cr>")
map("n", "<leader>xq", "<cmd>copen<cr>")

map("n", "[q", "<cmd>cprev<cr>")
map("n", "]q", "<cmd>cnext<cr>")

-- global: help
map({ "i", "n", "s" }, "<a-h>", function()
	vim.lsp.buf.hover()
end, opts) -- FIX:

-- better defaults
map("n", "x", '"_x', opts)
map("n", "U", "<c-r>", opts)
map("n", "<cr>", "r<cr>", opts)
map({ "n", "v" }, "Q", "@@", opts)
map({ "n", "v", "o" }, "\\", "J", opts)

-- control is for screen scrolling
map({ "i", "n", "s" }, "<c-j>", "<c-e>", opts)
map({ "i", "n", "s" }, "<c-k>", "<c-y>", opts)
map({ "i", "n", "s" }, "<c-z>", "zz", opts)

-- git interface
map("n", "<leader>gg", "<cmd>Neogit<cr>")

-- better assignments of +/-
map({ "n", "v" }, "+", "<c-a>", opts)
map({ "n", "v" }, "-", "<c-x>", opts)
map({ "n", "v" }, "g+", "g<c-a>", opts)
map({ "n", "v" }, "g-", "g<c-x>", opts)

-- normal mode command shortcuts
map("v", "gn", ":'<,'>normal ", opts)

-- global navigation
map({ "i", "n" }, "<a-q>", "<cmd>q<cr>")
map({ "i", "n" }, "<a-S-q>", "<cmd>wqa<cr>")
map({ "i", "n" }, "<a-e>", "<cmd>Telescope file_browser path=%:p:h<cr>")
map({ "i", "n" }, "<a-f>", "<cmd>Telescope find_files<cr>")
map({ "i", "n" }, "<a-S-f>", "<cmd>Telescope find_files cwd=~/<cr>")
map({ "i", "n" }, "<a-g>", "<cmd>Telescope oldfiles<cr>")
map({ "i", "n" }, "<a-S-g>", "<cmd>Telescope buffers<cr>")
-- create new tab at end: have fixed tand do not insert new one's inbetween (sane default behaviour), reordering not neccessary because we hotswitch  with 1-9
map({ "i", "n" }, "<a-t>", "<cmd>$tabnew<cr>")
-- HACK: rerun command in tmux-cmd-window
map({ "i", "n" }, "<a-S-c>", function()
	vim.fn.system("tmux select-window -t cmd; tmux send-keys C-l Up Enter")
end)
-- HACK: new tmux window with the current buffer's working directory as path (name: cmd, os-consistent)
map({ "i", "n" }, "<a-c>", function()
	local path = vim.fn.expand("%:p:h")
	vim.fn.system("tmux new-window -S -n cmd -c " .. path)
end)
