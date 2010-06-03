" markdown filetype file

if exists("did\_load\_filetypes")
	finish
endif

augroup filetypes
	au!
	" markdown
	au! BufRead,BufNewFile *.markdown	set filetype=mkd
	au! BufRead,BufNewFile *.mdown	    set filetype=mkd
	au! BufRead,BufNewFile *.mkd	    set filetype=mkd
	au! BufRead,BufNewFile *.md 	    set filetype=mkd
	" non-obvious php
	au! BufRead,BufNewFile *.inc	set filetype=php
	au! BufRead,BufNewFile *.module	set filetype=php
augroup END
