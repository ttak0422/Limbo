(let [M (require :ufo)
      provider_selector (fn [bufnr filetype buftype] [:treesitter :indent])
      map vim.keymap.set
      opts {:foldcolumn :1
            :foldenable true
            :fillchars "eob: ,fold: ,foldopen:,foldsep: ,foldclose:"}
      opt {:noremap true :silent true}]
  (each [k v (pairs opts)]
    (tset vim.o k v))
  (M.setup {: provider_selector})
  (map :n :zR M.openAllFolds opt)
  (map :n :zM M.closeAllFolds opt)
  (map :n :zr M.openFoldsExceptKinds opt)
  (map :n :zm M.closeFoldsWith opt))
