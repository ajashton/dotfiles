"" GUI-only settings

let g:python3_host_prog = '/home/aj/.python3/bin/python'

"" NeovimGtk
if exists('g:GtkGuiLoaded')
  map <silent> <C-P> :NGShowProjectView<CR>
  imap <silent> <C-P> <Esc>:NGShowProjectView<CR>
  map <silent> <F9> :NGToggleSidebar<CR>
  imap <silent> <F9> <Esc>:NGToggleSidebar<CR>
endif
