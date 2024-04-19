set langmenu=none
" https://github.com/folke/noice.nvim/wiki/A-Guide-to-Messages
set shortmess+=sWIcCS
set iskeyword+=-
au WinEnter * checktime
au FileType * setlocal formatoptions-=ro
au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif
set cursorline
set cmdheight=0
vnoremap ; :
nnoremap ; :
