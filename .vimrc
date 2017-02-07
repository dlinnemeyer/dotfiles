" tab stuff
syntax on
set autoindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
filetype plugin indent on

au BufNewFile,BufRead *.pyi set filetype=python

" show line numbers
set number
" let's just do 80 chars. i can figure out project-by-project whether to obey
" this or not
set colorcolumn=80

" trying out monokai. we'll see
colorscheme monokai

" display status line
set laststatus=2

" enable case-insensitive searching
set ic
" enable case-sensitive when uppercase letters show up in search phrase
set smartcase

" turn off hex/octal detection when dealing with numbers
set nrformats=

" setup bash-link tab-completion
set wildignore+=*.a,*.o
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
set wildignore+=.DS_Store,.git,.hg,.svn
set wildignore+=*~,*.swp,*.tmp
set wildmenu
set wildmode=list:longest,full

" allow for finding files in any subdirectories by default. use with :find and
" just type the file name, ignoring directories
set path+=./**

" sync vim clipboard with system clipboard
set clipboard=unnamedplus

" window management
nnoremap <C-n> <C-w>v<C-w>l
nnoremap <tab><tab> <c-w><c-w>
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" alias for gc in visual mode
vnoremap <silent> <C-C> gc

" %:h will input the current file's path, so :e %:h allows you to open another
" file in the current directory. :e %% or :e% are shortcuts
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
cnoremap <expr> e% getcmdtype() == ':' ? expand('e %:h').'/' : 'e%'

" short-code for :Explore
command E Explore

" disable vim-markdown auto-folding
let g:vim_markdown_folding_disabled=1

" cool python stuff
let g:flake8_show_in_file=0
let g:flake8_show_in_gutter=0
let g:flake8_show_quickfix=1
autocmd BufWritePost *.py call Flake8()

" start up pathogen
execute pathogen#infect()
