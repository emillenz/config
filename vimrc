colorscheme shine " lightheme bois
syntax enable
filetype plugin on
set path+=**
set wildmenu
set relativenumber
set textwidth=80
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

let g:netrw_banner=0
let g:netrw_keepdir = 0
function! NetrwMapping()
        nmap <buffer> h -^
        nmap <buffer> l <cr>
endfunction

augroup netrw_mapping
        autocmd!
        autocmd filetype netrw call NetrwMapping()
augroup END
