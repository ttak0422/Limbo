(let [M (require :kanagawa)]
  (M.setup {:compile true
                   :colors {:palette {:samuraiRed "#fa4343"}}
                   :overrides (fn [_]
                                {:NormalFloat {:bg :none}
                                 :FloatBorder {:bg :none}
                                 :FloatTitle {:bg :none}})}))

(vim.cmd "colorscheme kanagawa")
