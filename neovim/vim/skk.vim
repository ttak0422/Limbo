call skkeleton#config(#{
      \   sources: ['skk_server'],
      \   immediatelyDictionaryRW: v:false,
      \   userDictionary: '~/.skkeleton',
      \   globalDictionaries: [ s:args['jisyo'] ],
      \   skkServerReqEnc: 'euc-jp',
      \   skkServerResEnc: 'euc-jp',
      \   skkServerHost: '127.0.0.1',
      \   skkServerPort: 1178,
      \   markerHenkan: '',
      \   markerHenkanSelect: '',
      \ })
imap <C-j> <Plug>(skkeleton-toggle)
cmap <C-j> <Plug>(skkeleton-toggle)
tmap <C-j> <Plug>(skkeleton-toggle)
