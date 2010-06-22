" == BASIC INTERFACE PREFERENCES ==========================

set nocompatible
"" backspace/delete like I'm used to
set backspace=indent,eol,start
set history=100
"" show line numbers
"set number
set ruler
set showcmd
"" show matching braces/parens
set showmatch
" set spell
set title
"" visual bell
set vb
"" hide ~'s
hi NonText guifg=bg

"" wrap like I'm used to
set wrap
set formatoptions=l
set lbr

"" change indent settings according to filetype
filetype plugin indent on


"" == INDENTATION =========================================

"" default options
set shiftwidth=4
set tabstop=4
set expandtab

autocmd FileType css setlocal shiftwidth=2 tabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType map setlocal shiftwidth=2 tabstop=2
autocmd FileType php setlocal shiftwidth=2 tabstop=2


"" == GVIM/MACVIM ONLY ====================================

if has("gui_running")
    :colorscheme wombat
    set guifont=Envy\ Code\ R\ 9
    set guioptions=aegimLt
    set columns=90
    set lines=40
endif


"" == SEARCH (AND REPLACE) OPTIONS =========================

"" F5 toggles highlighted search
map <F5> :set hls!<bar>set hls?<CR>
set smartcase


"" == SYNTAX HIGHLIGHTING ==================================

syntax on

augroup mkd
  autocmd BufRead *.mkd set ai formatoptions=tcroqn2 comments=n:>
augroup END

"" == PLUGIN OPTIONS =======================================

let g:miniBufExplMapWindowNavVim = 1

"" == KEYBINDINGS ==========================================

" navigate apparent lines, not actual ones
nmap <silent> j gj
nmap <silent> k gk

"" Quote/Unquote a word consisting of letters from iskeyword.
nnoremap <silent> qw :call Quote('"')<CR>
nnoremap <silent> qs :call Quote("'")<CR>
nnoremap <silent> wq :call UnQuote()<CR>
function! Quote(quote)
    normal mz
    exe 's/\(\k*\%#\k*\)/' . a:quote . '\1' . a:quote . '/'
    normal `zl
endfunction
function! UnQuote()
    normal mz
    exe 's/["' . "'" . ']\(\k*\%#\k*\)[' . "'" . '"]/\1/'
    normal `z
endfunction

