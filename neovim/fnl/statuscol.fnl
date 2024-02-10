(let [M (require :statuscol)
      B (require :statuscol.builtin)
      segments [{:text ["%s"] :click "v:lua.ScSa"}
                {:text [B.lnumfunc] :click "v:lua.ScLa"}
                {:text [" " B.foldfunc " "] :click "v:lua.ScFa"}]]
  (M.setup {:setopt true :relculright false : segments}))
