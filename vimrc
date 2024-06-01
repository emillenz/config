syntax enable
filetype plugin on
filetype indent plugin on
colorscheme shine
set path+=** " fuzzy complete using :find
set wildmenu
set relativenumber
set textwidth=100
set nocompatible
set autowrite 
set confirm
set expandtab
set incsearch
set shiftround
set smartcase
set ignorecase
set smartindent
set splitbelow
set splitright
set termguicolors
set undolevels=10000
set showmatch
set showcmd
set laststatus=2
set autoindent
set smartindent
set smarttab
set shiftround
set wrapscan
set hidden
set timeoutlen=0

" consistent with keybinding-scheme
nnoremap <esc> <esc>:nohl<cr>
nnoremap <C-e> :e<space>
nnoremap <C-g> :b<space>
nnoremap <C-f> :find<space>
nnoremap <C-b> <C-^>
nnoremap <C-w> <C-w><C-w>
nnoremap <C-q> :bd<cr>
nnoremap <C-s> :w<cr>
nnoremap j gj
nnoremap k gk
nnoremap $ g$
nnoremap ^ g^

let g:netrw_banner=0
let g:netrw_keepdir = 0
function! NetrwMaps()
	nmap <buffer> h -^
	nmap <buffer> l <cr>
	" perform all other file operations using shellcommands `!`
endfunction
au filetype netrw call NetrwMaps()

autocmd WinNew * wincmd L " always open window's in vsplit
