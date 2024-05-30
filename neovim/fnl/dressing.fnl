(let [M (require :dressing)
      input {:enabled true
             :default_prompt "Input:"
             :title_pos :center
             :insert_inly true
             :start_in_insert true
             :border :none
             :relative :cursor
             :prefer_width 0.4
             :buf_options {}
             :win_options {}
             :mappings {:n {:<ESC> :close :<CR> :Confirm}
                        :i {:<C-c> :Close
                            :<CR> :Confirm
                            :<Up> :HistoryPrev
                            :<Down> :HistoryNext}}}
      select {:enable true
              :backend [:telescope :builtin]
              :trim_prompt true
              :telescope ((. (require :telescope.themes) :get_cursor))}]
  (M.setup {: input : select}))
