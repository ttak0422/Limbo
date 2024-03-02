" completion
call ddc#custom#load_config(s:args['ts_config'])

call ddc#enable(#{ context_filetype: 'treesitter' })

" cmdline completion
function! CommandlinePre() abort
  let b:prev_buffer_config = ddc#custom#get_buffer()
  autocmd User DDCCmdlineLeave ++once call CommandlinePost()
  call ddc#enable_cmdline_completion()
endfunction
function! CommandlinePost() abort
  if 'b:prev_buffer_config'->exists()
    call ddc#custom#set_buffer(b:prev_buffer_config)
    unlet b:prev_buffer_config
  endif
endfunction

" doc
call signature_help#enable()

" keymaps
inoremap <C-x>      <Cmd>call ddc#map#manual_complete()<CR>
inoremap <C-x><C-x> <Cmd>call ddc#map#manual_complete()<CR>
inoremap <C-x><C-b> <Cmd>call ddc#map#manual_complete(#{ sources: ['buffer'] })<CR>
inoremap <C-x><C-f> <Cmd>call ddc#map#manual_complete(#{ sources: ['file'] })<CR>
inoremap <C-x><C-l> <Cmd>call ddc#map#manual_complete(#{ sources: ['lsp'] })<CR>
inoremap <expr> <C-Space> '<C-n>'

cnoremap <silent> <C-x>      <Cmd>call ddc#map#manual_complete()<CR>
cnoremap <silent> <C-x><C-x> <Cmd>call ddc#map#manual_complete()<CR>

nnoremap ; :
nnoremap <expr> : '<Cmd>call CommandlinePre()<CR>: '
nnoremap  ? <Cmd>call CommandlinePre()<CR>?
nnoremap  / <Cmd>call CommandlinePre()<CR>/
