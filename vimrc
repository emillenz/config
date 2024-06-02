" ---
" title: opinionated, baremetal, no 3rd party dependent vim config.
" date: 2024-05=31
" author: emil lenz
" email: emillenz@protonmail.com
" ---

syntax enable
filetype plugin on
filetype indent plugin on
colorscheme shine
set path+=**
set wildmenu
set wildignorecase
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
set ttimeoutlen=0
set timeoutlen=500
set cursorline
set hlsearch
set mouse=a
set backupdir=~/.vim/.backup//,. " never litter source dir with swap/backupfiles
set directory=~/.vim/.swp//,.
set t_u7= " HACK :: fix vim starting in replace mode on windows

nnoremap <silent> <esc> <esc>:nohl<cr>
nnoremap <C-e> :e<space>
nnoremap <C-g> :b<space>
nnoremap <C-f> :find<space>
nnoremap <C-b> <C-^>
nnoremap <C-w> <C-w><C-w>
nnoremap <C-q> :bd<cr>
nnoremap <C-s> :w<cr>
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> $ g$
nnoremap <silent> ^ g^
nnoremap Q @@
nnoremap U <c-r>
" gobal-mark files you alternate between inside a project.  then access them directly (no more `:b <name><cr>`) (input mark as lowercase for ergonomics & speed.)
nnoremap <expr> ' printf('`%s`"zz', toupper(nr2char(getchar())))

" auto insert matching parenthesis
inoremap {<CR> {<CR>}<Esc>O

let g:netrw_banner=0
let g:netrw_keepdir = 0
let g:netrw_hide = 1
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_localcopydircmd = 'cp -r'
function! NetrwMaps()
	nmap <buffer> h -^
	nmap <buffer> l <cr>
        nmap <buffer> d D
        nmap <buffer> r R
        nmap <buffer> . gh
        nmap <buffer> m mf
        nmap <buffer> u mF
endfunction
au filetype netrw call NetrwMaps()

autocmd WinNew * wincmd L " always open window's in vsplit
autocmd BufWritePre * :%s/\s\+$//e " strip trailing whitespace before save

" make cursor mode-dependent
let &t_SI = "\e[6 q"
let &t_SR = "\e[4 q"
let &t_EI = "\e[2 q"
