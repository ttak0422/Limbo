" setup
call ddu#custom#load_config(s:args['ts_config'])

" Note: the matchers should be empty for performance
function! s:ddu_rg_live() abort
call ddu#start(#{
      \   name: 'rg',
      \   sources: [#{
      \     name: 'rg',
      \     options: #{
      \       matchers: [],
      \       volatile: v:true,
      \     },
      \   }],
      \   uiParams: #{
      \     ff: #{
      \       ignoreEmpty: v:false,
      \       autoResize: v:false,
      \     }
      \   },
      \ })
endfunction

command! DduRgLive call <SID>ddu_rg_live()
