(let [M (require :statuscol)
      B (require :statuscol.builtin)
      segments [{:text ["%s"] :maxwidth 2 :click "v:lua.ScSa"}
                {:text [B.lnumfunc] :click "v:lua.ScLa"}
                {:text [" " B.foldfunc " "] :click "v:lua.ScFa"}]]
  ;; 行数表示
  (set vim.o.number true)
  ;; signcolumnのがたつきを無くす
  (set vim.o.signcolumn :yes)
  (M.setup {:setopt true :relculright false : segments}))
