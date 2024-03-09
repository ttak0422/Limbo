(let [lir (require :lir)
      actions (require :lir.actions)
      mark_actions (require :lir.mark.actions)
      clipboard_actions (require :lir.clipboard.actions)
      ignore [:.DS_Store]
      devicons {:enable true :highlight_dirname true}
      mappings {:e actions.edit
                :l actions.edit
                :<CR> actions.edit
                :h actions.up
                :q actions.quit
                :n actions.newfile
                :r actions.rename
                :d actions.delete}
      float {:winblend 0
             :curdir_window {:enable false :highlight_dirname false}
             :win_opts (fn []
                         (let [width (math.floor (/ vim.o.columns 2))
                               height (math.floor (/ vim.o.lines 2))]
                           {: width
                            : height
                            ; :row 10
                            ; :col (math.floor (/ (- vim.o.columns width) 2))
                            :border ["┏"
                                     "━"
                                     "┓"
                                     "┃"
                                     "┛"
                                     "━"
                                     "┗"
                                     "┃"]}))
             :hide_cursor true}]
  (lir.setup {:show_hidden_files true : ignore : devicons : mappings : float}))
