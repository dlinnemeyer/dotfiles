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

" more formal textwidth for markdown. can format this on visual selection
" with gq
au BufRead,BufNewFile *.md setlocal textwidth=80

" display status line
set laststatus=2
set statusline=%f         " Path to the file
set statusline+=%=        " Switch to the right side
set statusline+=%l    " Current line
set statusline+=/    " Separator
set statusline+=%L   " Total lines

" clean out end-of-line whitespace in select file types
autocmd BufWritePre *.js,*.html,*.py,*.pyi %s/\s\+$//e

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

" Vundle junk first, so it's out of the way
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" ack the current directory from vim so we don't have to run 
Plugin 'mileszs/ack.vim'
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
" by default, don't auto-select the first file
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>
" quick key to close quickfix, since it stays up after we select a file
nnoremap <Leader>f :cclose<CR>

Plugin 'tpope/vim-sleuth'

Plugin 'ctrlpvim/ctrlp.vim'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" best match on top and keep the height consistent to 10 so no screen jumping
let g:ctrlp_match_window = 'bottom,order:ttb,min:10,max:10,results:10'

" exclude silly files
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = '\v[\/](\..git|\.hg|\.svn|venv|node_modules)$'

" include current file
let g:ctrlp_match_current_file = 1

" make buffer mode match the normal find-file mode in display, so we can
" search against the relative path instead of just the file name
let g:ctrlp_bufname_mod = ':~:.'
let g:ctrlp_bufpath_mod = ''

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

Plugin 'tpope/vim-fugitive'

Plugin 'plasticboy/vim-markdown'
" disable vim-markdown auto-folding
let g:vim_markdown_folding_disabled=1

Plugin 'flazz/vim-colorschemes'

Plugin 'editorconfig/editorconfig-vim'

" Plugin 'vim-syntastic/syntastic'

" Plugin 'mtscout6/syntastic-local-eslint.vim'

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 0
" let g:syntastic_enable_highlighting = 1
" let g:syntastic_python_checkers = ["flake8"]
" let g:syntastic_html_checkers = []
" let g:syntastic_javascript_checkers = ["eslint"]
Plugin 'w0rp/ale'
let g:ale_linters = {
\   'python': ['flake8'],
\   'html': [],
\   'javascript': ['eslint']
\}

" Vundle finis
call vundle#end()            " required
filetype plugin indent on    " required

" trying out monokai. we'll see
colorscheme monokai

" get a decent search results highlight. make sure this is after the
" colorscheme, since we're over-riding that search highlight setting
set hlsearch
hi Search cterm=underline ctermfg=blue ctermbg=none

" turn on spell-checking, but fiddle with colors (after colorscheme)
set spell
hi clear SpellCap
hi SpellCap cterm=underline ctermfg=red
hi clear SpellBad
hi SpellBad cterm=underline ctermfg=red
