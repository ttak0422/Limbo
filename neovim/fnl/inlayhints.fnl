(let [M (require :lsp-inlayhints)
      inlay_hints {:parameter_hints {:show true
                                     :prefix "← "
                                     :separator " "
                                     :remove_colon_start false
                                     :remove_colon_end true}
                   :type_hints {:show true
                                :prefix ""
                                :separator " "
                                :remove_colon_start false
                                :remove_colon_end false}
                   :only_current_line false
                   :labels_separator " "
                   :max_len_align false
                   :max_len_align_padding 1
                   :highlight :LspInlayHint
                   :priority 0}]
  (M.setup {:enabled_at_startup true :debug_mode false : inlay_hints}))
