set langmenu=none
" https://github.com/folke/noice.nvim/wiki/A-Guide-to-Messages
set shortmess+=sWIcCS
" set iskeyword+=-
au WinEnter * checktime
au FileType * setlocal formatoptions-=ro
au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif
set cursorline
set cmdheight=0
vnoremap ; :
nnoremap ; :
" https://vim-jp.org/vim-users-jp/2009/10/08/Hack-84.html
au BufWritePost * if expand('%') != '' && &buftype !~ 'nofile' | mkview | endif
au BufRead * if expand('%') != '' && &buftype !~ 'nofile' | silent loadview | endif
set viewoptions-=options
