imap <expr> <C-k> vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<Plug>(Tabout)'
smap <expr> <C-k> vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<Plug>(Tabout)'
imap <expr> <C-l> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<Plug>(TaboutBack)'
smap <expr> <C-l> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<Plug>(TaboutBack)'
