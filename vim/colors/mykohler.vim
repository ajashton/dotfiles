" vim: tw=0 ts=4 sw=4
" Vim color file

hi clear
set background=dark
if exists("syntax_on")
  syntax reset
endif
hi SpecialKey	  term=bold  cterm=bold  ctermfg=darkred
hi NonText		  term=bold  cterm=bold  ctermfg=darkred
hi Directory	  term=bold  cterm=bold  ctermfg=brown
hi ErrorMsg		  term=standout  cterm=bold  ctermfg=grey
hi Search		  term=reverse  ctermfg=white  ctermbg=red
hi MoreMsg		  term=bold  cterm=bold  ctermfg=darkgreen
hi ModeMsg		  term=bold  cterm=bold
hi LineNr		  term=underline  cterm=bold  ctermfg=darkcyan
hi Question		  term=standout  cterm=bold  ctermfg=darkgreen
hi StatusLine	  term=reverse  cterm=reverse ctermfg=Green ctermbg=White
hi StatusLineNC   term=reverse	cterm=reverse ctermfg=DarkGreen ctermbg=Black
hi Title		  term=bold  cterm=bold  ctermfg=darkmagenta
hi Visual		  term=reverse	cterm=reverse
hi WarningMsg	  term=standout  cterm=bold  ctermfg=darkred
hi Comment		  term=bold  cterm=bold ctermfg=cyan
hi Constant		  term=underline  cterm=bold ctermfg=magenta
hi Special		  term=bold  cterm=bold ctermfg=red
hi Identifier	  term=underline ctermfg=brown
hi Statement	  term=bold  cterm=bold ctermfg=yellow
hi PreProc		  term=underline ctermfg=darkmagenta
hi Type			  term=underline cterm=bold ctermfg=lightgreen
hi Error		  term=reverse	ctermfg=darkcyan  ctermbg=black
hi Todo			  term=standout  ctermfg=black	ctermbg=darkcyan
hi CursorLine	  term=underline cterm=underline
hi CursorColumn	  term=underline cterm=underline
hi MatchParen	  term=reverse  ctermfg=blue
hi TabLine		  term=NONE,underline cterm=NONE,underline ctermfg=2 ctermbg=0
hi TabLineFill	  term=NONE,underline cterm=NONE,underline ctermfg=2 ctermbg=0
hi TabLineSel	  term=NONE cterm=NONE ctermfg=10 ctermbg=2
hi link IncSearch		Visual
hi link String			Constant
hi link Character		Constant
hi link Number			Constant
hi link Boolean			Constant
hi link Float			Number
hi link Function		Identifier
hi link Conditional		Statement
hi link Repeat			Statement
hi link Label			Statement
hi link Operator		Statement
hi link Keyword			Statement
hi link Exception		Statement
hi link Include			PreProc
hi link Define			PreProc
hi link Macro			PreProc
hi link PreCondit		PreProc
hi link StorageClass	Type
hi link Structure		Type
hi link Typedef			Type
hi link Tag				Special
hi link SpecialChar		Special
hi link Delimiter		Special
hi link SpecialComment	Special
hi link Debug			Special
