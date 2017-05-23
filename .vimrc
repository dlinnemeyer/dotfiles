" Vundle junk first, so it's out of the way
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'mileszs/ack.vim'

Plugin 'tpope/vim-sleuth'

Plugin 'ctrlpvim/ctrlp.vim'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" i like to use ctrlp in buffer mode for switching among current files
" This over-rides vim's default c-o functionality, which switches through
" recent cursor positions, but I never use that
nnoremap <c-o> :CtrlPBuffer<CR>
" best match on top and keep the height consistent to 10 so no screen jumping
let g:ctrlp_match_window = 'bottom,order:ttb,min:10,max:10,results:10'

" exclude silly files
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = '\v[\/](\..git|\.hg|\.svn|venv|node_modules)$'
"
" speed up ctrlp using ag, if installed
let g:ctrlp_use_caching = 0
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
  \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
  \ }
endif

Plugin 'tpope/vim-commentary'

Plugin 'plasticboy/vim-markdown'
" disable vim-markdown auto-folding
let g:vim_markdown_folding_disabled=1

Plugin 'flazz/vim-colorschemes'

Plugin 'editorconfig/editorconfig-vim'

Plugin 'nvie/vim-flake8'
let g:flake8_show_in_file=0
let g:flake8_show_in_gutter=0
let g:flake8_show_quickfix=1
autocmd BufWritePost *.py call Flake8()

" Vundle finis
call vundle#end()            " required
filetype plugin indent on    " required

" tab stuff
syntax on
set autoindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set mouse=a

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

set undofile                " Save undo's after file closes    
set undodir=$HOME/.vim/undo " where to save undo histories    
set undolevels=1000         " How many undos    
set undoreload=10000        " number of lines to save for undo

" allow for finding files in any subdirectories by default. use with :find and
" just type the file name, ignoring directories
set path+=./**

" sync vim clipboard with system clipboard
set clipboard=unnamed
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

" window management
nnoremap <C-n> <C-w>v<C-w>l
nnoremap <tab><tab> <c-w><c-w>
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Intuitive backspacing in insert mode
set backspace=indent,eol,start

" scroll down/up with more context
set scrolloff=6

" alias for gc in visual mode
vnoremap <silent> <C-C> gc

" %:h will input the current file's path, so :e %:h allows you to open another
" file in the current directory. :e %% or :e% are shortcuts
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
cnoremap <expr> e% getcmdtype() == ':' ? expand('e %:h').'/' : 'e%'

" go to defn of tag under the cursor, case-sensitively. this is necessary
" because search is case-insensitive by default in my vim setup, and the
" tag search follows that setup. this enables case-sensitivity while doing
" the tag jump, then disables it afterwards
fun! MatchCaseTag()
    let ic = &ic
    set noic
    try
        exe 'tjump ' . expand('<cword>')
    finally
       let &ic = ic
    endtry
endfun
nnoremap <silent> <c-]> :call MatchCaseTag()<CR>

" quick home-row-oriented mappings. mostly leader mappings building on the
" above
let mapleader = "\<Space>"
nnoremap <Leader>p :CtrlP<CR>
nnoremap <Leader>o :CtrlPBuffer<CR>
nnoremap <Leader>c :.Commentary<CR>
nnoremap <Leader>n <C-w>v<C-w>l
nnoremap <Leader>q :qa<CR>
nnoremap <Leader>w :wa<CR>
" so I don't have to press shift. that's right
nnoremap ; :
