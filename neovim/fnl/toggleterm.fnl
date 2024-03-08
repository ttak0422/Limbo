(let [M (require :toggleterm)
      T (require :toggleterm.terminal)
      Terminal T.Terminal
      create_cmd vim.api.nvim_create_user_command
      size (fn [term]
             (if (= term.direction :horizontal) (* vim.o.lines 0.3)
                 (* vim.o.columns 0.4)))
      toggle_term ((fn []
                     (let [terms {}]
                       (fn [idx]
                         (let [term (if (. terms idx) (. terms idx)
                                        (do
                                          (tset terms idx
                                                (: Terminal :new
                                                   {:direction :float}))
                                          (. terms idx)))
                               is_open (: term :is_open)
                               is_focused (: term :is_focused)]
                           (if is_open
                               (if is_focused
                                   ;; close
                                   (: term :toggle)
                                   ;; focus
                                   (do
                                     (: term :focus)
                                     (vim.cmd :startinsert)))
                               ;; open
                               (do
                                 (: term :toggle)
                                 (vim.cmd :startinsert))))))))]
  (M.setup {: size
            :shade_terminals false
            :auto_scroll false
            :start_in_insert true
            :winbar {:enabled true}})
  (create_cmd :TermToggle (fn [opts] (toggle_term opts.args)) {:nargs 1}))
