"" == SETTINGS =============================================

set expandtab
set colorcolumn=80
set nottimeout
set shiftwidth=4
set smartindent
set softtabstop=4

syntax on
colorscheme sweet16


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

"" NERDTree
let g:NERDTreeDirArrows=1
let g:NERDTreeMinimalUI=1
nmap <F9> :NERDTreeTabsToggle<CR>


"" == KEYBINDINGS ==========================================

" Move current line up/down 1 line at a time
nmap <C-k> ddkP
nmap <C-j> ddp
" Move selected text up/down 1 line at a time
vmap <C-k> xkP`[V`]
vmap <C-j> xp`[V`]

