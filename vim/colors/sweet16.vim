" SWEET16 - Embracing the 16 terminal colors

hi clear Normal
set background=dark
if exists("syntax_on")
  syntax reset
endif

"" UI
hi StatusLine	  term=none cterm=none ctermfg=White ctermbg=Black
hi StatusLineNC   term=none cterm=none ctermfg=DarkBlue ctermbg=Black
hi VertSplit      ctermfg=Black ctermbg=Black
hi LineNr		  ctermfg=DarkBlue ctermbg=Black
hi TabLine		  term=underline cterm=underline ctermfg=DarkBlue ctermbg=Black
hi TabLineFill	  term=underline cterm=underline ctermfg=DarkBlue ctermbg=Black
hi CursorColumn	  term=underline cterm=underline
hi ColorColumn    ctermbg=Black

hi clear SpellBad
hi SpellBad       term=underline cterm=underline
hi Title		  term=bold  cterm=bold  ctermfg=Yellow

"hi SpecialKey	  term=bold  cterm=bold  ctermfg=DarkRed
"hi NonText		  term=bold  cterm=bold  ctermfg=DarkRed
"hi Directory	  term=bold  cterm=bold  ctermfg=Brown
"hi ErrorMsg		  term=standout  cterm=bold  ctermfg=Grey
"hi Search		  term=reverse  ctermfg=White  ctermbg=Red
"hi MoreMsg		  term=bold  cterm=bold  ctermfg=DarkGreen
"hi ModeMsg		  term=bold  cterm=bold
"hi Question		  term=standout  cterm=bold  ctermfg=darkgreen
"hi Visual		  term=reverse	cterm=reverse
"hi WarningMsg	  term=standout  cterm=bold  ctermfg=DarkRed
"hi Comment		  ctermfg=DarkGrey
"hi Constant		  term=underline  cterm=bold ctermfg=Magenta
"hi Special		  term=bold  cterm=bold ctermfg=Red
"hi Identifier	  term=underline ctermfg=Brown
"hi Statement	  term=bold  cterm=bold ctermfg=Green
"hi PreProc		  term=underline ctermfg=DarkMagenta
"hi Type			  term=underline cterm=bold ctermfg=LightGreen
"hi Error		  term=reverse	ctermfg=DarkCyan  ctermbg=Black
"hi Todo			  term=standout  ctermfg=Black	ctermbg=DarkCyan
"hi CursorLine	  term=underline cterm=underline
"hi MatchParen	  term=reverse  ctermfg=4
"hi TabLineSel	  term=bold,reverse cterm=bold,reverse ctermfg=Red ctermbg=Black
"hi link IncSearch		Visual
"hi link String			Constant
"hi link Character		Constant
"hi link Number			Constant
"hi link Boolean			Constant
"hi link Float			Number
"hi link Function		Identifier
"hi link Conditional		Statement
"hi link Repeat			Statement
"hi link Label			Statement
"hi link Operator		Statement
"hi link Keyword			Statement
"hi link Exception		Statement
"hi link Include			PreProc
"hi link Define			PreProc
"hi link Macro			PreProc
"hi link PreCondit		PreProc
"hi link StorageClass	Type
"hi link Structure		Type
"hi link Typedef			Type
"hi link Tag				Special
"hi link SpecialChar		Special
"hi link Delimiter		Special
"hi link SpecialComment	Special
"hi link Debug			Special

" vim: tw=0 ts=4 sw=4
