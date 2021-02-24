"" == SETTINGS =============================================

let g:python_host_prog = '/usr/bin/python3'
let g:python3_host_prog = '/usr/bin/python3'

" Workaround for https://github.com/daa84/neovim-gtk/issues/209
set runtimepath+=,/usr/local/share/nvim-gtk/runtime

" Editing functionality
set backspace=indent,eol,start
set nobackup
set expandtab  " insert spaces instead of hard tabs
set ignorecase
set shiftwidth=2
set smartindent
set smartcase
set softtabstop=2
set nottimeout
set updatetime=300
set nowritebackup

" Interface & formatting
set belloff=all
set breakindent  " keep indentation when soft-wrapping
set cmdheight=1
set colorcolumn=80,100,120,140
set fillchars=vert:▕
set guioptions-=T  " disable toolbar in GUI
set nofoldenable
set hidden  " needed for project-wide search & replace in coc.vim
set linebreak
set list  " show non-visible characters as defined in listchars
set listchars=tab:├-┤,trail:·,extends:»,precedes:«,nbsp:▂
set mouse=a
set nonumber  " line numbers on the left
set ruler  " current line number at the bottom
if (has('nvim'))
  set signcolumn=auto:4  " aka the gutter
endif
set shortmess+=c
set showcmd
if (has('nvim'))
  set termguicolors
endif

syntax on

" turn filetype off then on again to clear any system-wide filetype settings
" our distro may have
filetype off
filetype plugin indent on


"" == CLIPBOARD BEHAVIOR ===================================

" Copy visual selection to X clipboard with Ctrl-Shift-C
vnoremap <C-C> "+y

" Cut visual selection to X clipboard with Ctrl-Shift-X
vnoremap <C-X> "+x

" Paste from X clipboard with Ctrl-Shift-V in all modes
inoremap <C-V> <C-R>+
nnoremap <C-V> "+P
vnoremap <C-V> "+P

" Keep clipboard contents even when Vim exits
autocmd VimLeave * call system("xclip -selection clipboard -i", getreg('+'))


"" == FILE TYPES ===========================================

autocmd BufNewFile,BufReadPost *.json       IndentLinesDisable
autocmd BufNewFile,BufReadPost *.ldjson     IndentLinesDisable
autocmd BufNewFile,BufReadPost *.geojson    IndentLinesDisable
autocmd BufNewFile,BufReadPost *.json       set filetype=json
autocmd BufNewFile,BufReadPost *.ldjson     set filetype=json
autocmd BufNewFile,BufReadPost *.geojson    set filetype=json

autocmd BufNewFile,BufReadPost *.md     set filetype=markdown
autocmd BufNewFile,BufReadPost *.mkd    set filetype=markdown
autocmd BufNewFile,BufReadPost *.txt    set filetype=markdown

autocmd BufNewFile,BufReadPost *.osc    set filetype=xml
autocmd BufNewFile,BufReadPost *.osm    set filetype=xml
autocmd BufNewFile,BufReadPost *.qml    set filetype=xml
autocmd BufNewFile,BufReadPost *.vrt    set filetype=xml

autocmd BufNewFile,BufReadPost *.template set filetype=js

" Disable syntax highlighting for large files
autocmd BufWinEnter * if line2byte(line("$") + 1) > 1000000 | setf none | endif


"" == PLUGINS ==============================================

call plug#begin('~/.nvim/plugged')

" Editing
Plug 'tpope/vim-commentary'
Plug 'editorconfig/editorconfig-vim'
Plug 'w0rp/ale'

" Syntax
Plug 'plasticboy/vim-markdown'
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'tkztmk/vim-vala'
Plug 'mechatroner/rainbow_csv'
Plug 'chr4/nginx.vim'

" Interface
Plug 'kien/ctrlp.vim' | Plug 'fisadev/vim-ctrlp-cmdpalette'
Plug 'airblade/vim-gitgutter'
Plug 'APZelos/blamer.nvim' " inline git blame
Plug 'majutsushi/tagbar'

" Color schemes
Plug 'arzg/vim-colors-xcode'

call plug#end()


"" == COLORS / UI ==========================================

function! ColorOverrides()
  if (has('ttyout'))
    " let that 1337 h@x0r terminal transparency shine:
    hi! Normal ctermbg=NONE guibg=NONE
    hi! NonText ctermbg=NONE guibg=NONE
  endif
endfunction

function! DarkUI()
  set background=dark
  colorscheme xcodewwdc
  set guioptions+=d  " enable GTK dark theme
  if (exists(':NGPreferDarkTheme') && exists('g:GtkGuiLoaded'))
    NGPreferDarkTheme on
  endif
  call ColorOverrides()
endfunction
command! DarkUI call DarkUI()

function! LightUI()
  set background=light
  colorscheme xcodelight
  set guioptions-=d  " disable GTK dark theme
  if (exists(':NGPreferDarkTheme') && exists('g:GtkGuiLoaded'))
    NGPreferDarkTheme off
  endif
  call ColorOverrides()
endfunction
command! LightUI call LightUI()

" Highlight certain keywords, but only in comments
augroup vimrc_todo
  au!
  au Syntax * syn match MyTodo /\v<(FIXME|NOTE|TODO):/
    \ containedin=.*Comment,vimCommentTitle
augroup END
hi def link MyTodo Todo


"" == PLUGIN CONFIG ========================================

" Ale
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_delay = 1000
let g:ale_sign_error = '▶'
let g:ale_sign_warning = '▪'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {'python': ['flake8']}

"" Blamer
let g:blamer_enabled = 0
let g:blamer_prefix = ' » '

"" CtrlP
let g:ctrlp_prompt_mappings = {
  \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
  \ 'AcceptSelection("t")': ['<cr>'],
  \ }

"" GitGutter
let g:gitgutter_sign_added = '▌'
let g:gitgutter_sign_modified = '▌'
let g:gitgutter_sign_modified_removed = '▌'
let g:gitgutter_sign_removed = '▁'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_override_sign_column_highlight = 0

"" JSON
let g:vim_json_syntax_conceal = 0  " don't hide quotation marks

"" Markdown
let g:vim_markdown_conceal = 0
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_toc_autofit = 1

" Start insert mode and disable line numbers on terminal buffer.
augroup terminalsettings
  autocmd!
  if has('nvim')
    autocmd TermOpen *
      \ setlocal nonumber norelativenumber noruler |
      \ startinsert
  endif
augroup end

"" Tagbar
nnoremap <silent> <F10> :TagbarToggle<CR>
inoremap <silent> <F10> <Esc>:TagbarToggle<CR>a


"" == KEYBINDINGS ==========================================


" Insert literal tab (regardless of indent/expansion/autocomplete settings)
inoremap <S-Tab> <C-V><Tab>

if (has('nvim'))
  tnoremap <Esc><Esc> <C-\><C-n>
endif

" Cycle through windows
noremap <M-Tab> <C-w>w
inoremap <M-Tab> <C-w>w
if (has('nvim'))
  tnoremap <M-Tab> <C-\><C-n><C-w>w
endif

" Swap apparent/actual line navigation
nnoremap <silent> k gk
nnoremap <silent> j gj
nnoremap <silent> gk k
nnoremap <silent> gj j

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

" Toggle 'default' terminal
if has('nvim')
  nnoremap <C-`> :call ChooseTerm("term-slider", 1)<CR>
  inoremap <C-`> <Esc>:call ChooseTerm("term-slider", 1)<CR>
  tnoremap <C-`> <C-\><C-n>:call ChooseTerm("term-slider", 1)<CR>
  " Start terminal in current pane
  nnoremap <M-CR> :call ChooseTerm("term-pane", 0)<CR>
  function! ChooseTerm(termname, slider)
    let pane = bufwinnr(a:termname)
    let buf = bufexists(a:termname)
    if pane > 0
      " pane is visible
      if a:slider > 0
        :exe pane . "wincmd c"
      else
        :exe "e #"
      endif
    elseif buf > 0
      " buffer is not in pane
      if a:slider
        :exe "belowright 20split"
      endif
      :exe "buffer " . a:termname
    else
      " buffer is not loaded, create
      if a:slider
        :exe "belowright 20split"
      endif
      :terminal
      :exe "f " a:termname
    endif
  endfunction
endif

"" Load color schemes last since they may rely on plugins & other settings
if (has('ttyout'))
  call DarkUI()
else
  call LightUI()
end
