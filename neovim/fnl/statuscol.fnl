(let [M (require :statuscol)
      B (require :statuscol.B)
      segments [{:text ["%s"] :click "v:lua.ScFa"}
                {:text [" " B.foldfunc " "]
                 :condition [B.not_empty true B.not_empty]
                 :click "v:lua.scfa"}
                {:text [B.lnumfunc]}]]
  (M.setup {:setopt true :relculright true : segments}))
