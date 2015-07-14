"" == SETTINGS =============================================

set backspace=indent,eol,start
set colorcolumn=80
set expandtab
set ignorecase
set list
set lcs=tab:├─,trail:░,extends:»,precedes:«,nbsp:&
set nottimeout
set ruler
set shiftwidth=4
set smartindent
set smartcase
set softtabstop=4

syntax on
colorscheme sweet16
filetype off
filetype plugin indent on


"" == FILE TYPES ===========================================

autocmd BufNewFile,BufReadPost *.md     set filetype=markdown
autocmd BufNewFile,BufReadPost *.osc    set filetype=xml
autocmd BufNewFile,BufReadPost *.osm    set filetype=xml
autocmd BufNewFile,BufReadPost *.vrt    set filetype=xml


"" == PLUGINS ==============================================

call plug#begin('~/.nvim/plugged')

" Editing
Plug 'ervandew/supertab'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive'

" Interface
Plug 'scrooloose/nerdtree' | Plug 'jistr/vim-nerdtree-tabs'
Plug 'airblade/vim-gitgutter'
Plug 'Yggdroot/indentLine'

call plug#end()


"" == PLUGIN CONFIG ========================================

"" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_signs = 0

"" NERDTree
let g:NERDTreeDirArrows=1
let g:NERDTreeMinimalUI=1
nmap <F9> :NERDTreeTabsToggle<CR>

"" indentLine
let g:indentLine_char = '┆'
let g:indentLine_color_dark = 254


"" == KEYBINDINGS ==========================================

" Copy
noremap <T-c> "+y
" Paste
noremap <T-v> "+p
inoremap <T-v> <C-O>"+P

" Jump to tabs by number
noremap <M-1> 1gt
noremap <M-2> 2gt
noremap <M-3> 3gt
noremap <M-4> 4gt
noremap <M-5> 5gt
noremap <M-6> 6gt
noremap <M-7> 7gt
noremap <M-8> 8gt
noremap <M-9> 9gt
noremap <M-0> 10gt
inoremap <M-1> <C-O>1gt
inoremap <M-2> <C-O>2gt
inoremap <M-3> <C-O>3gt
inoremap <M-4> <C-O>4gt
inoremap <M-5> <C-O>5gt
inoremap <M-6> <C-O>6gt
inoremap <M-7> <C-O>7gt
inoremap <M-8> <C-O>8gt
inoremap <M-9> <C-O>9gt
inoremap <M-0> <C-O>10gt
if (has('nvim'))
    " TODO: figure out the terminal equivalent of <C-O>
    tnoremap <M-1> <C-\><C-n>1gt
    tnoremap <M-2> <C-\><C-n>2gt
    tnoremap <M-3> <C-\><C-n>3gt
    tnoremap <M-4> <C-\><C-n>4gt
    tnoremap <M-5> <C-\><C-n>5gt
    tnoremap <M-6> <C-\><C-n>6gt
    tnoremap <M-7> <C-\><C-n>7gt
    tnoremap <M-8> <C-\><C-n>8gt
    tnoremap <M-9> <C-\><C-n>9gt
    tnoremap <M-0> <C-\><C-n>10gt
endif

" Move current line up/down 1 line at a time
nmap <C-k> ddkP
nmap <C-j> ddp
" Move selected text up/down 1 line at a time
vmap <C-k> xkP`[V`]
vmap <C-j> xp`[V`]

" Show syntax highlighting groups for word under cursor
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
noremap   <F3> :call <SID>SynStack()<CR>
inoremap  <F3> :call <SID>SynStack()<CR>


"" == COMMANDS =============================================

" delete the current file
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
com! Rm call DeleteFile()
" delete the file and quit the buffer (quits vim if this was the last file)
com! RM call DeleteFile() <Bar> q!
