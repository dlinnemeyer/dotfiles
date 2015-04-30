" tab stuff
set autoindent
set noexpandtab
set tabstop=4
set shiftwidth=4
" show line numbers
set number

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

" command aliases
cnoreabbrev Cq ConqueTermVSplit
cnoreabbrev cq ConqueTermVSplit
cnoreabbrev CQ ConqueTermVSplit
command Csh ConqueTermVSplit bash
command Cshh ConqueTermSplit bash
command Cmysql ConqueTermVSplit mysql -p

" short-code for :Explore
command E Explore

" setup :Shell command to run passed shell command and display output in new window
" take from: http://vim.wikia.com/wiki/Display_output_of_shell_commands_in_new_window
" altered slightly to potentially switch back to originall window after running
function! s:ExecuteInShell(command)
    let command = join(map(split(a:command), 'expand(v:val)'))
    let winnr = bufwinnr('^' . command . '$')
    silent! execute  winnr < 0 ? 'botright new ' . fnameescape(command) : winnr . 'wincmd w'
    setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
    echo 'Execute ' . command . '...'
    silent! execute 'silent %!'. command
    silent! execute 'resize ' . line('$')
    silent! redraw
    silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
    silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>'
    echo 'Shell command ' . command . ' executed.'
    " switch to original window
    " execute 'wincmd w'
endfunction
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)

" start up pathogen
execute pathogen#infect()
syntax on
filetype plugin indent on

" database settings for dbext
let g:dbext_default_type   = 'MYSQL'
let g:dbext_default_host = 'localhost'
let g:dbext_default_user = 'dlinnemeyer'
let g:dbext_default_window_use_horiz = 0 " Use vertical split
let g:dbext_default_window_width = 80

command Desc DescribeTableAskName
command Sel Select
command Sql DBExecSQL
command SqlX DBExecSQLTopX
