"autocmd Filetype markdown map <leader>w yiWi[<esc>Ea](<esc>pa)
autocmd Filetype markdown inoremap <buffer> <M-f> <Esc>/<++><CR>:nohlsearch<CR>"_c4l
autocmd Filetype markdown inoremap <buffer> <M-w> <Esc>/ <++><CR>:nohlsearch<CR>"_c5l<CR>
autocmd Filetype markdown inoremap <buffer> <M-a> ---<Enter><Enter>
autocmd Filetype markdown inoremap <buffer> <M-b> **** <++><Esc>F*hi
autocmd Filetype markdown inoremap <buffer> <M-s> $$<Enter><++><Enter>$$<Enter><Enter><++><Esc>3ki
autocmd Filetype markdown inoremap <buffer> <M-i> ** <++><Esc>F*i
autocmd Filetype markdown inoremap <buffer> <M-d> `` <++><Esc>F`i
autocmd Filetype markdown inoremap <buffer> <M-c> ```<Enter><Enter>```<Enter><Enter><++><Esc>4kA
autocmd Filetype markdown inoremap <buffer> <M-t> - [ ] 
autocmd Filetype markdown inoremap <buffer> <M-p> ![](<++>) <++><Esc>F[a
autocmd Filetype markdown inoremap <buffer> <M-k> [](<++>) <++><Esc>F[a
autocmd Filetype markdown inoremap <buffer> <M-1> #<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> <M-2> ##<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> <M-3> ###<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> <M-4> ####<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> <M-5> #####<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> <M-6> ######<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> <M-l> --------<Enter> 

autocmd Filetype vimwiki inoremap <buffer> <M-f> <Esc>/<++><CR>:nohlsearch<CR>"_c4l
autocmd Filetype vimwiki inoremap <buffer> <M-w> <Esc>/ <++><CR>:nohlsearch<CR>"_c5l<CR>
autocmd Filetype vimwiki inoremap <buffer> <M-a> ---<Enter><Enter>
autocmd Filetype vimwiki inoremap <buffer> <M-b> **** <++><Esc>F*hi
autocmd Filetype vimwiki inoremap <buffer> <M-s> $$<Enter><Enter>$$<Enter><Enter><++><Esc>3ki
autocmd Filetype vimwiki inoremap <buffer> <M-i> ** <++><Esc>F*i
autocmd Filetype vimwiki inoremap <buffer> <M-d> `` <++><Esc>F`i
autocmd Filetype vimwiki inoremap <buffer> <M-c> ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA
autocmd Filetype vimwiki inoremap <buffer> <M-t> - [ ] 
autocmd Filetype vimwiki inoremap <buffer> <M-p> ![](<++>) <++><Esc>F[a
autocmd Filetype vimwiki inoremap <buffer> <M-k> [](<++>) <++><Esc>F[a
autocmd Filetype vimwiki inoremap <buffer> <M-1> #<Space><Enter><++><Esc>kA
autocmd Filetype vimwiki inoremap <buffer> <M-2> ##<Space><Enter><++><Esc>kA
autocmd Filetype vimwiki inoremap <buffer> <M-3> ###<Space><Enter><++><Esc>kA
autocmd Filetype vimwiki inoremap <buffer> <M-4> ####<Space><Enter><++><Esc>kA
autocmd Filetype vimwiki inoremap <buffer> <M-5> #####<Space><Enter><++><Esc>kA
autocmd Filetype vimwiki inoremap <buffer> <M-6> ######<Space><Enter><++><Esc>kA
autocmd Filetype vimwiki inoremap <buffer> <M-l> --------<Enter> 
