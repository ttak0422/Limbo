call skkeleton#config(#{
      \   sources: ['skk_dictionary'],
      \   immediatelyDictionaryRW: v:true,
      \   userDictionary: '~/.skkeleton',
      \   globalDictionaries: [ s:args['jisyo'] ],
      \   markerHenkan: '',
      \   markerHenkanSelect: '',
      \ })
      " \   skkServerReqEnc: 'euc-jp',
      " \   skkServerResEnc: 'euc-jp',
      " \   skkServerHost: '127.0.0.1',
      " \   skkServerPort: 1178,
imap <C-j> <Plug>(skkeleton-toggle)
cmap <C-j> <Plug>(skkeleton-toggle)
tmap <C-j> <Plug>(skkeleton-toggle)
