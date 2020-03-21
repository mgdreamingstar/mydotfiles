set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=C:\Users\grc\.vim
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Using a non-master branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" GRC's 
Plug 'kien/ctrlp.vim'
Plug 'lervag/vimtex'
Plug 'milkypostman/vim-togglelist'
" Plug 'vim-latex/vim-latex'

" Initialize plugin system
call plug#end()

" Bundle 'terryma/Vim-multiple-cursors'
" Bundle 'tpope/vim-fugitive'

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on
"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Startup {{{
filetype indent plugin on

" 
au VimEnter * lan time en
" 启动全屏
" au GUIEnter * simalt ~x

set mouse=a

" vim 文件折叠方式为 marker
" augroup ft_vim
"     au!
" 
"     au FileType vim setlocal foldmethod=marker
" augroup END

" 返回上次退出文件时光标位置
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
" }}}
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree 设置 {{{
" 在 vim 启动的时候默认开启 NERDTree（autocmd 可以缩写为 au）
" 并进入工作目录
autocmd VimEnter * NERDTree D:\grc\GitHub
" 当打开 NERDTree 窗口时，自动显示 Bookmarks
let NERDTreeShowBookmarks=1
" 打开编辑器时，光标在右侧窗口
wincmd w
autocmd VimEnter * wincmd w
" 只有 NERDTree 窗口时退出
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" 关闭NERDTree快捷键
map <F8> :NERDTreeToggle<CR>
map <F2> :exec("NERDTree ".expand('%:h'))<CR>
" 显示行号
let NERDTreeShowLineNumbers=1
let NERDTreeAutoCenter=1
" 是否显示隐藏文件
let NERDTreeShowHidden=1
" 设置宽度
let NERDTreeWinSize=31
" 打开文件后，关闭 NERDTree
let NERDTreeQuitOnOpen=1
" 在终端启动vim时，共享NERDTree
let g:nerdtree_tabs_open_on_console_startup=1
" 忽略一下文件的显示
let NERDTreeIgnore=['\.pyc','\~$','\.swp']
" 显示书签列表
let NERDTreeShowBookmarks=1
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CtrlP 设置 {{{
let g:ctrlp_map = ',,'
let g:ctrlp_cmd = 'CtrlPMRU'
" }}}
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vimtex 设置 {{{
let g:tex_flavor                          = 'latex'
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
" let g:vimtex_view_general_viewer          = 'SumatraPDF'
let g:vimtex_view_general_options         = '-reuse-instance -inverse-search "\"' . $VIMRUNTIME . '\gvim.exe\" -n --remote-silent +\%l \"\%f\"" -forward-search @tex @line @pdf'
let g:vimtex_view_general_options_latexmk = '-reuse-instance'

nmap <leader>l :VimtexView<cr>
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-latex 设置 {{{
" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" ultrasnip 设置 {{{
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsListSnippets = '<C-Tab>'
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories = ['C:\Users\GRC\.vim\UltiSnips','D:\grc\GitHub\Personal_things\Useful_Scripts\UltiSnips\','UltiSnips']
" let g:UltiSnipsSnippetsDir = 'C:\Users\GRC\.vim\UltiSnips'

nmap <leader>r :UltiSnipsEdit<cr>

"}}}

" General {{{
set nocompatible
set nobackup
set ruler
set laststatus=2 "总是显示状态栏
set noswapfile
set history=1024
set autochdir
set whichwrap=b,s,<,>,[,]
set nobomb
set backspace=indent,eol,start whichwrap+=<,>,[,]
set ignorecase
" Vim 的默认寄存器和系统剪贴板共享
set clipboard+=unnamed
" 设置 alt 键不映射到菜单栏
set winaltkeys=no
set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%] "显示文件名：总行数，总的字符数
" 分割窗口保持相同宽度
autocmd VimResized * wincmd =
" c-n 自动补全总是在扫描
setglobal complete-=i
" }}}

" Lang & Encoding {{{
set fileencodings=utf-8,gbk2312,gbk,gb18030,cp936
set encoding=utf-8
set langmenu=zh_CN
let $LANG = 'en_US.UTF-8'
language messages zh_CN.UTF-8
" }}}

" GUI {{{
colorscheme inkstained

" 高亮当前行
set cursorline
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=yellow guifg=yellow

source $VIMRUNTIME\delmenu.vim
source $VIMRUNTIME\menu.vim
set cursorline
set hlsearch

" 第一次进入时绝对行号，进入插入模式绝对行号。其他时间，相对行号。
set number
augroup relative_numbser
    autocmd!
    autocmd InsertEnter * :set norelativenumber
    autocmd InsertLeave * :set relativenumber
augroup END

" 窗口大小
set lines=50 columns=105
" 窗口位置
" if has("nvim")
"         winpos 0 0    "设置窗口的位置
" endif

" 分割出来的窗口位于当前窗口下边/右边
set splitbelow
set splitright
" 不显示工具/菜单栏
set guioptions-=T
set guioptions-=m
set guioptions-=L
set guioptions-=r
set guioptions-=b
" 使用内置 tab 样式而不是 gui
set guioptions-=e
set nolist
" set listchars=tab:?\ ,eol:?,trail:·,extends:>,precedes:<
" set guifont=Inconsolata:h12:cANSI
" set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h12:cANSI
" set guifont=Bitstream_Vera_Sans_Mono:h10:cANSI
" set guifont=Fira_Mono_for_Powerline:h10:cANSI
set guifont=Consolas:h12
" }}}

" Format {{{
set autoindent
set smartindent
set tabstop=4
set expandtab
set softtabstop=4
set foldmethod=indent
syntax on
" }}}

" Keymap {{{
let mapleader=","

nmap <leader>s :source C:\Users\grc\AppData\Local\nvim\init.vim<cr>
nmap <leader>e :e C:\Users\grc\AppData\Local\nvim\init.vim<cr>

map <leader>tn :tabnew<cr>
map <leader>tc :tabclose<cr>
map <leader>th :tabp<cr>
map <leader>tl :tabn<cr>

map <leader>m  :simalt ~x<cr>

" 分割窗口
map <Bar> <C-W>v<C-W><Right>
map -     <C-W>s<C-W><Down>

" 在分割窗口之间移动
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

" 正常模式下 alt+j,k,h,l 调整分割窗口大小
nnoremap <M-j> :resize +5<cr>
nnoremap <M-k> :resize -5<cr>
nnoremap <M-l> :vertical resize -5<cr>
nnoremap <M-h> :vertical resize +5<cr>

" 正常模式下 , . 分别为 行首 行尾
" nnoremap , 0
" nnoremap . , $

" 插入模式移动光标 alt + 方向键
inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-h> <left>
inoremap <M-l> <Right>

" IDE like delete
inoremap <C-BS> <Esc>bdei

nnoremap vv ^vg_
" 转换当前行为大写
inoremap <C-u> <esc>mzgUiw`za
" 命令模式下的行首尾
cnoremap <C-a> <home>
cnoremap <C-e> <end>

nnoremap <leader>w :set wrap!<cr>
nnoremap <space> za

imap <C-v> "+gP
vmap <C-c> "+y
vnoremap <BS> d
vnoremap <C-C> "+y
vnoremap <C-Insert> "+y
imap <C-V>		"+gP
map <S-Insert>		"+gP
cmap <C-V>		<C-R>+
cmap <S-Insert>		<C-R>+
imap <C-s> <Esc>:w<cr>a
nmap <C-s> :w<cr>
imap <A-Q> <Esc>:q<cr>
nmap <A-Q> :q<cr>
" inoremap jk <Esc>
" inoremap kj <Esc>

exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']

" 打开当前目录 windows
map <leader>ex :!start explorer %:p:h<CR>
" 打开当前目录CMD
map <leader>cmd :!start<cr>
" 打印当前时间
map <F4> a<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>
" 刷新 Ultisnips
map <F5> :call UltiSnips#RefreshSnippets()<CR>

" 复制当前文件/路径到剪贴板
nmap <leader>fn :let @*=substitute(expand("%"), "/", "\\", "g")<CR>
nmap <leader>fp :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>

" 设置切换Buffer快捷键"
nnoremap <C-left> :bn<CR>
nnoremap <C-right> :bp<CR>

" 滚动另外一个窗口
nmap <leader>j <c-w>w<c-d><c-w>w
nmap <leader>k <c-w>w<c-u><c-w>w
" }
"
" 使用终端命令编译 tex 文件
autocmd FileType tex nmap <buffer> <C-T> :!xelatex %<CR>
autocmd FIleType tex nmap <buffer> T :!SumatraPDF.exe %:r.pdf<CR><CR>

" 一些字符的映射
inoremap zb *
inoremap zn _
inoremap zm =
inoremap zh [
inoremap zj ]
inoremap zk {
inoremap zl }

" 当光标一段时间保持不动了，就禁用高亮
autocmd cursorhold * set nohlsearch
" 当输入查找命令时，再启用高亮
noremap n :set hlsearch<cr>n
noremap N :set hlsearch<cr>N
noremap / :set hlsearch<cr>/
noremap ? :set hlsearch<cr>?
noremap * *:set hlsearch<cr>
