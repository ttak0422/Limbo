function! s:ddu_send_all_to_qf() abort
  call ddu#ui#do_action('clearSelectAllItems')
  call ddu#ui#do_action('toggleAllItems')
  call ddu#ui#do_action('itemAction', #{ name: 'quickfix'})
endfunction

inoremap <buffer><silent> <CR>  <ESC><Cmd>call ddu#ui#do_action('itemAction')<CR>
inoremap <buffer><silent> <ESC> <ESC><Cmd>call ddu#ui#do_action('closeFilterWindow')<CR>
inoremap <buffer><silent> <C-c> <ESC><Cmd>call ddu#ui#do_action('quit')<CR>
inoremap <buffer><silent> <C-n> <Cmd>call ddu#ui#do_action('cursorNext', #{ loop: v:true })<CR>
inoremap <buffer><silent> <C-p> <Cmd>call ddu#ui#do_action('cursorPrevious', #{ loop: v:true })<CR>
inoremap <buffer><silent> <C-q> <Cmd>call <SID>ddu_send_all_to_qf()<CR>

nnoremap <buffer><silent> <ESC> <Cmd>call ddu#ui#do_action('closeFilterWindow')<CR>
nnoremap <buffer><silent> <C-n> <Cmd>call ddu#ui#do_action('cursorNext', #{ loop: v:true })<CR>
nnoremap <buffer><silent> <C-p> <Cmd>call ddu#ui#do_action('cursorPrevious', #{ loop: v:true })<CR>
