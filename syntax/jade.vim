" Vim syntax file
" Language:	Jade
" Filenames:	*.jade
" Ported from tpope's vim-haml

if exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'jade'
endif

runtime! syntax/html.vim
unlet! b:current_syntax

syn case match

syn cluster jadeComponent    contains=jadeAttributes,jadeClassChar,jadeIdChar,jadeDespacer,jadeSelfCloser,jadePlainChar
syn cluster jadeTop          contains=jadeBegin,jadePlainFilter,jadeSassFilter,jadeComment,jadeHtmlComment

syn match   jadeBegin "^\s*\%([<>]\|&[^=~ ]\)\@!" nextgroup=jadeTag,jadeClassChar,jadeIdChar,jadePlainChar
syn match   jadeTag        "\w\+" contained contains=htmlTagName,htmlSpecialTagName nextgroup=@jadeComponent
syn region  jadeAttributes     matchgroup=jadeAttributesDelimiter start="(" end=")" contained contains=htmlArg,jadeAttributeString,jadeAttributeVariable,htmlEvent,htmlCssDefinition nextgroup=@jadeComponent
syn match   jadeDespacer "[<>]" contained nextgroup=jadeDespacer,jadeSelfCloser,jadePlainChar
syn match   jadeSelfCloser "/" contained
syn match   jadeClassChar "\." contained nextgroup=jadeClass
syn match   jadeIdChar "#{\@!" contained nextgroup=jadeId
syn match   jadeClass "\%(\w\|-\)\+" contained nextgroup=@jadeComponent
syn match   jadeId    "\%(\w\|-\)\+" contained nextgroup=@jadeComponent
syn region  jadeDocType start="^\s*!!!" end="$"

syn match   jadePlainChar "\\" contained

syn region  jadeAttributeString start=+\%(=\|:\s*\)\@<="+ skip=+\%(\\\\\)*\\"+ end=+"+
syn match   jadeAttributeVariable "\%(=\|:\s*\)\@<=\%(@@\=\|\$\)\=\w\+" contained

syn cluster jadeHtmlTop contains=@htmlTop,htmlBold,htmlItalic,htmlUnderline
syn region  jadePlainFilter      matchgroup=jadeFilter start="^\z(\s*\):\%(plain\|preserve\|redcloth\|textile\|markdown\|maruku\)\s*$" end="^\%(\z1 \| *$\)\@!" contains=@jadeHtmlTop
syn region  jadeEscapedFilter    matchgroup=jadeFilter start="^\z(\s*\):\%(escaped\|cdata\)\s*$"    end="^\%(\z1 \| *$\)\@!" 
syn region  jadeJavascriptFilter matchgroup=jadeFilter start="^\z(\s*\):javascript\s*$" end="^\%(\z1 \| *$\)\@!" contains=@htmlJavaScript keepend
syn region  jadeCSSFilter        matchgroup=jadeFilter start="^\z(\s*\):css\s*$"        end="^\%(\z1 \| *$\)\@!" contains=@htmlCss keepend
syn region  jadeSassFilter       matchgroup=jadeFilter start="^\z(\s*\):sass\s*$"       end="^\%(\z1 \| *$\)\@!" contains=@jadeSassTop

syn region  jadeJavascriptBlock start="^\z(\s*\)script" nextgroup=@jadeComponent,jadeError end="^\%(\z1 \| *$\)\@!" contains=@jadeTop,@htmlJavaScript keepend
syn region  jadeCssBlock        start="^\z(\s*\)style" nextgroup=@jadeComponent,jadeError  end="^\%(\z1 \| *$\)\@!" contains=@jadeTop,@htmlCss keepend
syn match   jadeError "\$" contained

syn match   jadeComment "^\s*\/\/-.*$"
syn match   jadeHtmlComment  "^\s*\/\/[^-].*$"

hi def link jadeSelfCloser             Special
hi def link jadeDespacer               Special
hi def link jadeClassChar              Special
hi def link jadeIdChar                 Special
hi def link jadeTag                    Special
hi def link jadeClass                  Type
hi def link jadeId                     Identifier
hi def link jadePlainChar              Special
hi def link jadeAttributeString        String
hi def link jadeAttributeVariable      Identifier
hi def link jadeDocType                PreProc
hi def link jadeFilter                 PreProc
hi def link jadeAttributesDelimiter    Delimiter
hi def link jadeHtmlComment            SpecialComment
hi def link jadeComment                Comment
hi def link jadeError                  Error

let b:current_syntax = "jade"

if main_syntax == "jade"
  unlet main_syntax
endif

set comments=://-,://
" vim:set sw=2:
