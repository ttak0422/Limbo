set pumblend=11

call pum#set_option(#{
      \ auto_select: v:true,
      \ auto_confirm_time: 0,
      \ border: [ '┏', '━', '┓', '┃', '┛', '━', '┗', '┃' ],
      \ direction: 'auto',
      \ padding: v:false,
      \ scrollbar_char: '▌',
      \ item_orders: ['abbr', 'space', 'kind', 'space', 'menu'],
      \ max_height: 20,
      \ use_setline: v:true,
      \ offset_cmdcol: 0,
      \ offset_cmdrow: 0,
      \ highlight_normal_menu: '',
      \ highlight_preview: '',
      \ preview: v:true,
      \ preview_border: [ '┏', '━', '┓', '┃', '┛', '━', '┗', '┃' ],
      \ preview_width: 120,
      \ })

inoremap <expr> <TAB>
      \ pum#visible() ?
      \   '<Cmd>call pum#map#select_relative(+1)<CR>' :
      \ col('.') <= 1 ? '<TAB>' :
      \ getline('.')[col('.') - 2] =~# '\s' ? '<TAB>' :
      \ ddc#map#manual_complete()
inoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
inoremap <expr> <C-n> pum#visible() ? '<Cmd>call pum#map#select_relative(+1)<CR>' : '<C-n>'
inoremap <expr> <C-p> pum#visible() ? '<Cmd>call pum#map#select_relative(-1)<CR>' : '<C-p>'
inoremap <expr> <C-e> pum#visible() ? '<Cmd>call pum#map#cancel()<CR>' : '<End>'
inoremap <C-y> <Cmd>call pum#map#confirm()<CR>
inoremap <C-o> <Cmd>call pum#map#confirm_word()<CR>
" inoremap <expr> <CR> pum#visible() ? '<Cmd>call pum#map#confirm()<CR>' : '<CR>'

" cnoremap <expr> <Tab>
"       \ wildmenumode() ? &wildcharm->nr2char() :
"       \ pum#visible() ? '<Cmd>call pum#map#select_relative(+1)<CR>' :
"       \ ddc#map#manual_complete()
" cnoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
cnoremap <expr> <C-a> '<Home>'
cnoremap <expr> <C-b> '<Left>'
cnoremap <expr> <C-f> '<Right>'
cnoremap <expr> <C-n> pum#visible() ? '<Cmd>call pum#map#select_relative(+1)<CR>' : '<Down>'
cnoremap <expr> <C-p> pum#visible() ? '<Cmd>call pum#map#select_relative(-1)<CR>' : '<Up>'
cnoremap <expr> <C-e> pum#visible() ? '<Cmd>call pum#map#cancel()<CR>' : '<End>'
cnoremap <C-y> <Cmd>call pum#map#confirm()<CR>
cnoremap <C-o> <Cmd>call pum#map#confirm()<CR>
" cnoremap <expr><CR> pum#visible() ? '<Cmd>call pum#map#confirm()<CR>' : '<CR>'
