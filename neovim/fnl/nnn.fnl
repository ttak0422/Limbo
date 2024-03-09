(let [M (require :nnn)
      picker {}
      feedkeys (fn [keys]
                 (vim.api.nvim_feedkeys (vim.api.nvim_replace_termcodes keys
                                                                        true
                                                                        false
                                                                        true)
                                        :n true))
      mappings [
                ;; [:<Esc> (fn [] (feedkeys :<Esc>))]
                ]]
  (M.setup {: picker : mappings}))
