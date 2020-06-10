set rtp+=~/.vim
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'lervag/vimtex'
Plug 'SirVer/ultisnips'
call plug#end()

" �����빤��Ŀ¼
autocmd VimEnter * NERDTree 
" " ���� NERDTree ����ʱ���Զ���ʾ Bookmarks
let NERDTreeShowBookmarks=1
let NERDTreeShowHidden=1
let NERDTreeWinSize=31
" " 打开编辑器时，光标在右侧窗口
wincmd w
autocmd VimEnter * wincmd w
" " ֻ�� NERDTree ����ʱ�˳�
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" " �ر�NERDTree��ݼ�
map <F5> :NERDTreeToggle<CR>

"""  UltiSnips """""""""""""""""""""""""
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsListSnippets = '<C-Tab>'
let g:UltiSnipsSnippetDirectories = ['.vim/UltiSnips','UltiSnips']

let g:ctrlp_map = ',,'
let g:ctrlp_cmd = 'CtrlP'

"""  Vimtex """"""""""""""""""""""""""""
let g:tex_flavor  = 'latex'
let g:vimtex_quickfix_mode  = 2
let g:vimtex_latexmk_options  = '-xelatex -verbose -file-line-error -synctex=1 -shell-escape -interaction=nonstopmode' 
set clipboard+=unnamed
set ignorecase
set fileencodings=utf-8,gbk2312,gbk,gb18030,cp936
set encoding=utf-8
set langmenu=zh_CN
let $LANG = 'en_US.UTF-8'

let mapleader=","

nmap <leader>s :source ~/.config/nvim/init.vim<cr>
nmap <leader>e :e ~/.config/nvim/init.vim<cr>

" �ָ��
map <Bar> <C-W>v<C-W><Right>
map -     <C-W>s<C-W><Down>

" �ڷָ��֮���ƶ�
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

nnoremap <F2> :setlocal number!<cr>
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
