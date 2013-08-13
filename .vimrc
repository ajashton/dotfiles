" == BASIC INTERFACE PREFERENCES ==========================

set nocompatible
"" backspace/delete like I'm used to:
set backspace=indent,eol,start
set history=100
set mouse=a
"" show relative line numbers:
set relativenumber
set ruler
set colorcolumn=80
set showcmd
"" show matching braces/parens:
set showmatch
set showtabline=1
set nospell
set title
"" disables both audio & visual bell:
set vb t_vb=
"" makes airline always visible:
set laststatus=2

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
  set t_Co=256
	colo sweet16
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
let g:NERDTreeDirArrows=1
let g:NERDTreeMinimalUI=1

let g:airline_theme='powerlineish'
let g:airline_powerline_fonts=0
"let g:airline_left_sep='▒'
"let g:airline_right_sep='▒'
let g:airline_enable_tagbar=0
let g:airline_detect_whitespace=0

"" == KEYBINDINGS ==========================================

nmap <F8> :TagbarToggle<CR>

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

" Bubble single lines
nmap <C-k> [e
nmap <C-j> ]e
" Bubble multiple lines
vmap <C-k> [egv
vmap <C-j> ]egv

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

" Show syntax highlighting groups for word under cursor
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
noremap   <F3> :call <SID>SynStack()<CR>
inoremap  <F3> :call <SID>SynStack()<CR>