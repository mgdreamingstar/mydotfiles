"
"
"                            _
"  _ __ ___   ___ ______   _(_)_ __ ___  _ __ ___
" | '_ ` _ \ / _ \_  /\ \ / / | '_ ` _ \| '__/ __|
" | | | | | | (_) / /  \ V /| | | | | | | | | (__
" |_| |_| |_|\___/___|  \_/ |_|_| |_| |_|_|  \___|
"
"
" Author: @moz

" FIRST_of_ALL:
"
    " 1. set $MOZ_CONFIG $MOZ_VIMRC
    " 2. run nvim with: `nvim --cmd \"let setup=1 source $MOZ_VIMRC\"`
            " As vimrc comment, escaped \"; in shell don't escape \"

" Need_Todo:
"
    " set $MOZ_GITHUB \ $MOZ_PYTHON3
    " set ~/.cache
    " ln -s coc-settings
    " set calendar.vim/credentials.vim

" Info: (win * linux)
" Vimrc_path: $MOZ_VIMRC
"   - /AppData/Local/nvim/init.vim
"   - $VIM/sysinit.vim
"
" Config_dir: $MOZ_CONFIG
"   - %USERPROFILE/.config/nvim
"   - ~/.config/nvim
"
" GitHub_dir: $MOZ_GITHUB
"   - D:/mozli/Documents/GitHub
"   - ~/GitHub
"
" Python3_path: $MOZ_PYTHON3
"   - D:/Anaconda/envs/new3/python
"   - ~/Anaconda/envs/new3/python
"
" Backup_dir:
"   - /AppData/Local/nvim/backup
"   - ~/.config/nvim/backup
"
" Temp_dir:
"   - /AppData/Local/nvim/moz_tmp
"   - ~/.config/nvim/moz_tmp
"
" plug.vim: Curl: nutstore | github ---> Set
" plugged
"

" platform settings            
if has('win32') || has('win64') || has('win16') || has('win95')

    let s:iswindows = 1
    let s:islinux = 0
    let s:plug_vim = fnameescape($MOZ_CONFIG . '\autoload\plug.vim')
    let s:plugged_folder = fnameescape($MOZ_CONFIG . '\plugged')
    let s:mydotfiles = fnameescape($MOZ_GITHUB . '\mydotfiles\neovim')
    let s:backup = fnameescape($MOZ_CONFIG . '\moz_tmp\backup')
    let s:tmp = fnameescape($MOZ_CONFIG . '\moz_tmp\tmp')
    let s:undo = fnameescape($MOZ_CONFIG . '\moz_tmp\tmp\undo')

else

    let s:islinux = 1
    let s:iswindows = 0
    let s:plug_vim = fnameescape($MOZ_CONFIG . '/autoload/plug.vim')
    let s:plugged_folder = fnameescape($MOZ_CONFIG . '/plugged')
    let s:mydotfiles = fnameescape($MOZ_GITHUB . '/mydotfiles/neovim')
    let s:backup = fnameescape($MOZ_CONFIG . '/moz_tmp/backup')
    let s:tmp = fnameescape($MOZ_CONFIG . '/moz_tmp/tmp')
    let s:undo = fnameescape($MOZ_CONFIG . '/moz_tmp/tmp/undo')

endif


" ===
" === Auto load for first time users
" ===

if exists('debug')

  " echom will send info to message-history
  echom 'expand(s:plug_vim):'.expand(s:plug_vim)
  echom 'glob(expand(s:plug_vim)):'.string(glob(expand(s:plug_vim)))
  echom 'empty(glob(expand(s:plug_vim))):'.string(empty(glob(expand(s:plug_vim))))

endif

" download plug.vim
if exists('setup') && empty(glob(expand(s:plug_vim)))
   
    echom 'there is no plug_vim:'.s:plug_vim
   
    echom 'not found plug.vim, curling form github'
    " if download speed < 1k Bytes/s for 3s, then close connection
    "exec '!curl -Lo ' . expand(s:plug_vim) . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim --speed-time 3 --speed-limit 1000'
    exec '!curl -Lo ' . expand(s:plug_vim) . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim --max-time 10'
   
    if v:shell_error

        echom 'download failed, copying from GitHub/mydotfiles'

        if s:iswindows

            exec '!copy ' . expand(s:mydotfiles) . '\win_neo_autoload\plug.vim ' . expand(s:plug_vim)

        endif

        if s:islinux

            exec '!cp ' . expand(s:mydotfiles) . '/win_neo_autoload/plug.vim ' . expand(s:plug_vim)

        endif

        "echom 'not found plug.vim, curling from nutstore'
        "" if download speed < 1 Bytes/s for 5s, then close connection
        "exec '!curl -Lo ' . expand(s:plug_vim) . ' --create-dirs https://www.jianguoyun.com/p/DWplQswQq8qeCBil5vwC --speed-limit 5 --speed-limit 1'
   
    endif

endif

" setup files and folders
" windows
if exists('setup') && s:iswindows
     
    echom 'make symlink from $MOZ_VIMRC to default init.vim'
    exec '!mklink ' . $USERPROFILE . ' AppData\Local\nvim\init.vim ' . $MOZ_VIMRC
    exec '!mklink ' . $MOZ_CONFIG . '\autoload\moz.vim ' . expand(s:mydotfiles) . '\win_neo_autoload\moz.vim'
    exec '!mklink ' . $USERPROFILE . ' AppData\Local\nvim\coc-settings.json ' . expand(s:mydotfiles) . '\coc-settings.json'
    exec '!copy ' . expand(s:mydotfiles) . '\md_keymaps.vim ' . $MOZ_CONFIG . '\md_keymaps.vim'
    exec '!xcopy /E /I ' . expand(s:mydotfiles) . '\UltiSnips ' . $MOZ_CONFIG . '\UltiSnips'

endif
     
" linux
if exists('setup') && s:islinux
     
    echom 'make symlink from $MOZ_VIMRC to default init.vim'
    exec '!ln -s ' . $MOZ_VIMRC . ' ' . $VIM . '/sysinit.vim'
    exec '!ln -s' . expand(s:mydotfiles) . '/win_neo_autoload/moz.vim ' . $MOZ_CONFIG . '/autoload/moz.vim'
    exec '!ln -s' . expand(s:mydotfiles) . '/coc-settings.json ' . $MOZ_CONFIG . '/coc-settings.json'
    exec '!cp ' . expand(s:mydotfiles) . '/md_keymaps.vim ' . $MOZ_CONFIG . '/md_keymaps.vim'
    exec '!cp -vR ' . expand(s:mydotfiles) . '/UltiSnips/. ' . $MOZ_CONFIG . '/UltiSnips/'

endif

if exists('setup')
    autocmd VimEnter * PlugInstall --sync
endif


call plug#begin(s:plugged_folder)
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim', {'on': []}
Plug 'lervag/vimtex'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'altercation/vim-colors-solarized'
Plug 'mhartington/oceanic-next'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'Yggdroot/LeaderF', { 'do': '.\install.bat' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" themes
Plug 'joshdick/onedark.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
"Plug 'altercation/vim-colors-solarized'
Plug 'ajmwagar/vim-deus'
Plug 'mgdreamingstar/peaksea'
Plug 'reedes/vim-colors-pencil'

Plug 'liuchengxu/vista.vim'
"Plug 'ludovicchabant/vim-gutentags'
"Plug 'skywind3000/gutentags_plus'
"Plug 'skywind3000/vim-preview'
"Plug 'skywind3000/vim-quickui'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'


" Plug 'terryma/vim-multiple-cursors'
Plug 'mg979/vim-visual-multi'
"Plug 'machakann/vim-highlightedyank'
" Plug 'sillybun/vim-repl'
Plug 'tmhedberg/SimpylFold', { 'for' :['python', 'vim-plug'] }
Plug 'Vimjas/vim-python-pep8-indent', { 'for' :['python', 'vim-plug'] }
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for' :['python', 'vim-plug'] }
Plug 'tweekmonster/braceless.vim'

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install_sync() }, 'for' :['markdown', 'vim-plug'] }
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }
Plug 'mzlogin/vim-markdown-toc', { 'for': ['gitignore', 'markdown'] }
"Plug 'theniceboy/bullets.vim'
"Plug 'gabrielelana/vim-markdown'
Plug 'plasticboy/vim-markdown'
"Plug 'amix/vim-zenroom2'
Plug 'mgdreamingstar/vim-zenroom2'
"Plug 'reedes/vim-pencil'
"Plug 'vim-pandoc/vim-pandoc-syntax'
"Plug 'vim-pandoc/vim-pandoc'

Plug 'jiangmiao/auto-pairs'
Plug '907th/vim-auto-save'
Plug 'vimwiki/vimwiki', {'branch': 'dev'}

" Undo Tree
Plug 'mbbill/undotree'

" Editor Enhancement
"Plug 'Raimondi/delimitMate'
Plug 'scrooloose/nerdcommenter' " in <leader>cn to comment a line
Plug 'AndrewRadev/switch.vim' " gs to switch
Plug 'tpope/vim-surround' " type ysiw' to wrap the word with '' or type cs'` to change 'word' to `word`
Plug 'gcmt/wildfire.vim' " in Visual mode, type i' to select all text in '', or type i) i] i} ip
Plug 'junegunn/vim-after-object' " da= to delete what's after =
Plug 'junegunn/vim-easy-align' " gaip= to align the = in paragraph,
Plug 'tpope/vim-capslock' " Ctrl+Gc (insert) or gC (normal) to toggle capslock
Plug 'easymotion/vim-easymotion'
Plug 'Konfekt/FastFold'

" 输入法
"Plug 'lotabout/ywvim'

"Plug 'junegunn/vim-peekaboo'
"Plug 'wellle/context.vim'
Plug 'svermeulen/vim-subversive'  " use siw to replace <cword> with clipboard

" For general writing
Plug 'junegunn/goyo.vim'

" Bookmarks
"Plug 'kshenoy/vim-signature'
Plug 'MattesGroeger/vim-bookmarks'

" Find & Replace
Plug 'brooth/far.vim', { 'on': ['F', 'Far', 'Fardo'] }
" Plug 'osyo-manga/vim-anzu'

" Documentation
"Plug 'KabbAmine/zeavim.vim' " <LEADER>z to find doc

" Mini Vim-APP
"Plug 'voldikss/vim-floaterm'
"Plug 'liuchengxu/vim-clap'
"Plug 'jceb/vim-orgmode'
Plug 'mhinz/vim-startify'

" Vim Applications
Plug 'itchyny/calendar.vim'
"Plug 'mattn/calendar-vim'

" Other visual enhancement
" Plug 'ryanoasis/vim-devicons'
" Plug 'luochen1990/rainbow'
" Plug 'mg979/vim-xtabline'
" Plug 'wincent/terminus'

" Other useful utilities
" Plug 'lambdalisue/suda.vim' " do stuff like :sudowrite
" Plug 'makerj/vim-pdf'
"Plug 'xolox/vim-session'
"Plug 'xolox/vim-misc' " vim-session dep

" quick align
"Plug 'godlygeek/tabular'
" Dependencies
" Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'kana/vim-textobj-user'

call plug#end()


"--------------------------------------------------
"--------------------------------------------------
"  General Settings
"--------------------------------------------------
"--------------------------------------------------

set clipboard+=unnamed
set ignorecase
set fileencodings=utf-8,gbk2312,gbk,gb18030,cp936
set encoding=utf-8
set termencoding=utf-8
set langmenu=zh_CN
let $LANG = 'en_US.UTF-8'
set ts=4  " tab = 4 spaces
set shiftwidth=4
set softtabstop=4
set expandtab
"set noswapfile  " don't use swap file
set number
set autochdir
set autoindent
set list  " show tab and other special chars
set listchars=tab:>-,trail:+
set scrolloff=4
set viewoptions=cursor,folds,unix,slash
set indentexpr=
set foldmethod=indent
set foldlevel=99
set foldenable
set formatoptions-=tc
set splitright
set splitbelow
set noshowmode
set showcmd
set wildmenu " list completion at c mode 
set smartcase
set inccommand=split
set completeopt=longest,noinsert,menuone,noselect,preview
set ttyfast  " make scroll faster
set lazyredraw  " faster redraw
set visualbell
set colorcolumn=99 " highlight 100 column
set virtualedit=block
set conceallevel=0 " no conceal
"set linebreak " break line 
"set textwidth=99
set showbreak=>  
set fo+=tmB " break line at Unicode characters
set cursorline " highlight the cursor line 
"set relativenumber
set t_Co=256
" autoread file if changed outside of vim
set autoread
au CursorHold * checktime
set mouse=r

"-------------------------------------------------- 
let g:python3_host_prog = $MOZ_PYTHON3
if s:iswindows
    let g:python_host_prog = 'D:\Anaconda\python.exe'
endif

" Open up pudb
"noremap <c-.> :tab sp<CR>:term python3 -m pudb %<CR>
" Run script with Python
nnoremap <M-r> :call moz#Run_Python_Simple()<cr>
map <leader><leader> :call moz#Python_new_sketch()<cr>
nnoremap <leader>kl :call moz#Python_last_sketch()<cr>
"noremap <f5> :tab sp<CR>:term python3 -m pudb %<CR>

set tags=./.tags;,.tags

" UndoTree and swap file
if exists("setup")
    silent! mkdir(s:backup, 'p')
    silent! mkdir(s:undo, 'p')
endif

"silent !mkdir -p ~/.config/nvim/tmp/sessions
set backupdir=C:\\Users\\GRC\\.config\\nvim\\moz_tmp\\backup
set directory=C:\\Users\\GRC\\.config\\nvim\\moz_tmp\\backup
if has('persistent_undo')
    set undodir=C:\\Users\\GRC\\.config\\nvim\\moz_tmp\\tmp\\undo
    set undofile
endif

" Or if you have Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif

"--------------------------------------------------
" Theme
"--------------------------------------------------
syntax enable
" colorscheme OceanicNext
" colorscheme onedark
colorscheme dracula
"colorscheme deus

"--------------------------------------------------
" Keymaps
"--------------------------------------------------
let mapleader=","
" noremap ; :


" Make basic movements work better with wrapped lines
nnoremap j gj
nnoremap gj j
nnoremap k gk
nnoremap gk k

"inoremap ek <Esc>

" Save & Quit
nnoremap Q :q<cr>
nnoremap <C-q> :qa<cr>
nnoremap S :w<cr>

" copy to end of line
nnoremap Y y$
" copy to system clipboard
vnoremap Y "+y

" indent
nnoremap < <<
nnoremap > >>

" jumplist

nnoremap <C-y> <C-i>

"-------------------------------------------------- 
" buffer
"-------------------------------------------------- 

nnoremap <space><space> :b
nnoremap = :bnext<cr>
nnoremap - :bprev<cr>

"close current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT
"close all buffers
map <leader>ba :bufdo bd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction
"-------------------------------------------------- 
" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"-------------------------------------------------- 

" Select entire line (minus EOL) with 'vv', entire file (characterwise) with 'VV'
xnoremap <expr> V mode() ==# "V" ? "gg0voG$h" : "V"
" ! select this line from cursor
xnoremap <expr> v mode() ==# "v" ? "$h" : "v"

" disable current highlight
noremap <leader><cr> :nohlsearch<cr>

" find two same words/chars adjacent
noremap <leader>dw /\(\<\w\+\>\)\_s*\1

" movement
nnoremap <silent> U 5k
nnoremap <silent> E 5j
nnoremap <silent> W 5w
nnoremap <silent> B 5b

" H: goto the start of this line
nnoremap <silent> H 0
" L: goto the end of this line
nnoremap <silent> L $

" move the screen without move the cursor
noremap <C-U> 5<C-y>
noremap <C-E> 5<C-e>

" insert mode: move to end
"inoremap <C-l> <Esc>A
" insert mode: move to start
"inoremap <C-h> <Esc>I

" command mode: move cursor
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>

"-------------------------------------------------- 
" split screen
" Disable the default s key
noremap s <nop>

" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
noremap sk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap sj :set splitbelow<CR>:split<CR>
noremap sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap sl :set splitright<CR>:vsplit<CR>

" Resize splits with arrow keys
nnoremap <up> :res +5<CR>
nnoremap <down> :res -5<CR>
nnoremap <left> :vertical resize-5<CR>
nnoremap <right> :vertical resize+5<CR>

" Place the two screens up and down
noremap su <C-w>t<C-w>K
" Place the two screens side by side
noremap sv <C-w>t<C-w>H

" Rotate screens
noremap srh <C-w>b<C-w>K
noremap srv <C-w>b<C-w>H

" move other window
nnoremap <M-n> <Esc><C-w>w5<C-e><C-w>w
nnoremap <M-p> <Esc><C-w>w5<C-y><C-w>w 

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-=> mz:m+<cr>`z
nmap <M--> mz:m-2<cr>`z
vmap <M-=> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M--> :m'<-2<cr>`>my`<mzgv`yo`z
"-------------------------------------------------- 
"switch IME(输入法)
"友好的中文输入法
"-------------------------------------------------- 

" Press <leader> + q to close the window below the current window or any
" window
"noremap <leader>q <C-w>j:q<CR>

"augroup SmartIME
"autocmd! InsertLeave *
    "\ silent call moz#SmartIME('0x0409')|
    "\ set relativenumber

"autocmd! FocusGained *
    "\ if mode(1)!='i' && mode(1)!='Rv' && mode(1)!=#'R'|
    "\    echom mode(1)|
    "\    silent call moz#SmartIME('0x0804')|
    "\ endif|
    "\ set norelativenumber
"augroup END

" map <esc> to escape and change to english ime
inoremap <silent> <Esc> <Esc>:<C-u><C-r>=printf("silent call moz#SmartIME('0x0409')")<cr><cr>

noremap c <nop>
nnoremap ci :silent call moz#SmartIME('0x0804')<cr>i
nnoremap cI :silent call moz#SmartIME('0x0804')<cr>I
nnoremap co :silent call moz#SmartIME('0x0804')<cr>o
nnoremap cO :silent call moz#SmartIME('0x0804')<cr>o
nnoremap ca :silent call moz#SmartIME('0x0804')<cr>a
nnoremap cA :silent call moz#SmartIME('0x0804')<cr>A

"open help
nnoremap <leader>ih :silent call moz#Help()<cr>

"-------------------------------------------------- 
"  Tab management
"-------------------------------------------------- 
" Create a new tab with tn
noremap tn :tabe<CR>
noremap tc :tabclose<CR>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
noremap te :tabedit <C-r>=expand("%:p:h")<cr>\

" Move around tabs with th and tl
" left
noremap th :-tabnext<CR>
" right
noremap tl :+tabnext<CR>

" Move the tabs with tmh and tml
noremap tmh :-tabmove<CR>
noremap tml :+tabmove<CR>

" Let 'tk' toggle between this and the last accessed tab
let g:lasttab = 1
nmap tk :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

"-------------------------------------------------- 

nnoremap M :setlocal relativenumber!<cr>
nnoremap <leader>w :set wrap!<cr>

" Folding
" nnoremap <leader>o za

" Open up lazygit
noremap \g :term lazygit<CR>
noremap <leader>gi :tabe<CR>:-tabmove<CR>:term lazygit<CR>


" copy and paste
inoremap <C-d> <Esc>:call moz#Duplicate_line()<cr>a
" "_ register: black hole register
nnoremap <M-d> "_d
xnoremap <M-d> "_d

" copy current file's whole path
nnoremap <leader>yp :let @+ = expand("%:p")<cr>

imap <C-v>  <C-R>+
cmap <C-v>     <C-R>+
vmap <C-c>  "+y
imap <silent> <S-Insert> <Esc>"+pa
cmap <S-Insert>     <C-R>+
vnoremap <C-Insert> "+y

"vnoremap <BS> d

" open in explorer
if s:iswindows
    " 打开当前目录 windows
    map <leader>xx :!start explorer %:p:h<CR>
    "" 打开当前目录CMD
    "map \d :!start<cr>
endif

" 在分割窗口之间移动
nmap <M-h> <C-w>h
nmap <M-j> <C-w>j
nmap <M-k> <C-w>k
nmap <M-l> <C-w>l

"inoremap <M-h> <C-\><C-N><C-w>h
"inoremap <M-j> <C-\><C-N><C-w>j
"inoremap <M-k> <C-\><C-N><C-w>k
"inoremap <M-l> <C-\><C-N><C-w>l

" always split windows vertically
set splitright
set diffopt+=vertical
silent! set splitvertical
if v:errmsg != ''
  cabbrev hv vert help
endif

" terminal
tnoremap <Esc> <C-\><C-n>
tnoremap <C-o> <C-\><C-n><C-O>
tnoremap <M-h> <C-\><C-N><C-w>h
tnoremap <M-j> <C-\><C-N><C-w>j
tnoremap <M-k> <C-\><C-N><C-w>k
tnoremap <M-l> <C-\><C-N><C-w>l
map <leader>tt :call moz#Term()<cr>
au TermOpen * startinsert
" nnoremap \t :tabe<cr>:-tabmove<cr>:term sh -c 'st'<cr><C-\><C-N>:q<cr>

" if has('windows')
"     set shell=D:\cmder\cmder_shell.bat
"     set shellpipe=|
"     set shellredir=>
" endif

" Opening a terminal window
noremap <LEADER>/ :set splitbelow<CR>:split<CR>:res +10<CR>:term<CR>

" Press <leader> twice to jump to the next '<++>' and edit it
"noremap <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4l

" Spelling Check with <space>sc
"noremap <LEADER>sc :set spell!<CR>

" Call figlet
if !has('win32') && !has('win64')
    noremap tx :r !figlet
endif

" location list
noremap <leader>- :lN<cr>
noremap <leader>= :lne<cr>

" find and replace something
noremap \s :%s//g<left><left>

" Compile function
noremap \r :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
    exec "!g++ % -o %<"
    exec "!time ./%<"
    elseif &filetype == 'cpp'
    set splitbelow
    exec "!g++ -std=c++11 % -Wall -o %<"
    :sp
    :res -15
    :term ./%<
    elseif &filetype == 'java'
    exec "!javac %"
    exec "!time java %<"
    elseif &filetype == 'sh'
    :!time bash %
    elseif &filetype == 'python'
    call moz#Run_Python_Complicate()
    elseif &filetype == 'html'
    silent! exec "!".g:mkdp_browser." % &"
    elseif &filetype == 'markdown'
    exec "MarkdownPreview"
    elseif &filetype == 'tex'
    silent! exec "VimtexStop"
    silent! exec "VimtexCompile"
    elseif &filetype == 'dart'
    CocCommand flutter.run
    elseif &filetype == 'go'
    set splitbelow
    :sp
    :term go run .
    endif
endfunc


"--------------------------------------------------
"--------------------------------------------------
"  Markdown Settings
"--------------------------------------------------
"--------------------------------------------------

"if s:iswindows
    "execute 'source ' . $MOZ_CONFIG . '\md_keymaps.vim'
"endif

""auto spell
"autocmd BufRead,BufNewFile *.md setlocal spell
if s:iswindows
    noremap \m :!"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" "%:p"
endif


"--------------------------------------------------
"--------------------------------------------------
"  vimtex 设置
"--------------------------------------------------
"--------------------------------------------------

let g:tex_flavor                          = 'latex'
let g:tex_indent_brace = 0
let g:tex_indent_items = 0
let g:tex_indent_and = 0
let g:vimtex_indent_enabled = 0
let g:vimtex_indent_on_ampersands = 0
let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \   '-xelatex',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}
let g:vimtex_quickfix_mode             = 2
let g:vimtex_quickfix_autoclose_after_keystrokes = 1
let g:vimtex_quickfix_open_on_warning  = 0
let g:vimtex_fold_manual               = 1
let g:vimtex_view_general_viewer          = 'SumatraPDF'
let g:vimtex_view_general_options         = '-reuse-instance -inverse-search "\"' . $VIMRUNTIME . '\gvim.exe\" -n --remote-silent +\%l \"\%f\"" -forward-search @tex @line @pdf'
let g:vimtex_view_general_options_latexmk = '-reuse-instance'

nmap <leader>l :VimtexView<cr>
"

"--------------------------------------------------
"--------------------------------------------------
"  Vista.vim
"--------------------------------------------------
"--------------------------------------------------

noremap <silent> T :Vista!!<CR>
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'ctags'
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }
function! NearestMethodOrFunction() abort
	return get(b:, 'vista_nearest_method_or_function', '')
endfunction
set statusline+=%{NearestMethodOrFunction()}
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()



"--------------------------------------------------
"--------------------------------------------------
"  NERDTree
"--------------------------------------------------
"--------------------------------------------------

" 进入工作目录
"if s:iswindows
    "autocmd VimEnter * NERDTree D:\mozli\Documents\github\
"endif

"autocmd VimEnter * call moz#ChangeDirGithub()

" " 当打开 NERDTree 窗口时，自动显示 Bookmarks
let NERDTreeShowBookmarks=1
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
" " 打开编辑器时，光标在右侧窗口
wincmd w
autocmd VimEnter * wincmd w
" " 只有 NERDTree 窗口时退出
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" " 关闭NERDTree快捷键
map <F8> :NERDTreeToggle<cr>
map <F7> :NERDTreeFromBookmark<space>
map <F6> :Startify<cr>

" change the working directory and print out after changing
nnoremap <leader>cd :cd %:p:h<cr>:pwd<cr>
let NERDTreeMapOpenVSplit='v'

" Auto change directory to current dir
"autocmd BufEnter * silent! lcd %:p:h
"
" change the dir of nerdtree and move back the cursor
" autocmd BufEnter * if &modifiable | NERDTreeFind | wincmd p | endif

noremap <M-o> :call moz#Change_nerdtree_dir()<cr>
" returns true iff is NERDTree open/active
" function! IsNTOpen()       
"   return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
" endfunction
"
" " calls NERDTreeFind iff NERDTree is active, current window contains a modifiable file, and we're not in vimdiff
" function! SyncTree()
"   if &modifiable && rc:IsNTOpen() && strlen(expand('%')) > 0 && !&diff
"     NERDTreeFind
"     wincmd p
"   endif
" endfunction
"
" autocmd BufEnter * call SyncTree()

"--------------------------------------------------
"--------------------------------------------------
"  UltiSnips
"--------------------------------------------------
"--------------------------------------------------
if !has('python3')
    let g:UltiSnipsUsePythonVersion = 2
else
    let g:UltiSnipsUsePythonVersion = 3
endif

" should set ExpandTrigger: coc will use <tab>
let g:UltiSnipsExpandTrigger = '<M-i>'
let g:UltiSnipsJumpForwardTrigger = '<M-i>'
"let g:UltiSnipsJumpBackwardTrigger = '<M-o>'
"let g:UltiSnipsListSnippets = '<M-c>'
let g:UltisnipsEditSplit = 'vertical'
let g:UltiSnipsSnippetDirectories = [$MOZ_CONFIG.'\UltiSnips','UltiSnips']
nnoremap <leader>ss :UltiSnipsEdit!<cr>
nnoremap <leader>sr :call UltiSnips#RefreshSnippets()<CR>

""" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#fnametruncate = 16
let g:airline#extensions#tabline#fnamecollapse = 2
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#coc#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_section_b = '%-0.30{getcwd()}'
let g:airline_section_c = '%t'

"--------------------------------------------------
"--------------------------------------------------
"  ctrlp Settings
"--------------------------------------------------
"--------------------------------------------------
"let g:ctrlp_map = '<C-P>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_cmd = 'CtrlPMRU'

"--------------------------------------------------
"--------------------------------------------------
"  LeaderF Settings
"--------------------------------------------------
"--------------------------------------------------
" before nvim-0.4.2, leaderF dont support popupmenu.
"if has("nvim-0.4.2")
    "let g:Lf_PreviewInPopup = 1
    "let g:Lf_WindowPosition = 'popup'
    "let g:Lf_PreviewPopupWidth = 300
"endif

let g:Lf_ReverseOrder = 1
let g:Lf_PreviewHorizontalPosition = 'right'
let g:Lf_StlSeparator = { 'left': '►', 'right': '◄', 'font': '' }

let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'AFc'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim/cache')
" let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
" let g:Lf_StlColorscheme = 'powerline'
"let g:Lf_PreviewResult = {'File': 1, 'Buffer': 1, 'Mru':1, 'Colorscheme':1, 'Function':1, 'BufTag':1, 'Gtags':1}


if s:iswindows
    " autocomplete in command
    cnoremap 'd LeaderfFile D:\mozli\Documents\GitHub
endif

cnoremap 'f LeaderfFile
map <leader>h :LeaderfHelp<cr>

let g:Lf_ShortcutF = '<C-k>'
noremap <leader>b  :LeaderfBuffer<cr>
noremap <leader>m  :LeaderfMru<cr>
noremap <leader>f  :LeaderfFunction!<cr>
noremap <leader>n  :LeaderfBufTag<cr>

let g:Lf_NormalMap = {
             \ "File": [["u", 'exec :LeaderfFile .. <cr>']]
\}

" let g:Lf_CommandMap = {'<C-]>':['<CR>']}

" search word under cursor, the pattern is treated as regex, and enter normal mode directly
noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>

" search word under cursor, the pattern is treated as regex,
" append the result to previous search results.
noremap <C-G> :<C-U><C-R>=printf("Leaderf! rg --append -e %s ", expand("<cword>"))<CR>

" search word under cursor literally only in current buffer
noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg -F --current-buffer -e %s ", expand("<cword>"))<CR>

" search visually selected text literally, don't quit LeaderF after accepting an entry
"xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F --stayOpen -e %s ", leaderf#Rg#visual())<CR>

" recall last search. If the result window is closed, reopen it.
noremap go :<C-U>Leaderf! rg --recall<CR>

" should use `Leaderf gtags --update` first
"let g:Lf_GtagsAutoGenerate = 1
"let g:Lf_Gtagslabel = 'native-pygments'

" keybindings
"noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
"noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>

"--------------------------------------------------
"--------------------------------------------------
"  Gtags Settings
"--------------------------------------------------
"--------------------------------------------------
"let $GTAGSLABEL = 'native-pygments'

"if s:iswindows
    "let $GTAGSCONF = 'D:\Program Files\gtags663\share\gtags\gtags.conf'
"endif

"" gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
"let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

"" 所生成的数据文件的名称
"let g:gutentags_ctags_tagfile = '.tags'

"" 同时开启 ctags 和 gtags 支持：
"let g:gutentags_modules = []
"if executable('ctags')
    "let g:gutentags_modules += ['ctags']
"endif
"if executable('gtags-cscope') && executable('gtags')
    "let g:gutentags_modules += ['gtags_cscope']
"endif

"" 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
"let g:gutentags_cache_dir = expand('~/.cache/tags')

"" 配置 ctags 的参数，老的 Exuberant-ctags 不能有 --extra=+q，注意
"let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
"let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
"let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

"" 如果使用 universal ctags 需要增加下面一行，老的 Exuberant-ctags 不能加下一行
"let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

"" 禁用 gutentags 自动加载 gtags 数据库的行为
"let g:gutentags_auto_add_gtags_cscope = 0


"--------------------------------------------------
"--------------------------------------------------
"  vim-wiki
"--------------------------------------------------
"--------------------------------------------------

if s:iswindows
let g:vimwiki_list = [{'path': $MOZ_GITHUB . '\Drafts\Notes_PC\',
\                      'diary_rel_path': 'Diary\', 'syntax': 'markdown', 'ext': '.md'},
\                    ]
endif

"let g:vimwiki_diary_rel_path = {'type': type(''), 'default': '\Diary\', 'min_length': 1}
let g:vimwiki_use_calendar = 1
let g:vimwiki_global_ext = 0
"autocmd FileType vimwiki map \c :call ToggleCalendar()<cr>
"autocmd FileType vimwiki :set filetype=markdown.pandoc
"augroup vimwiki
    "autocmd!
    "autocmd FileType vimwiki inoremap <expr> <M-e> vimwiki#tbl#kbd_tab()
    ""autocmd FileType vimwiki :set filetype=markdown
"augroup end

let g:vimwiki_key_mappings =
    \ {
    \ 'table_mappings': 0,
    \ 'headers': 0
    \ }

"--------------------------------------------------
"--------------------------------------------------
"  CoC Settings
"--------------------------------------------------
"--------------------------------------------------
let g:coc_global_extensions = ['coc-word','coc-python','coc-yank','coc-json','coc-tsserver']
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
" 绑定 ctrl-space 触发补全
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <M-F>  <Plug>(coc-format-selected)
nmap <M-F>  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
"set statusline^=%{coc#status()}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" CocList Yank
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nnoremap <C-c> :CocCommand<cr>


"--------------------------------------------------
"--------------------------------------------------
"  vim-fugitive
"--------------------------------------------------
"--------------------------------------------------

nnoremap <leader>gcc :Gcommit<cr>
nnoremap <leader>gca :Gcommit -a -v<cr>
nnoremap <leader>gcm :Gcommit --amend<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gl :Git log --pretty=format:'%h %ad <%an> -%d %s' --date=short<cr>
nnoremap <leader>gn :GMove

"--------------------------------------------------
"--------------------------------------------------
"  GitGutter Settings
"--------------------------------------------------
"--------------------------------------------------

map <leader>ggt :GitGutterToggle " 切换是否开启 vim-gitgutter
" set the default value of updatetime to 100ms
set updatetime=100
let g:gitgutter_max_signs = 800
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
nmap <leader>ga <Plug>(GitGutterStageHunk)
nmap <leader>gr <Plug>(GitGutterUndoHunk)
nmap <leader>gv <Plug>(GitGutterPreviewHunk)


"--------------------------------------------------
"--------------------------------------------------
"  vim-repl
"--------------------------------------------------
"--------------------------------------------------
let g:repl_program = {
        \   'python': 'ipython',
        \   'default': 'zsh',
        \   'r': 'R',
        \   'lua': 'lua',
        \   }
let g:repl_predefine_python = {
        \   'numpy': 'import numpy as np',
        \   'matplotlib': 'from matplotlib import pyplot as plt'
        \   }
let g:repl_cursor_down = 1
let g:repl_python_automerge = 1
let g:repl_ipython_version = '7'
nnoremap <leader>r :REPLToggle<Cr>
autocmd Filetype python nnoremap <F12> <Esc>:REPLDebugStopAtCurrentLine<Cr>
autocmd Filetype python nnoremap <F10> <Esc>:REPLPDBN<Cr>
autocmd Filetype python nnoremap <F11> <Esc>:REPLPDBS<Cr>
let g:repl_position = 3
" let g:repl_width = None            " 窗口宽度
" let g:repl_height = None           " 窗口高度
let g:sendtorepl_invoke_key = "<leader>w"      " 传送代码快捷键，默认为<leader>w
let g:repl_position = 0                " 0表示出现在下方，1表示出现在上方，2在左边，3在右边
let g:repl_stayatrepl_when_open = 0        " 打开REPL时是回到原文件（1）还是停留在REPL窗口中（0）


nmap <leader>v :call moz#Source()<cr>
nmap <leader>e :e $MOZ_NVIMRC<cr>


"--------------------------------------------------
"--------------------------------------------------
"  MarkdownPreview
"--------------------------------------------------
"--------------------------------------------------
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
            \ 'mkit': {},
            \ 'katex': {},
            \ 'uml': {},
            \ 'maid': {},
            \ 'disable_sync_scroll': 0,
            \ 'sync_scroll_type': 'middle',
            \ 'hide_yaml_meta': 1
            \ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'


"--------------------------------------------------
"--------------------------------------------------
"  markdown-pandoc-syntax
"--------------------------------------------------
"--------------------------------------------------
"augroup pandoc_syntax
    "au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
"augroup END

" vim-auto-save
let g:auto_save = 1
let g:auto_save_silent = 1
let g:auto_save_events = ["CursorHold", "InsertLeave"]
set updatetime=1000

"--------------------------------------------------
"--------------------------------------------------
"  vim-table-mode
"--------------------------------------------------
"--------------------------------------------------
noremap <LEADER>tm :TableModeToggle<CR>
"let g:table_mode_disable_mappings = 1
let g:table_mode_cell_text_object_i_map = 'i<Bar>'


"--------------------------------------------------
"--------------------------------------------------
"  Undotree
"--------------------------------------------------
"--------------------------------------------------
noremap <M-u> :UndotreeToggle<CR>
let g:undotree_DiffAutoOpen = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
let g:undotree_WindowLayout = 2
let g:undotree_DiffpanelHeight = 8
let g:undotree_SplitWidth = 24
function g:Undotree_CustomMap()
    nmap <buffer> u <plug>UndotreeNextState
    nmap <buffer> e <plug>UndotreePreviousState
    nmap <buffer> U 5<plug>UndotreeNextState
    nmap <buffer> E 5<plug>UndotreePreviousState
endfunc

" ===
" === vim-bookmarks
" ===
let g:bookmark_no_default_key_mappings = 1
nmap mt <Plug>BookmarkToggle
nmap ma <Plug>BookmarkAnnotate
nmap ml <Plug>BookmarkShowAll
nmap mn <Plug>BookmarkNext
nmap mp <Plug>BookmarkPrev
nmap mC <Plug>BookmarkClear
nmap mX <Plug>BookmarkClearAll
nmap mu <Plug>BookmarkMoveUp
nmap me <Plug>BookmarkMoveDown
"nmap <Leader>g <Plug>BookmarkMoveToLine
let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1
let g:bookmark_highlight_lines = 1
let g:bookmark_manage_per_buffer = 1
let g:bookmark_save_per_working_dir = 1
let g:bookmark_center = 1
let g:bookmark_auto_close = 1
let g:bookmark_location_list = 1


" ==
" == vim-multiple-cursor
" ==
"let g:multi_cursor_use_default_mapping = 0
"let g:multi_cursor_start_word_key = '<c-k>'
"let g:multi_cursor_select_all_word_key = '<a-k>'
"let g:multi_cursor_start_key = 'g<c-k>'
"let g:multi_cursor_select_all_key = 'g<a-k>'
"let g:multi_cursor_next_key = '<c-k>'
"let g:multi_cursor_prev_key = '<c-p>'
"let g:multi_cursor_skip_key = '<C-s>'
"let g:multi_cursor_quit_key = '<Esc>'


" ===
" === vim-visual-multi
" ===
"let g:VM_theme         = 'iceblue'
"let g:VM_default_mappings = 0
let g:VM_leader = {'default': '`', 'visual': '`', 'buffer': '`'}
let g:VM_maps = {}
let g:VM_custom_motions  = {'n': 'h', 'i': 'l', 'u': 'k', 'e': 'j', 'N': '0', 'I': '$', 'h': 'e'}
let g:VM_maps['i']     = 'k'
let g:VM_maps['I']     = 'K'
let g:VM_maps['Find Under']     = '<C-d>'
let g:VM_maps['Find Subword Under'] = '<C-d>'
let g:VM_maps['Find Next']     = ''
let g:VM_maps['Find Prev']     = ''
let g:VM_maps['Remove Region'] = 'q'
let g:VM_maps['Skip Region'] = ''
let g:VM_maps["Undo"]      = 'l'
let g:VM_maps["Redo"]      = '<C-r>'


" ===
" === Far.vim
" ===
noremap <space>f :F 
let g:far#enable_undo = 1
let g:far#mapping = {
        \ "replace_undo" : ["l"],
        \ }


" ===
" === Bullets.vim
" ===
"let g:bullets_set_mappings = 0
let g:bullets_enabled_file_types = [
            \ 'markdown',
            \ 'text',
            \ 'gitcommit',
            \ 'scratch'
            \]



" ===
" === vim-easymotion
" ===
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_do_shade = 0
let g:EasyMotion_smartcase = 1
map ' <Plug>(easymotion-bd-f)
nmap ' <Plug>(easymotion-bd-f)
"map E <Plug>(easymotion-j)
"map U <Plug>(easymotion-k)
"nmap f <Plug>(easymotion-overwin-f)
"map \; <Plug>(easymotion-prefix)
"nmap ' <Plug>(easymotion-overwin-f2)
"map 'l <Plug>(easymotion-bd-jk)
"nmap 'l <Plug>(easymotion-overwin-line)
"map  'w <Plug>(easymotion-bd-w)
"nmap 'w <Plug>(easymotion-overwin-w)


"--------------------------------------------------
"--------------------------------------------------
"  vim-pencil
"--------------------------------------------------
"--------------------------------------------------
"
"let g:pencil#wrapModeDefault = 'hard'
"let g:pencil#conceallevel = 0
"let g:pencil#textwidth = 99
"let g:pencil#map#suspend_af = 'P'
"let g:pencil#autoformat = 1

"--------------------------------------------------
"--------------------------------------------------
"  goyo
"--------------------------------------------------
"--------------------------------------------------

" ===
map <LEADER>gy :Goyo<CR>
let g:goyo_width = 125
"autocmd! User GoyoEnter call zenroom2#Zenroom_goyo_before()
"autocmd! User GoyoLeave call zenroom2#Zenroom_goyo_after()

"let g:goyo_callbacks = [ function('s:zenroom_goyo_before'), function('s:zenroom_goyo_after') ]

"--------------------------------------------------
"--------------------------------------------------
"  fastfold
"--------------------------------------------------
"--------------------------------------------------
nmap zuz <Plug>(FastFoldUpdate)
let g:fastfold_savehook = 1
let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
let g:fastfold_fold_movement_commands = [']z', '[z', 'ze', 'zu']
let g:markdown_folding = 1
let g:tex_fold_enabled = 1
let g:vimsyn_folding = 'af'
let g:xml_syntax_folding = 1
let g:javaScript_fold = 1
let g:sh_fold_enabled= 7
let g:ruby_fold = 1
let g:perl_fold = 1
let g:perl_fold_blocks = 1
let g:r_syntax_folding = 1
let g:rust_fold = 1
let g:php_folding = 1


" ===
" === vim-easy-align
" ===
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)


" ===
" === vim-after-object
" ===
autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ')


" ===
" === vim-markdown-toc
" ===
"let g:vmt_auto_update_on_save = 0
"let g:vmt_dont_insert_fence = 1
let g:vmt_cycle_list_item_markers = 1
let g:vmt_fence_text = 'TOC'
let g:vmt_fence_closing_text = '/TOC'

" ===
" === vim-subversive
" ===
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)

"--------------------------------------------------
"--------------------------------------------------
"  vim-markdown
"--------------------------------------------------
"--------------------------------------------------
let g:vim_markdown_no_default_key_mappings = 1
let g:tex_conceal = ""
let g:vim_markdown_math = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_conceal = 0



"--------------------------------------------------
"--------------------------------------------------
"  vim-calendar
"--------------------------------------------------
"--------------------------------------------------
noremap \c :Calendar -view=year -position=right -width=27 -split=vertical<CR>
noremap \\ :Calendar -view=day -position=right -width=50 -split=vertical<CR>
let g:calendar_first_day = "monday"
let g:calendar_views = ['day_3','week','month','year','clock','day']
let g:calendar_cyclic_view = 1
"let g:calendar_google_calendar = 1
"let g:calendar_google_task = 1

if s:iswindows
    let s:calendar_cache_directory = substitute($USERPROFILE . '\.cache\calendar.vim','\\','\\\\','g')
endif

augroup calendar-mappings
    autocmd!
    autocmd FileType calendar nmap <buffer> k <Plug>(calendar_up)
    autocmd FileType calendar nmap <buffer> h <Plug>(calendar_left)
    autocmd FileType calendar nmap <buffer> j <Plug>(calendar_down)
    autocmd FileType calendar nmap <buffer> l <Plug>(calendar_right)
    autocmd FileType calendar nmap <buffer> t <Plug>(calendar_today)

    autocmd FileType calendar nmap <buffer> i <Plug>(calendar_start_insert)
    autocmd FileType calendar nmap <buffer> E <Plug>(calendar_event)
    autocmd FileType calendar nmap <buffer> L <Plug>(calendar_clear)

    " unmap <C-n>, <C-p> for other plugins
    autocmd FileType calendar nunmap <buffer> <C-n>
    autocmd FileType calendar nunmap <buffer> <C-p>
    autocmd FileType calendar nmap <buffer> <CR> :<C-u>call vimwiki#diary#calendar_action(b:calendar.day().get_day(), b:calendar.day().get_month(), b:calendar.day().get_year(), b:calendar.day().week(), "V")<CR>
augroup END

" credentials
if s:iswindows
    execute 'source C:\Users\GRC\.cache\calendar.vim\credentials.vim'
endif

"--------------------------------------------------
"--------------------------------------------------
"  vim-capslock
"--------------------------------------------------
"--------------------------------------------------

imap <leader>ie <C-O><Plug>CapsLockToggle

"--------------------------------------------------
"--------------------------------------------------
"  vim-textobj-user
"--------------------------------------------------
"--------------------------------------------------

" define TEX \left( \right) object
call textobj#user#plugin('tex', {
\   'paren-math': {
\     'pattern': ['\\left(', '\\right)'],
\     'select-a': [],
\     'select-i': [],
\   },
\ })

augroup tex_textobjs
  autocmd!
  autocmd FileType tex call textobj#user#map('tex', {
  \   'paren-math': {
  \     'select-a': '<buffer> a(',
  \     'select-i': '<buffer> i(',
  \   },
  \ })
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" THIS IS SOME CODE BACKUP
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" this one fix the runtime error R6034 error. ref:
" https://stackoverflow.com/questions/14552348/runtime-error-r6034-in-embedded-python-application/34989113#34989113
"
" how: fix $PATH, find which path has 'msvcr\d\d.dll',
" and then remove the path.
"python << EOF
"import os, re
"path = os.environ['PATH'].split(';')

"def is_problem(folder):
    "try:
        "for item in os.listdir(folder):
            "if re.match(r'msvcr\d\d\.dll', item):
                "return True
    "except:
        "pass
    "return False

"path = [folder for folder in path if not is_problem(folder)]
"os.environ['PATH'] = ';'.join(path)
"with open('D:\Downloads\Temp\path.txt', 'w') as f:
    "f.write(path)
"EOF
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:gutentags_define_advanced_commands = 1


