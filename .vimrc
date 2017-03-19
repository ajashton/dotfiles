"" == SETTINGS =============================================

set backspace=indent,eol,start
set colorcolumn=80
set expandtab
set ignorecase
set linebreak
set list
set lcs=tab:├─,trail:░,extends:»,precedes:«,nbsp:&
set nottimeout
set ruler
set shiftwidth=4
set showcmd
set smartindent
set smartcase
set softtabstop=4

syntax on
filetype off
filetype plugin indent on

" automatically enter insert mode when opening/focusing terminal buffers
autocmd BufEnter term://* startinsert


"" == FILE TYPES ===========================================

autocmd BufNewFile,BufReadPost *.md     set filetype=markdown
autocmd BufNewFile,BufReadPost *.mkd    set filetype=markdown
autocmd BufNewFile,BufReadPost *.txt    set filetype=markdown

autocmd BufNewFile,BufReadPost *.osc    set filetype=xml
autocmd BufNewFile,BufReadPost *.osm    set filetype=xml
autocmd BufNewFile,BufReadPost *.qml    set filetype=xml
autocmd BufNewFile,BufReadPost *.vrt    set filetype=xml

autocmd BufNewFile,BufReadPost *.js     set shiftwidth=2 softtabstop=2
autocmd BufNewFile,BufReadPost *.template set filetype=js shiftwidth=2 softtabstop=2


"" == PLUGINS ==============================================

call plug#begin('~/.nvim/plugged')

" Editing
Plug 'ervandew/supertab'
Plug 'tpope/vim-fugitive'
Plug 'vim-scripts/SyntaxAttr.vim'
Plug 'w0rp/ale'

" Syntax
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'tkztmk/vim-vala'

" Interface
Plug 'scrooloose/nerdtree' | Plug 'jistr/vim-nerdtree-tabs'
Plug 'airblade/vim-gitgutter'
Plug 'kien/rainbow_parentheses.vim'
Plug 'Yggdroot/indentLine'
Plug 'petelewis/vim-evolution'
Plug 'dikiaap/minimalist'

Plug 'gerw/vim-HiLinkTrace'

call plug#end()

"" == STATUS LINE ==========================================

" file name + flags:
set statusline=%t\ %h%m%r
" syntastic warnings:
set statusline+=\ %#warningmsg#%{SyntasticStatuslineFlag()}%*
" spacer, ruler
set statusline+=%=↧\ %l\ ┆\ ↦\ %c\ ┆\ %P

"" == PLUGIN CONFIG ========================================

colorscheme minimalist

"" Ale
let g:ale_lint_delay = 1000
let g:ale_sign_error = '▸▸'
let g:ale_sign_warning = '▹▹'
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']

"" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_signs = 0
let g:syntastic_loc_list_height = 5
let g:syntastic_sh_shellcheck_args='--exclude=SC1015,SC1016,SC2016'
let g:syntastic_sql_checkers=['pgsanity']

"" NERDTree
let g:NERDTreeDirArrows=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeMouseMode=2 " single click to expand directories, double-click to open files
let g:NERDTreeWinSize=40
nmap <F9> :NERDTreeTabsToggle<CR>

"" indentLine
"let g:indentLine_char = '▏'
let g:indentLine_char = '┊'
let g:indentLine_color_term = 236

"" JSON
let g:vim_json_syntax_conceal = 0 " don't hide quotation marks


"" == KEYBINDINGS ==========================================

" Insert literal tab (regardless of indent/expansion/autocomplete settings)
inoremap <S-Tab> <C-V><Tab>

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

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc


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
