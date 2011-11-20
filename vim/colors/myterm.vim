" vim: tw=0 ts=4 sw=4
" Vim color file

hi clear
set background=dark
if exists("syntax_on")
  syntax reset
endif
hi SpecialKey	  term=bold  cterm=bold  ctermfg=DarkRed
hi NonText		  term=bold  cterm=bold  ctermfg=DarkRed
hi Directory	  term=bold  cterm=bold  ctermfg=Brown
hi ErrorMsg		  term=standout  cterm=bold  ctermfg=Grey
hi Search		  term=reverse  ctermfg=White  ctermbg=Red
hi MoreMsg		  term=bold  cterm=bold  ctermfg=DarkGreen
hi ModeMsg		  term=bold  cterm=bold
hi LineNr		  term=underline  cterm=bold  ctermfg=DarkCyan
hi Question		  term=standout  cterm=bold  ctermfg=darkgreen
hi StatusLine	  term=reverse  cterm=reverse ctermfg=LightGreen ctermbg=Black
hi StatusLineNC   term=reverse	cterm=reverse ctermfg=DarkGreen ctermbg=Black
hi Title		  term=bold  cterm=bold  ctermfg=DarkMagenta
hi Visual		  term=reverse	cterm=reverse
hi WarningMsg	  term=standout  cterm=bold  ctermfg=DarkRed
hi Comment		  term=bold  cterm=bold ctermfg=Cyan
hi Constant		  term=underline  cterm=bold ctermfg=Magenta
hi Special		  term=bold  cterm=bold ctermfg=Red
hi Identifier	  term=underline ctermfg=Brown
hi Statement	  term=bold  cterm=bold ctermfg=Yellow
hi PreProc		  term=underline ctermfg=DarkMagenta
hi Type			  term=underline cterm=bold ctermfg=LightGreen
hi Error		  term=reverse	ctermfg=DarkCyan  ctermbg=Black
hi Todo			  term=standout  ctermfg=Black	ctermbg=DarkCyan
hi CursorLine	  term=underline cterm=underline
hi CursorColumn	  term=underline cterm=underline
hi ColorColumn    ctermbg=DarkRed
hi MatchParen	  term=reverse  ctermfg=4
hi TabLine		  term=underline cterm=underline ctermfg=DarkGreen ctermbg=Black
hi TabLineFill	  term=underline cterm=underline ctermfg=DarkGreen ctermbg=Black
hi TabLineSel	  term=bold,reverse cterm=bold,reverse ctermfg=Red ctermbg=Black
hi VertSplit      ctermfg=DarkGreen ctermbg=DarkGreen 
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
