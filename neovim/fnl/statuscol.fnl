(let [M (require :statuscol)
      B (require :statuscol.builtin)
      segments [{:text ["%C"] :click "v:lua.ScFa"}
                {:text ["%s"] :click "v:lua.ScFa"}
                {:text [B.lnumfunc " "]
                 :condition [true B.not_empty]
                 :click "v:lua.ScFa"}]]
  (M.setup {:setopt true :relculright false : segments}))
