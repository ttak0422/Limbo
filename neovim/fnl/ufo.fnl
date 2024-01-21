(let [M (require :ufo)
      provider_selector (fn [bufnr filetype buftype] [:treesitter :indent])
      m vim.keymap.set
      o {:noremap true :silent true}]
  (M.setup {: provider_selector})
  (m :n :zR M.openAllFolds o)
  (m :n :zM M.closeAllFolds o)
  (m :n :zr M.openFoldsExceptKinds o)
  (m :n :zm M.closeFoldsWith o))
