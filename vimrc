" == BASIC INTERFACE PREFERENCES ==========================

set nocompatible
"" backspace/delete like I'm used to
set backspace=indent,eol,start
set history=100
"" show line numbers
set number
set ruler
set showcmd
"" show matching braces/parens
set showmatch
set showtabline=1
set spell
set title
"" disables both audio & visual bell
set vb t_vb=

"" wrap like I'm used to
set wrap
set formatoptions=l
set lbr

"" change indent settings according to filetype
filetype plugin indent on


"" == TABS & FORMATTING ===================================

"" default options
set shiftwidth=2
set tabstop=2
set expandtab

autocmd FileType js,txt,mkd setlocal shiftwidth=4 tabstop=4

set nolist
"set lcs=tab:│\ ,trail:·,extends:>,precedes:<,nbsp:&
"set lcs=tab:└─,trail:·,extends:>,precedes:<,nbsp:&
set lcs=tab:│┈,trail:·,extends:»,precedes:«,nbsp:&

" formatoptions:
" c - autowrap COMMENTS using textwidth
" r - insert comment leader (?) on <enter>
" o - insert comment leader on 'o' or 'O'
" q - gq formats comments (?)
" n - recon numbered lists
" v - wrap on blanks
" t - autowrap TEXT using textwidth
set fo=croqnvt



"" == TERMINAL/GUI SETUP ==================================

au VimEnter *
                \ if &term == 'xterm'           |
                \       set t_Co=256            |
                \ endif

if has("gui_running")
    colo ir_black
    set guifont=DejaVu\ Sans\ Mono\ 9
    set guioptions=i
    set columns=100
    set lines=52
else
	" Select colormap: 'soft', 'softlight', 'standard' or 'allblue'
	let xterm16_colormap	= 'allblue'
	" Select brightness: 'low', 'med', 'high', 'default' or custom levels.
	let xterm16_brightness	= 'default'
    let xterm16bg_Normal = 'none'
	colo xterm16
endif

"" == PLUGIN OPTIONS =======================================

let g:NERDTreeWinSize=25


"" == SEARCH (AND REPLACE) OPTIONS =========================

"" F5 toggles highlighted search
map <F5> :set hls!<bar>set hls?<CR>
set ignorecase
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

inoremap <Tab> <C-R>=SuperCleverTab()<cr>
