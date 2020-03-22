" Change Nerdtree's dir to current file's dir
function! moz#Change_nerdtree_dir() 
  cd %:p:h  " change working dir 
  NERDTreeCWD  " change nerdtree's working dir 
  0  " move to line 0
  wincmd p  " put cursor back to previous window
  pwd  " print working dir 
endfunction

" Ctrl-D in insert mode: copy current line to next line
function! moz#Duplicate_line()
  let s:pos = getpos(".")
  let s:pos[1] = s:pos[1] + 1
  :execute "normal \<Esc>yyp"
  call setpos(".", s:pos)
endfunction
