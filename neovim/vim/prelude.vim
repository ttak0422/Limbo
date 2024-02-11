set langmenu=none
set shortmess+=I
set iskeyword+=-
au WinEnter * checktime
au FileType * setlocal formatoptions-=ro
au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif
