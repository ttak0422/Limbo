(let [M (require :copilot)
      keymap {:jump_prev "[["
              :jump_next "]]"
              :accept :<CR>
              :refresh :<M-r>
              :open :<M-CR>
              :layout {:position :bottom :ratio 0.4}}
      suggestion {:enabled true
                  :auto_trigger true
                  :debounce 150
                  :keymap {:accept :<C-a>
                           :accept_word false
                           :accept_line false
                           :next "<C-]>"
                           :prev "<C-[>"
                           :dismiss :<M-e>}}
      filetypes {:help false :gitrebase false :. false}]
  (M.setup {:enabled true
            :auto_refresh false
            : keymap
            : suggestion
            : filetypes}))
