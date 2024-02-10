(let [M (require :ufo)
      provider_selector (fn [bufnr filetype buftype] [:treesitter :indent])
      map vim.keymap.set
      opt {:noremap true :silent true}]
  (M.setup {: provider_selector})
  (map :n :zR M.openAllFolds opt)
  (map :n :zM M.closeAllFolds opt)
  (map :n :zr M.openFoldsExceptKinds opt)
  (map :n :zm M.closeFoldsWith opt))
