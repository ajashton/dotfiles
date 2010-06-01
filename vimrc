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

autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2
autocmd FileType php setlocal shiftwidth=2 tabstop=2


"" == GUI OPTIONS ==========================================

if has("gui_running")
    :colorscheme zenburn
    set guifont=Envy\ Code\ R\ 9
    set guioptions=aegimrLt
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

"" Common file operations like every other desktop app
"" CTRL-N = New Tab
"map <C-n> <silent> <ESC>:tabnew<CR>
"" CTRL-O = Open File (with browser, in new tab)
"map <C-O> <silent> <ESC>:browse tabnew<CR>
"" CTRL-X = Cut
"vnoremap <C-x> "+x
"" CTRL-C = Copy
"vnoremap <C-c> "+y
"" CTRL-V = Paste
"map <C-v> "+gP
"" CTRL-Z = Undo
"noremap <C-z> u
"inoremap <C-z> <C-O> u
"" CTRL-A = Select All
"noremap <C-a> gggH<C-O>G
"inoremap <C-a> <C-O>gg<C-O>gH<C-O>G
"cnoremap <C-a> <C-C>gggH<C-O>G
"onoremap <C-a> <C-C>gggH<C-O>G
"snoremap <C-a> <C-C>gggH<C-O>G
"xnoremap <C-a> <C-C>ggVG

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

