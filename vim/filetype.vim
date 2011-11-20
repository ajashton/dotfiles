if exists("did\_load\_filetypes")
  finish
endif

augroup filetypes
  au!
  " Cascadenik & Carto
  au! BufRead,BufNewFile *.mss        setf carto
  " Handlebar
  au! BufRead,BufNewFile *.hbs        setf html
  " JSON
  au! BufRead,BufNewFile *.json       setf json 
  " JavaScript
  au! BufRead,BufNewFile *.bones      setf javascript
	" Markdown
  au! BufRead,BufNewFile *.markdown	  setf mkd
  au! BufRead,BufNewFile *.mdown      setf mkd
  au! BufRead,BufNewFile *.mkd        setf mkd
  au! BufRead,BufNewFile *.md         setf mkd
  au! BufRead,BufNewFile *.txt        setf mkd
  " Moustache
  au! BufNewFile,BufRead *.mustache   setf mustache
	" Drupal!
	au! BufRead,BufNewFile *.inc        setf php
	au! BufRead,BufNewFile *.module     setf php
	au! BufRead,BufNewFile *.profile    setf php
  " MapServer config file
  au! BufNewFile,BufRead *.map        setf map
  " Mixed HTML and MarkDown
  au! BufRead,BufNewFile *.html       setf html
  " Underscore templates
  au! BufRead,BufNewFile *._          setf html
  
augroup END

