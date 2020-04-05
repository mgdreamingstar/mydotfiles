let yellow1='#F2EDCA'
let yellow2='#F1C40F'
let blue1='#EBF5FB'
let blue2='#3498DB'
let purple1='#F5EEF8'
let purple2='#9B59B6'
let red1='#F1948A'
let red2='#E74C3C'
let gray='#E5E8E8'

syn match code /```python/ oneline
syn match code /```/ oneline
syn match math "\$\$" oneline
syn region bold matchgroup=bold_d start=/\*\*/ end=/\*\*/ oneline
syn region italic matchgroup=italic_d start=/\*\(\*\)\@!/ end=/\*\(\*\)\@!/ oneline
syn region header matchgroup=header_d start=/^#\{1,6}/ end=/$/
syn match  list_item    /^\s*\%([-*+]\|\d\+\.\)\ze\s\+/

syn region code2 start=/`\(`\)\@!/  end=/`\(`\)\@!/ oneline contains=CONTAINED
syn region math2 start="\$\(\$\)\@!" end="\$\(\$\)\@!" contains=CONTAINED
syn region blockquote   start=/^\s*>/  end=/$/
syn region footnote     start="\[^"   end="\]"

hi code guifg=yellow2
hi math guifg=yellow2
hi math2 guibg=yellow1
hi list_item guifg=yellow2
hi code2 guibg=purple1

hi bold guifg=purple2
hi bold_d guifg=purple1
hi italic guifg=red2
hi italic_d guifg=red1
hi header gui=bold guifg=blue2