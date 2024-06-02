" ---
" title: opinionated, baremetal, no 3rd party dependent vim config.
" date: 2024-05=31
" author: emil lenz
" email: emillenz@protonmail.com
" info: the rationale for the keybindings and settings in this opinionated config are documented in
" [readme.org] and the main editor (emacs) config file: [doom/config.org].
" ---

syntax enable
filetype plugin on
filetype indent on
colorscheme shine
set path+=**
set wildmenu
set wildignorecase
set relativenumber
set textwidth=100
set nocompatible
set autowrite
set autoread
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
set ruler
set ttimeoutlen=0
set timeoutlen=500
set cursorline
set hlsearch
set mouse=a
set nobackup
set nowritebackup
set noswapfile
set t_u7= " HACK :: fix vim starting in replace mode on windows
set mat=0
set noerrorbells
set novisualbell
set t_vb=
set tm=500
set encoding=utf8

" MAPPINGS
nnoremap <silent> <esc> <esc>:nohl<cr>
nnoremap <C-e> :e<space>
nnoremap <C-g> :b<space>
nnoremap <C-f> :find<space>
nnoremap <c-b> <C-^>
nnoremap <C-w> <C-w><C-w>
nnoremap <C-q> :bd<cr>
nnoremap <C-s> :w<cr>
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> $ g$
nnoremap <silent> ^ g^
nnoremap Q @@
nnoremap U <c-r>
nnoremap <expr> ' printf("m\"'%sGg`\"", toupper(nr2char(getchar())))

" auto insert/skip/delete matching pairs
inoremap {<CR> {<CR>}<Esc>O
inoremap { {}<Left>
inoremap <expr> } getline('.')[col('.')-1] == "}" ? "\<Right>" : "}"
inoremap ( ()<Left>
inoremap <expr> ) getline('.')[col('.')-1] == ")" ? "\<Right>" : ")"
inoremap [ []<Left>
inoremap <expr> ] getline('.')[col('.')-1] == "]" ? "\<Right>" : "]"

" EXPLORE
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
        nmap <buffer> e %:w<CR>
endfun
au filetype netrw call NetrwMaps()

" AUTOCOMMANDS
autocmd WinNew * wincmd L " always open window's in vsplit
function! StripWhitespace()
        let l = line(".")
        let c = col(".")
        %s/\s\+$//e
        call cursor(l, c)
endfun
autocmd BufWritePre * :call StripWhitespace()
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif " restore last position when opening file

" HACK :: fix vim cursor (insert mode indication)
autocmd VimEnter * silent !echo -ne "\e[2 q"
let &t_SI = "\e[6 q"
let &t_SR = "\e[4 q"
let &t_EI = "\e[2 q"
