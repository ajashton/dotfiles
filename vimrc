" == BASIC INTERFACE PREFERENCES ==========================

set nocompatible
"" backspace/delete like I'm used to
set backspace=indent,eol,start
set history=100
"" show line numbers
set number
set ruler
set colorcolumn=80
set showcmd
"" show matching braces/parens
set showmatch
set showtabline=1
set nospell
set title
"" disables both audio & visual bell
set vb t_vb=

"" wrap like I'm used to
set wrap
set formatoptions=l
set lbr

"" change indent settings according to filetype
filetype plugin indent on

"" Swap files & Dropbox are an annoying combo,
"" so keep them in another place instead
set directory^=$HOME/.vim/swap// 

call pathogen#runtime_append_all_bundles()


"" == TABS & FORMATTING ===================================

"" default options
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

autocmd FileType css,carto setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType mkd setlocal spell

set nolist
"" note: lcs does nothing with nolist
"set lcs=tab:│┈,trail:·,extends:»,precedes:«,nbsp:&
set lcs=tab:│\ ,trail:·,extends:»,precedes:«,nbsp:&

" formatoptions:
" c - autowrap COMMENTS using textwidth
" r - insert comment leader (?) on <enter>
" o - insert comment leader on 'o' or 'O'
" q - gq formats comments (?)
" n - recon numbered lists
" v - wrap on blanks
" t - autowrap TEXT using textwidth
set formatoptions=croqnvt



"" == TERMINAL/GUI SETUP ==================================

if has("gui_running")
  colorscheme vylight
  set guifont=Droid\ Sans\ Mono\ Pro\ 9
  set guioptions=ai
  set columns=90
  set lines=50
else
  set t_Co=16
	colo myterm
endif


"" == SEARCH (AND REPLACE) OPTIONS =========================

"" F5 toggles highlighted search
map <F5> :set hls!<bar>set hls?<CR>
set ignorecase
set smartcase


"" == SYNTAX HIGHLIGHTING ==================================

syntax on

augroup mkd
  autocmd BufRead,BufNewFile *.mkd set ai formatoptions=tcroqn2 comments=n:> textwidth=72
augroup END

"" == PLUGIN OPTIONS =======================================

let g:miniBufExplMapWindowNavVim = 1

let g:NERDTreeWinSize=25

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

"inoremap <Tab> <C-R>=SuperCleverTab()<cr>

function! DeleteFile(...)
  if(exists('a:1'))
    let theFile=a:1
  elseif ( &ft == 'help' )
    echohl Error
    echo "Cannot delete a help buffer!"
    echohl None
    return -1
  else
    let theFile=expand('%:p')
  endif
  let delStatus=delete(theFile)
  if(delStatus == 0)
    echo "Deleted " . theFile
  else
    echohl WarningMsg
    echo "Failed to delete " . theFile
    echohl None
  endif
  return delStatus
endfunction
"delete the current file
com! Rm call DeleteFile()
"delete the file and quit the buffer (quits vim if this was the last file)
com! RM call DeleteFile() <Bar> q!
