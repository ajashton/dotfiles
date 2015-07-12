" SWEET16 - Embracing the 16 terminal colors
"
" Note: this color scheme assumes there is a small amount of contrast between
" your 'Black' color and your default background color.

hi clear Normal
set background=dark
if exists("syntax_on")
  syntax reset
endif

"" == UI ==
hi ColorColumn      ctermbg=Black
hi CursorColumn     term=underline cterm=underline
hi Visual           term=bold cterm=bold ctermfg=white ctermbg=DarkBlue
hi LineNr           ctermfg=DarkGrey ctermbg=Black
hi StatusLine       term=none cterm=none ctermfg=White ctermbg=Black
hi StatusLineNC     term=none cterm=none ctermfg=DarkBlue ctermbg=Black
hi TabLine          term=underline cterm=underline ctermfg=DarkBlue ctermbg=Black
hi TabLineFill      term=underline cterm=underline ctermfg=DarkBlue ctermbg=Black
hi TabLineSel       term=underline,bold cterm=underline,bold
hi VertSplit        term=none cterm=none ctermfg=Black ctermbg=Black
hi NonText          term=none  cterm=none  ctermfg=Black
hi Title            term=bold  cterm=bold  ctermfg=Yellow

if has("spell")
    hi clear SpellBad
    hi SpellBad         term=underline cterm=underline
endif

"" == General Syntax ==
hi Normal           ctermfg=LightGrey
hi Character        ctermfg=Blue
hi Comment          ctermfg=DarkGrey
hi Conditional      ctermfg=Green
hi Label            ctermfg=Blue
hi Number           ctermfg=Red
hi Statement        ctermfg=Green
hi String           ctermfg=Blue
hi Identifier       ctermfg=Magenta cterm=bold

" vim: tw=0 ts=4 sw=4
