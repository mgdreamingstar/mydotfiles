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
function! moz#Run_Python_Complicate()
    silent w " save file 
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

function! moz#Run_Python_Simple()
    silent w
    if &filetype == 'python'
        silent exec "!python %"
    endif
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

" Did we open an empty vim? If so, change our working directory to 'HOME'
function! moz#Change_Dir_GitHub()
    if eval("@%") == ""
        cd $MOZ_GITHUB
    endif
endfunction

" change IME
function! moz#SmartIME(...) abort
" SwitchIME(0x0804) 中文 SwitchIME(0x0409) 英文
" 注意：Python 代码不能有缩进，不然无法识别。
let IMEcode = exists('a:1') ? a:1 : '0x0804'
"if (has('win64') || has('win32') || has('win16'))
    "let code = libcallnr('vimtweak.dll', 'SetIME', IMEcode)
    "return code
echom IMEcode
python << EOF
from win32con import WM_INPUTLANGCHANGEREQUEST
import win32gui
import win32api
import vim

IMEcode = vim.eval('IMEcode')

hwnd = win32gui.GetForegroundWindow()

result = win32api.SendMessage( hwnd, WM_INPUTLANGCHANGEREQUEST, 0, eval(IMEcode))
EOF
endfunction

" open help
function! moz#Help()
    let topic = input('Enter topic: ')
    let number_of_win = winnr('$')
    if number_of_win == 1
        exe "vert help " . topic
    elseif number_of_win > 1
        wincmd t
        wincmd o
        exe "vert help " . topic
    endif
endfunction

" open python_sketchs
fun! moz#Python_sketch()
    let files = globpath(&backupdir."\\python_sketchs", "**/*.py", 0, 1)
    let filename = fnamemodify(files[-1], ":t")
    if filename[:9] == strftime("%Y-%m-%d")
        exec "e ".files[-1]
    endif
endf

