function! moz#Change_nerdtree_dir() 
  cd %:p:h  " change working dir 
  NERDTreeCWD  " change nerdtree's working dir 
  0  " move to line 0
  wincmd p  " put cursor back to previous window
  pwd  " print working dir 
endfunction
