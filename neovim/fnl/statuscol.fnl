(let [M (require :statuscol)
      B (require :statuscol.builtin)
      segments [{:text ["%s"] :maxwidth 2 :click "v:lua.ScSa"}
                {:text [B.lnumfunc] :click "v:lua.ScLa"}
                {:text [" " B.foldfunc " "] :click "v:lua.ScFa"}]
      statuses [:NeotestPassed :NeotestFailed :NeotestRunning :NeotestSkipped]]
  ;; 行数表示
  (set vim.o.number true)
  ;; signcolumnのがたつきを無くす
  (set vim.o.signcolumn :yes)
  (M.setup {:setopt true :relculright false : segments})
  ;; WIP: signの背景色を手動設定
  (each [_ s (ipairs statuses)]
    (vim.api.nvim_set_hl 0 s {:bg "#2a2a37"})))
