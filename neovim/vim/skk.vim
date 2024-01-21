call skkeleton#config({
      \ 'globalJisyo': s:args['jisyo_path'],
      \ 'globalJisyoEncoding': 'utf-8',
      \ 'markerHenkan': '',
      \ 'markerHenkanSelect': '',
      \ })
      " \ 'useSkkServer': v:true,
      " \ 'skkServerReqEnc': 'euc-jp',
      " \ 'skkServerResEnc': 'euc-jp',
      " \ 'skkServerHost': '127.0.0.1',
      " \ 'skkServerPort': 1178,
imap <C-j> <Plug>(skkeleton-enable)
cmap <C-j> <Plug>(skkeleton-enable)

function! s:skkeleton_pre() abort
  let s:prev_buffer_config = ddc#custom#get_buffer()
  call ddc#custom#patch_buffer(#{
        \   sources: ['around', 'skkeleton'],
        \   sourceOptions: #{
        \     _: #{
        \       keywordPattern: '[ァ-ヮア-ンー]+',
        \     },
        \   },
        \ })
endfunction

function! s:skkeleton_post() abort
  if 's:prev_buffer_config'->exists()
    call ddc#custom#set_buffer(s:prev_buffer_config)
  endif
endfunction

autocmd User skkeleton-disable-pre call s:skkeleton_post()
autocmd User skkeleton-enable-pre call s:skkeleton_pre()
autocmd User skkeleton-mode-changed redrawstatus
" https://github.com/Shougo/shougo-s-github/tree/4697362b2d96be2d372320495f9264f02208023b
