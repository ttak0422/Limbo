let g:undotree_ShortIndicators=1
function g:Undotree_CustomMap()
  nmap <buffer> U <plug>UndotreePreviousSavedState
  nmap <buffer> R <plug>UndotreeNextSavedState
  nmap <buffer> u <plug>UndotreeUndo
  nmap <buffer> r <plug>UndotreeRedo
  nmap <buffer> <C-c> <plug>UndotreeClose
endfunc
