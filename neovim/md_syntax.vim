let yellow1='#FEF9E7'
let yellow2='#F0B901'
let blue1='#EBF5FB'
let blue2='#3498DB'
let purple1='#F5EEF8'
let purple2='#9B59B6'
let red1='#F1948A'
let red2='#E74C3C'
let gray='#F2F4F4'

syn region code matchgroup=delimiter start=/```python/ end=/```/ contains=CONTAINED
syn region code2 start=/`\(`\)\@!/  end=/`\(`\)\@!/ oneline contains=CONTAINED
syn region math matchgroup=delimiter start="\$\$" end="\$\$"  contains=CONTAINED
syn region math2 matchgroup=delimiter start="\$\(\$\)\@!" end="\$\(\$\)\@!" contains=CONTAINED
syn region bold matchgroup=bold_d start=/\*\*/ end=/\*\*/ oneline
syn region italic matchgroup=italic_d start=/\*\(\*\)\@!/ end=/\*\(\*\)\@!/ oneline
syn match  list_item    /^\s*\%([-*+]\|\d\+\.\)\ze\s\+/
syn region header matchgroup=header_d start=/^#\{1,6}/ end=/$/
syn region blockquote   start=/^\s*>/  end=/$/
syn region footnote     start="\[^"   end="\]"


hi delimiter guibg=yellow1
hi list_item guibg=yellow1
hi code2 guibg=gray
hi math guifg=blue2
hi bold_d guifg=purple1
hi bold guifg=purple2
hi italic_d guifg=red1
hi italic guifg=red2
hi header gui=bold guifg=blue2