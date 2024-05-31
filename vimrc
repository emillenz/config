" minimalist, bare metal config.  no plugins, no dependecies (to be deployed on other machines)

syntax enable
filetype plugin on
set path+=**
set wildmenu
set relativenumber
set textwidth=100
set nocompatible
set autowrite
set confirm
set expandtab
set cursorline
set ignorecase
set incsearch
set shiftround
set smartcase
set smartindent
set splitbelow
set splitright
set termguicolors
set undolevels=10000

nnoremap <silent> <esc> <esc>:nohl<cr>

let g:netrw_banner=0
let g:netrw_keepdir = 0
function! NetrwMaps()
        nmap <buffer> h -^
        nmap <buffer> l <cr>
        " perform all other file operations using shellcommands `!`
endfunction
au filetype netrw call NetrwMaps()
