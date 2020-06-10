let yellow1='#F2EDCA'
let yellow2='#F1C40F'
let blue1='#EBF5FB'
let blue2='#3498DB'
let purple1='#F5EEF8'
let purple2='#9B59B6'
let red1='#F1948A'
let red2='#E74C3C'
let gray='#E5E8E8'

syn clear

" multiline code and math
syn match code /```\(python\)\=/ oneline
syn match math "\$\$" oneline

" link and pic
syn match url "\S\+" nextgroup=markdownUrlTitle skipwhite contained
syn region link_text matchgroup=delimiter start="!\=\[\%(\_[^]]*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@=" nextgroup=link
syn region lnk matchgroup=delimiter start="(" end=")" contains=url keepend contained

" bold and italic
syn region bold matchgroup=bold_d start=/\*\*/ end=/\*\*/ oneline
syn region italic matchgroup=italic_d start=/\*\(\*\)\@!/ end=/\*\(\*\)\@!/ oneline

" header
syn region header matchgroup=header_d start=/^#\{1,6}/ end=/$/

" list
syn match  list_item    /^\s*\%([-*+]\|\d\+\.\)\ze\s\+/

" one line code and math
syn region code2 start=/`\(`\)\@!/  end=/`\(`\)\@!/ oneline
syn region math2 start="\$\(\$\)\@!" end="\$\(\$\)\@!" oneline

" quote and footnote
syn region blockquote   start=/^\s*>/  end=/$/
syn region footnote     start="\[^"   end="\]"

colorscheme pencil

" multiline code
hi code guifg=yellow2
" inline code
hi code2 guibg=purple1
" multiline math
hi math guifg=yellow2
" inline math
hi math2 guibg=yellow1
" list item
hi list_item guifg=yellow2
" bold
hi bold guifg=purple2
" bold delimiter
hi bold_d guifg=purple1
" italic
hi italic guifg=red2
" italic delimiter
hi italic_d guifg=red1
" header
hi header gui=bold guifg=blue2
" pic and link
hi lnk gui=underline
hi link_text gui=underline