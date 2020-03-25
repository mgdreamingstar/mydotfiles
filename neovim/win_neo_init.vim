"
"                            _
"  _ __ ___   ___ ______   _(_)_ __ ___  _ __ ___ 
" | '_ ` _ \ / _ \_  /\ \ / / | '_ ` _ \| '__/ __|
" | | | | | | (_) / /  \ V /| | | | | | | | | (__ 
" |_| |_| |_|\___/___|  \_/ |_|_| |_| |_|_|  \___|
"

" Author: @moz

" FIRST_of_ALL:
"
    " 1. set $MOZ_CONFIG $MOZ_VIMRC 
    " 2. run nvim with: `nvim --cmd \"source $MOZ_VIMRC\"` 
            " As vimrc comment, escaped \"; in shell don't escape \"

" Need_Todo:
"
    " set $MOZ_GITHUB \ $MOZ_PYTHON3
    " set backupdir
    " set directory (tmp folder)
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
"   - /AppData/Local/nvim/tmp 
"   - ~/.config/nvim/tmp
"
" plug.vim: Curl: nutstore | github ---> Set 
" plugged
" md_keymaps


" platform settings             
if has('win32') || has('win64') || has('win16') || has('win95')

    let s:iswindows = 1
    let s:islinux = 0
    let s:plug_vim = fnameescape($MOZ_CONFIG . '\autoload\plug.vim')
    let s:plugged_folder = fnameescape($MOZ_CONFIG . '\plugged')
    let s:mydotfiles = fnameescape($MOZ_GITHUB . '\mydotfiles\neovim')
    let s:backup = fnameescape($MOZ_CONFIG . '\moz_tmp\backup')
    let s:tmp = fnameescape($MOZ_CONFIG . '\moz_tmp\tmp')

else

    let s:islinux = 1
    let s:iswindows = 0
    let s:plug_vim = fnameescape($MOZ_CONFIG . '/autoload/plug.vim')
    let s:plugged_folder = fnameescape($MOZ_CONFIG . '/plugged')
    let s:mydotfiles = fnameescape($MOZ_GITHUB . '/mydotfiles/neovim')
    let s:backup = fnameescape($MOZ_CONFIG . '/moz_tmp/backup')
    let s:tmp = fnameescape($MOZ_CONFIG . '/moz_tmp/tmp')

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

if empty(glob(expand(s:plug_vim)))
    
    echom 'there is no plug_vim:'.s:plug_vim
    
    try
    
        echom 'not found plug.vim, curling form github'
        " if download speed < 1 Bytes/s for 5s, then close connection
        exec '!curl -Lo ' . expand(s:plug_vim) . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim --speed-time 3 --speed-limit 1000'

    catch 

        echom 'download failed, copying from GitHub/mydotfiles'

        if s:iswindows

            exec '!copy ' . expand(s:mydotfiles) . '\win_neo_autoload\plug.vim ' . expand(s:plug_vim)
            exec '!copy ' . expand(s:mydotfiles) . '\win_neo_autoload\moz.vim ' . $MOZ_CONFIG . '\autoload\moz.vim' 
            exec '!copy ' . expand(s:mydotfiles) . '\md_keymaps.vim ' . $MOZ_CONFIG . '\md_keymaps.vim'
            exec '!xcopy /E /I ' . expand(s:mydotfiles) . '\UltiSnips ' . $MOZ_CONFIG . '\UltiSnips'

        endif

        if s:islinux

            exec '!cp ' . expand(s:mydotfiles) . '\win_neo_autoload\plug.vim ' . expand(s:plug_vim)
            exec '!cp ' . expand(s:mydotfiles) . '\win_neo_autoload\moz.vim ' . $MOZ_CONFIG . '\autoload\moz.vim' 
            exec '!cp ' . expand(s:mydotfiles) . '\md_keymaps.vim ' . $MOZ_CONFIG . '\md_keymaps.vim'
            exec '!cp ' . expand(s:mydotfiles) . '\UltiSnips ' . $MOZ_CONFIG . '\UltiSnips'

        endif

        "echom 'not found plug.vim, curling from nutstore'
        "" if download speed < 1 Bytes/s for 5s, then close connection
        "exec '!curl -Lo ' . expand(s:plug_vim) . ' --create-dirs https://www.jianguoyun.com/p/DWplQswQq8qeCBil5vwC --speed-limit 5 --speed-limit 1'
    
    endtry

    " todo 
    " windows
    if s:iswindows
      
        echom 'make symlink from $MOZ_VIMRC to default init.vim'
        exec '!mklink ' . $USERPROFILE . ' AppData\Local\nvim\init.vim ' . $MOZ_VIMRC

    endif
      
    " linux
    if s:islinux
      
        echom 'make symlink from $MOZ_VIMRC to default init.vim'
        exec '!ln ' . $MOZ_VIMRC . ' ' . $VIM . ' /sysinit.vim'

    endif

    autocmd VimEnter * PlugInstall --sync | source $MOZ_VIMRC
endif


call plug#begin(s:plugged_folder)
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim', {'on': []}
Plug 'lervag/vimtex'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'altercation/vim-colors-solarized'
Plug 'mhartington/oceanic-next'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Yggdroot/LeaderF', { 'do': '.\install.bat' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'joshdick/onedark.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
"Plug 'ludovicchabant/vim-gutentags'
"Plug 'skywind3000/gutentags_plus'
Plug 'skywind3000/vim-preview'
Plug 'skywind3000/vim-quickui'
Plug 'airblade/vim-gitgutter'
" Plug 'terryma/vim-multiple-cursors'
Plug 'mg979/vim-visual-multi'
Plug 'machakann/vim-highlightedyank'
" Plug 'sillybun/vim-repl'
Plug 'tmhedberg/SimpylFold', { 'for' :['python', 'vim-plug'] }
Plug 'Vimjas/vim-python-pep8-indent', { 'for' :['python', 'vim-plug'] }
"Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for' :['python', 'vim-plug'] }
Plug 'tweekmonster/braceless.vim'

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install_sync() }, 'for' :['markdown', 'vim-plug'] }
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }
Plug 'mzlogin/vim-markdown-toc', { 'for': ['gitignore', 'markdown'] }
Plug 'theniceboy/bullets.vim'

" Editor Enhancement
"Plug 'Raimondi/delimitMate'
Plug 'scrooloose/nerdcommenter' " in <leader>cn to comment a line
Plug 'AndrewRadev/switch.vim' " gs to switch
Plug 'tpope/vim-surround' " type yskw' to wrap the word with '' or type cs'` to change 'word' to `word`
Plug 'gcmt/wildfire.vim' " in Visual mode, type k' to select all text in '', or type k) k] k} kp
Plug 'junegunn/vim-after-object' " da= to delete what's after =
Plug 'junegunn/vim-easy-align' " gaip= to align the = in paragraph, 
Plug 'tpope/vim-capslock' " Ctrl+L (insert) to toggle capslock
Plug 'easymotion/vim-easymotion'
Plug 'Konfekt/FastFold'
"Plug 'junegunn/vim-peekaboo'
"Plug 'wellle/context.vim'
Plug 'svermeulen/vim-subversive' 

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
"Plug 'mhinz/vim-startify'

" Vim Applications
Plug 'itchyny/calendar.vim'

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
Plug 'roxma/nvim-yarp'

call plug#end()


""" General Settings

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
set noswapfile  " don't use swap file
set number
set autochdir
set autoindent
set list  " show tab and other special chars
set listchars=tab:>-,trail:▫ 
set scrolloff=4
set viewoptions=cursor,folds
set indentexpr=
set foldmethod=indent
set foldlevel=99
set foldenable
set formatoptions-=tc
set splitright
set splitbelow
set noshowmode
set showcmd
set wildmenu
set smartcase
set inccommand=split
set completeopt=longest,noinsert,menuone,noselect,preview
set ttyfast  " make scroll faster
set lazyredraw  " faster redraw
set visualbell
set colorcolumn=80
set virtualedit=block

"let g:python_host_prog = 'D:\Anaconda\python'
let g:python3_host_prog = $MOZ_PYTHON3


" Or if you have Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif

" Theme
syntax enable
" colorscheme OceanicNext
" colorscheme onedark
colorscheme dracula


let mapleader=","
" noremap ; :
inoremap <Capslock> <Esc>

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

" disable current highlight
noremap <leader><cr> :nohlsearch<cr>

" find two same words/chars adjacent
noremap <leader>dw /\(\<\w\+\>\)\_s*\1

" movement
nnoremap <silent> U 5k
nnoremap <silent> E 5j
nnoremap <silent> W 5w
nnoremap <silent> B 5b

" N: goto the start of this line
nnoremap <silent> H 0
" I: goto the end of this line
nnoremap <silent> L $

" move the screen without move the cursor
noremap <C-U> 5<C-y>
noremap <C-E> 5<C-e>

" insert mode: move to end
inoremap <C-l> <Esc>A
" insert mode: move to start
inoremap <C-h> <Esc>I

" command mode: move cursor 
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right> 

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

" Press <leader> + q to close the window below the current window or any
" window
noremap <leader>q <C-w>j:q<CR> 

" ===
" === Tab management
" ===
" Create a new tab with tu
noremap tu :tabe<CR>

" Move around tabs with tn and ti
" left
noremap th :-tabnext<CR> 
" right
noremap tl :+tabnext<CR>

" Move the tabs with tmn and tmi
noremap tmh :-tabmove<CR>
noremap tml :+tabmove<CR>

nnoremap M :setlocal relativenumber!<cr>
nnoremap <leader>w :set wrap!<cr>

" Folding
" nnoremap <leader>o za

" Open up lazygit
noremap \g :term lazygit<CR>
noremap <c-k> :tabe<CR>:-tabmove<CR>:term lazygit<CR>

" Open up pudb
noremap <c-.> :tab sp<CR>:term python3 -m pudb %<CR>
"noremap <f5> :tab sp<CR>:term python3 -m pudb %<CR>
"
" copy and paste
inoremap <C-d> <Esc>:call moz#Duplicate_line()<cr>a
" copy current file's whole path
nnoremap <leader>pt :let @+ = expand("%:p")<cr>
imap <C-v>  <C-R>+ 
vmap <C-c>  "+y
imap <silent> <S-Insert> <Esc>"+pa
cmap <C-V>     <C-R>+
cmap <S-Insert>     <C-R>+
vnoremap <BS> d
vnoremap <C-C> "+y
vnoremap <C-Insert> "+y


" 在分割窗口之间移动
nmap <M-h> <C-w>h
nmap <M-j> <C-w>j
nmap <M-k> <C-w>k
nmap <M-l> <C-w>l

inoremap <M-h> <C-\><C-N><C-w>h
inoremap <M-j> <C-\><C-N><C-w>j
inoremap <M-k> <C-\><C-N><C-w>k
inoremap <M-l> <C-\><C-N><C-w>l

" always split windows vertically
set splitright
set diffopt+=vertical
silent! set splitvertical
if v:errmsg != ''
  cabbrev split vert split
  cabbrev hsplit split
  cabbrev help vert help
  noremap <C-w>] :vert botright wincmd ]<CR>
  noremap <C-w><C-]> :vert botright wincmd ]<CR>
else
  cabbrev hsplit hor split
endif

" terminal
tnoremap <Esc> <C-\><C-n>
tnoremap <C-o> <C-\><C-n><C-O>
tnoremap <M-h> <C-\><C-N><C-w>h
tnoremap <M-j> <C-\><C-N><C-w>j
tnoremap <M-k> <C-\><C-N><C-w>k
tnoremap <M-l> <C-\><C-N><C-w>l
map <leader>tt :vnew term://bash<cr>
au TermOpen * startinsert
" nnoremap \t :tabe<cr>:-tabmove<cr>:term sh -c 'st'<cr><C-\><C-N>:q<cr>

" if has('windows')
"     set shell=D:\cmder\cmder_shell.bat
"     set shellpipe=|
"     set shellredir=>
" endif

" Opening a terminal window
noremap <LEADER>/ :set splitbelow<CR>:split<CR>:res +10<CR>:term<CR>

" Press space twice to jump to the next '<++>' and edit it
noremap <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4l

" Spelling Check with <space>sc
noremap <LEADER>sc :set spell!<CR>

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
    set splitbelow
    :sp
    :term python3 %
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



" ===
" === Markdown Settings
" ===
" Snippets
if s:iswindows
  execute "source " . $MOZ_CONFIG . '\md_keymaps.vim'
endif
" auto spell
autocmd BufRead,BufNewFile *.md setlocal spell 



" NERDTree
" 进入工作目录
if s:iswindows
    autocmd VimEnter * NERDTree D:\mozli\Documents\github\
endif

" " 当打开 NERDTree 窗口时，自动显示 Bookmarks
let NERDTreeShowBookmarks=1
let NERDTreeShowHidden=1
" " 打开编辑器时，光标在右侧窗口
wincmd w
autocmd VimEnter * wincmd w
" " 只有 NERDTree 窗口时退出
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" " 关闭NERDTree快捷键
map <F8> :NERDTreeToggle<cr>

" change the working directory and print out after changing
nnoremap <leader>cd :cd %:p:h<cr>:pwd<cr>

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


"""  UltiSnips """""""""""""""""""""""""
if !has('python3')
    let g:UltiSnipsUsePythonVersion = 2
else
    let g:UltiSnipsUsePythonVersion = 3
endif

" should set ExpandTrigger: coc will use <tab>
let g:UltiSnipsExpandTrigger = '<M-m>'
let g:UltiSnipsJumpForwardTrigger = '<M-m>'
" let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsListSnippets = '<M-n>'
let g:UltiSnipsSnippetDirectories = [$MOZ_CONFIG.'\UltiSnips','UltiSnips']

""" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#fnametruncate = 16
let g:airline#extensions#tabline#fnamecollapse = 2
let g:airline#extensions#tabline#buffer_idx_mode = 1

""" ctrlp Settings
let g:ctrlp_map = '<C-P>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_cmd = 'CtrlPMRU'

""" LeaderF Settings
" before nvim-0.4.2, leaderF dont support popupmenu.
if has("nvim-0.4.2")
    let g:Lf_PreviewInPopup = 1
    let g:Lf_WindowPosition = 'popup'
    let g:Lf_PreviewPopupWidth = 300
endif

let g:Lf_PreviewHorizontalPosition = 'right'
let g:Lf_StlSeparator = { 'left': '►', 'right': '◄', 'font': '' }
 
let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'AFc'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim/cache')
" let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
" let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {'File': 1, 'Buffer': 1, 'Mru':1, 'Colorscheme':1, 'Function':1, 'BufTag':1, 'Gtags':1}


if s:iswindows
    " autocomplete in command 
    cnoremap 'ld1 LeaderfFile D:\mozli\Documents\GitHub
endif

cnoremap 'f LeaderfFile 
map <leader>h :LeaderfHelp<cr>

let g:Lf_ShortcutF = '<leader>ff'
noremap <leader>b  :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR> 
noremap <leader>m  :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR> 
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR> 
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
 
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

" search word under cursor literally in all listed buffers
noremap <C-D> :<C-U><C-R>=printf("Leaderf! rg -F --all-buffers -e %s ", expand("<cword>"))<CR>

" search visually selected text literally, don't quit LeaderF after accepting an entry
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F --stayOpen -e %s ", leaderf#Rg#visual())<CR>

" recall last search. If the result window is closed, reopen it.
noremap go :<C-U>Leaderf! rg --recall<CR>

" should use `Leaderf gtags --update` first
""" Gtag Settings
let $GTAGSLABEL = 'native-pygments'

if s:iswindows
    let $GTAGSCONF = 'D:\Program Files\gtags663\share\gtags\gtags.conf'
endif

let g:Lf_GtagsAutoGenerate = 1
let g:Lf_Gtagslabel = 'native-pygments'

" gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 同时开启 ctags 和 gtags 支持：
let g:gutentags_modules = []
if executable('ctags')
    let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
    let g:gutentags_modules += ['gtags_cscope']
endif

" 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let g:gutentags_cache_dir = expand('~/.cache/tags')

" 配置 ctags 的参数，老的 Exuberant-ctags 不能有 --extra=+q，注意
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 如果使用 universal ctags 需要增加下面一行，老的 Exuberant-ctags 不能加下一行
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

" 禁用 gutentags 自动加载 gtags 数据库的行为
let g:gutentags_auto_add_gtags_cscope = 0


" keybindings
noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>

""" CoC Settings
let g:coc_global_extensions = ['coc-pairs','coc-python','coc-snippets']
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
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

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

" coc-snippets settings
" " Use <C-l> for trigger snippet expand.
" imap <C-l> <Plug>(coc-snippets-expand)
" 
" " Use <C-j> for select text for visual placeholder of snippet.
" vmap <C-j> <Plug>(coc-snippets-select)
" 
" " Use <C-j> for jump to next placeholder, it's default of coc.nvim
" let g:coc_snippet_next = '<c-j>'
" 
" " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
" let g:coc_snippet_prev = '<c-k>'
" 
" " Use <C-j> for both expand and jump (make expand higher priority.)
" imap <C-j> <Plug>(coc-snippets-expand-jump)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

""" GitGutter Settings
map <leader>ggt :GitGutterToggle " 切换是否开启 vim-gitgutter
" set the default value of updatetime to 100ms
set updatetime=100
let g:gitgutter_max_signs = 800
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
nmap <leader>ha <Plug>(GitGutterStageHunk)
nmap <leader>hr <Plug>(GitGutterUndoHunk)
nmap <leader>hv <Plug>(GitGutterPreviewHunk)


""" vim-repl
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


nmap <leader>s :source $MOZ_VIMRC<cr>
nmap <leader>e :e $MOZ_VIMRC<cr>


" ===
" === MarkdownPreview
" ===
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


" ===
" === vim-table-mode
" ===
noremap <LEADER>tm :TableModeToggle<CR>
"let g:table_mode_disable_mappings = 1
let g:table_mode_cell_text_object_i_map = 'k<Bar>'



" ===
" === vim-bookmarks
" ===
let g:bookmark_no_default_key_mappings = 1
nmap mt <Plug>BookmarkToggle
nmap ma <Plug>BookmarkAnnotate
nmap ml <Plug>BookmarkShowAll
nmap mi <Plug>BookmarkNext
nmap mn <Plug>BookmarkPrev
nmap mC <Plug>BookmarkClear
nmap mX <Plug>BookmarkClearAll
nmap mu <Plug>BookmarkMoveUp
nmap me <Plug>BookmarkMoveDown
nmap <Leader>g <Plug>BookmarkMoveToLine
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
let g:VM_maps['Find Under']     = '<C-k>'
let g:VM_maps['Find Subword Under'] = '<C-k>'
let g:VM_maps['Find Next']     = ''
let g:VM_maps['Find Prev']     = ''
let g:VM_maps['Remove Region'] = 'q'
let g:VM_maps['Skip Region'] = ''
let g:VM_maps["Undo"]      = 'l'
let g:VM_maps["Redo"]      = '<C-r>'


" ===
" === Far.vim
" ===
noremap \f :F  **/*<left><left><left><left><left>
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


" ===
" === goyo
" ===
map <LEADER>gy :Goyo<CR>


" ===
" === fastfold
" ===
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



" ===
" === vim-calendar
" ===
noremap \c :Calendar -position=here<CR>
noremap \\ :Calendar -view=clock -position=here<CR>
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1
let g:calendar_debug = 1

if s:iswindows
    let s:calendar_cache_directory = $USERPROFILE . '\.cache\calendar.vim'
endif

augroup calendar-mappings
    autocmd!
    autocmd FileType calendar nmap <buffer> k <Plug>(calendar_up)
    autocmd FileType calendar nmap <buffer> h <Plug>(calendar_left)
    autocmd FileType calendar nmap <buffer> j <Plug>(calendar_down)
    autocmd FileType calendar nmap <buffer> l <Plug>(calendar_right)
    autocmd FileType calendar nmap <buffer> <c-k> <Plug>(calendar_move_up)
    autocmd FileType calendar nmap <buffer> <c-h> <Plug>(calendar_move_left)
    autocmd FileType calendar nmap <buffer> <c-j> <Plug>(calendar_move_down)
    autocmd FileType calendar nmap <buffer> <c-l> <Plug>(calendar_move_right)
    autocmd FileType calendar nmap <buffer> e <Plug>(calendar_start_insert)
    autocmd FileType calendar nmap <buffer> E <Plug>(calendar_start_insert_head)
    " unmap <C-n>, <C-p> for other plugins
    autocmd FileType calendar nunmap <buffer> <C-n>
    autocmd FileType calendar nunmap <buffer> <C-p>
augroup END

" credentials
if s:iswindows
    execute "source " . fnameescape(s:calendar_cache_directory) . '\credentials.vim'
endif 


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
