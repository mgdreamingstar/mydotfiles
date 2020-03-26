" Change Nerdtree's dir to current file's dir
function! moz#Change_nerdtree_dir() 
    cd %:p:h  " change working dir 
    NERDTreeCWD  " change nerdtree's working dir 
    0  " move to line 0
    wincmd p  " put cursor back to previous window
    pwd  " print working dir 
endfunction

" Alt-o in insert mode: copy current line to next line
function! moz#Duplicate_line()
    let s:pos = getpos(".")
    let s:pos[1] = s:pos[1] + 1
    :execute "normal \<Esc>yyp"
    call setpos(".", s:pos)
endfunction

" Run Python code
function! moz#RunPython()
    let mp = &makeprg " save setting
    let ef = &errorformat " save setting
    let exefile = expand('%:t') " current file
    setlocal makeprg=python\ -u " set for local file
    " filter pattern for error message
    set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
    silent make %
    copen " open quickfix window
    let &makeprg = mp
    let &errorformat = ef
endfunction

" Source init.vim
function! moz#Source()
    source $MOZ_VIMRC
    wincmd p
endfunction

" Open a bash term in a new tab
function! moz#Term()
    tabe
    -tabmove
    term bash
endfunction
