(let [M (require :toggleterm)
      T (. (require :toggleterm.terminal) :Terminal)
      cmd vim.api.nvim_create_user_command
      size (fn [term]
             (if (= term.direction :horizontal) (* vim.o.lines 0.3)
                 (* vim.o.columns 0.4)))
      toggle_term ((fn []
                     (let [terms {}]
                       (fn [idx]
                         ((if (not terms.idx)
                              (set terms.idx (: T :new {:direction :float}))
                              (if (: (. terms idx) :is_open)
                                  (if (: (. terms idx) :is_focused)
                                      (: (. terms idx) :toggle)
                                      (do
                                        (: (. terms idx) :focus)
                                        (vim.cmd :startinsert)))
                                  (do
                                    (: (. terms idx) :toggle)
                                    (vim.cmd :startinsert)))))))))
      toggle_tig ((fn []
                    (let [tig (: T :new
                                 {:cmd :tig :dir :git_dir :direction :float})]
                      (fn [] (: tig :toggle)))))]
  (M.setup {: size
            :shade_terminals false
            :auto_scroll false
            :start_in_insert true
            :winbar {:enabled true}})
  (cmd :TermToggle (fn [opts] (toggle_term opts.args)) {:nargs 1})
  (cmd :TigTermToggle toggle_tig {}))
