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
  au! BufRead,BufNewFile *.mml        setf json
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
  " MapServer config file
  au! BufNewFile,BufRead *.map        setf map
  " Mixed HTML and MarkDown
  au! BufRead,BufNewFile *.html       setf html
  " Underscore templates
  au! BufRead,BufNewFile *._          setf html
  " XML
  au! BufRead,BufNewFile *.vrt        setf xml
  
augroup END

