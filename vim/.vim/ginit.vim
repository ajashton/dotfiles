"" GUI-only settings

" let g:python_host_prog = '/home/aj/.python3/bin/python'
" let g:python3_host_prog = '/home/aj/.python3/bin/python'

set columns=85
set lines=50

"" NeovimGtk
if exists('g:GtkGuiLoaded')
  let g:GuiInternalClipboard = 1
  map <silent> <C-P> :NGShowProjectView<CR>
  imap <silent> <C-P> <Esc>:NGShowProjectView<CR>
  map <silent> <F9> :NGToggleSidebar<CR>
  imap <silent> <F9> <Esc>:NGToggleSidebar<CR>
endif
