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
  au! BufRead,BufNewFile *.markdown   setf ghmarkdown
  au! BufRead,BufNewFile *.mdown      setf ghmarkdown
  au! BufRead,BufNewFile *.mkd        setf ghmarkdown
  au! BufRead,BufNewFile *.md         setf ghmarkdown
  au! BufRead,BufNewFile *.txt        setf ghmarkdown
  " Moustache
  au! BufNewFile,BufRead *.mustache   setf mustache
  " MapServer config file
  au! BufNewFile,BufRead *.map        setf map
  " Mixed HTML and MarkDown
  au! BufRead,BufNewFile *.html       setf html
  " Puppet
  au! BufRead,BufNewFile *.pp         setf puppet
  " Underscore templates
  au! BufRead,BufNewFile *._          setf html
  " XML
  au! BufRead,BufNewFile *.vrt        setf xml
  
augroup END

