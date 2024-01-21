(let [kanagawa (require :kanagawa)]
  (kanagawa.setup {:compile true
                   :undercurl true
                   :commentStyle {:italic true}
                   :functionStyle {}
                   :keywordStyle {:italic true}
                   :statementStyle {:bold true}
                   :typeStyle {}
                   :transparent false
                   :dimInactive false
                   :terminalColors true
                   :colors {:palette {:samuraiRed "#fa4343"}
                            :theme {:wave {} :lotus {} :dragon {} :all {}}}
                   :overrides (fn [colors]
                                {:NormalFloat {:bg :none}
                                 :FloatBorder {:bg :none}
                                 :FloatTitle {:bg :none}})
                   :theme :wave
                   :background {:dark :wave :light :lotus}}))

(vim.cmd "colorscheme kanagawa")
