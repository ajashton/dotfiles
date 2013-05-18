" Vim syntax file
" Language:	Cascadenik Style Sheet
" Maintainer:	AJ Ashton <aj.ashton@gmail.com>
" URL:		http://github.com/ajashton/vim-cascadenik
" Last Change:	2010 July 18
" With sections & ideas yanked from the default css.vim

if exists("b:current_syntax")
  finish
endif

syn case match

"" Tags (there is only one)
syn keyword mssTag Map

"" IDs
try
  syn match mssIdentifier "#[A-Za-zÀ-ÿ_@][A-Za-zÀ-ÿ0-9_@-]*"
catch /^.*/
  syn match mssIdentifier "#[A-Za-z_@][A-Za-z0-9_@-]*"
endtry

"" Classes
syn match mssClass "\.[A-Za-z][A-Za-z0-9_-]\+"

"" Selectors
syn match mssSelectorOp "[+>.]"
syn match mssSelectorOp2 "[~|]\?=" contained
syn region mssAttributeSelector matchgroup=mssSelectorOp start="\[" end="]" transparent contains=mssSelectorOp2,mssStringQ,mssStringQQ

"" Strings
syn match mssSpecialCharQQ +\\"+ contained
syn match mssSpecialCharQ +\\'+ contained
syn region mssStringQQ start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=mssSpecialCharQQ
syn region mssStringQ start=+'+ skip=+\\\\\|\\'+ end=+'+ contains=mssSpecialCharQ

"" Attributes
syn match mssAttrColorKey contained "\<transparent\>"
syn match mssAttrColorHex contained "#[0-9A-Fa-f]\{3\}\>"
syn match mssAttrColorHex contained "#[0-9A-Fa-f]\{6\}\>"
syn match mssAttrFloat contained '\d\+\.\d*'
syn match mssAttrInteger contained '\d\+'
syn keyword mssAttrBoolean contained true false
syn keyword mssAttrKeyword contained butt miter round point

"" Properties
syn match mssPropLine contained "\<\(in\|out\|\)line-\(cap\|color\|dasharray\|join\|opacity\|width\)\>"
syn match mssPropMap contained "\<map-bgcolor\>"
syn match mssPropPattern contained "\<polygon-pattern-\(file\|height\|width\)\>"
syn match mssPropPoint contained "\<point-\(allow-overlap\|file\|height\|width\)\>"
syn match mssPropPolygon contained "\<polygon-\(fill\|gamma\|opacity\)\>"
syn match mssPropShield contained "\<shield-\(character-spacing\|face-name\|file\|fill\|height\|min-distance\|size\|width\)\>"
syn match mssPropTextStyle contained "\<text-\(character-spacing\|face-name\|fill\|halo-fill\|halo-radius\|line-spacing\|max-char-angle-delta\|ratio\|size\)\>"
syn match mssPropTextPosition contained "\<text-\(allow-overlap\|avoid-edges\|dx\|dy\|label-position-tolerance\|min-distance\|placement\|spacing\|wrap-width\)\>"

"" Other
syn keyword mssTodo contained TODO FIXME XXX NOTE

"" Regions
syn region mssDefinition transparent start="{" end="}" contains=mssAttr.*,mssProp.*,mssComment,mssString.*
syn region mssComment start="/\*" end="\*/" contains=mssTodo
syn region mssURL start="url(" end=")"

"" Style Linking
hi def link mssAttrBoolean      Type
hi def link mssAttrColorHex     Constant
hi def link mssAttrColorKey     Constant
hi def link mssAttrFloat        Number
hi def link mssAttrInteger      Number

hi def link mssPropLine         StorageClass
hi def link mssPropMap          StorageClass
hi def link mssPropPattern      StorageClass
hi def link mssPropPoint        StorageClass
hi def link mssPropPolygon      StorageClass
hi def link mssPropShield       StorageClass
hi def link mssPropTextStyle    StorageClass
hi def link mssPropTextPosition StorageClass

hi def link mssClass            Function
hi def link mssIdentifier       Function
hi def link mssTag              Statement
hi def link mssDefinition       Function

hi def link mssComment          Comment
hi def link mssTodo             Todo

hi def link mssStringQQ         String
hi def link mssStringQ          String
hi def link mssURL              String

hi def link mssSpecialCharQQ    Special
hi def link mssSpecialCharQ     Special

hi def link mssSelectorOp       Special
hi def link mssSelectorOp2      Special

let b:current_syntax = "mss"

" vim: tw=8
