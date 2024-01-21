let g:gina#command#blame#formatter#format="[%au] %su %=on %ti %ma%in"

function! GinaOpenHash() abort
  let can = gina#action#candidates()
  let cmd = printf('Gina browse --exact %s:%%', can[0].rev)
  execute cmd
endfunction

function! GinaOpenHashPR() abort
  let can = gina#action#candidates()
  call system(printf("git openpr %s", can[0].rev))
endfunction

call gina#custom#mapping#nmap(
      \ 'blame', '<C-o>',
      \ ':<C-u>call GinaOpenHash()<CR>',
      \ {'silent': 1},
      \)

call gina#custom#mapping#nmap(
      \ 'blame', '<C-p>',
      \ ':<C-u>call GinaOpenHashPR()<CR>',
      \ {'silent': 1},
      \)

call gina#custom#mapping#nmap(
      \ 'blame', 'K',
      \ ':<C-u>Gina show<CR>',
      \ {'silent': 1},
      \)
