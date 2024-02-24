(let [M (require :oil)
      columns [:icon]
      buf_options {:buflisted false :bufhidden :hide}
      win_options {:wrap false
                   :signcolumn :number
                   :cursorcolumn false
                   :foldcolumn :0
                   :spell false
                   :list false
                   :conceallevel 3
                   :concealcursor :nvic}
      keymaps {:g? :actions.show_help
               :<CR> :actions.select
               ; :<C-s> :actions.select_vsplit
               ; :<C-h> :actions.select_split
               ; :<C-t> :actions.select_tab
               ; :<C-p> :actions.preview
               :<C-c> :actions.close
               ; :<C-l> :actions.refresh
               ; :- :actions.parent
               ; :_ :actions.open_cwd
               ; "`" :actions.cd
               ; "~" :actions.tcd
               ; :gs :actions.change_sort
               ; :gx :actions.open_external
               ; :g. :actions.toggle_hidden
               ; "g\\" :actions.toggle_trash
               }
      keymaps_help {:border :rounded}
      view_options {:show_hidden true
                    :is_hidden_file (fn [name bufnr]
                                      (vim.startswith name "."))
                    :is_always_hidden (fn [name bufnr] false)
                    :sort [[:type :asc] [:name :asc]]}
      float {:padding 2
             :max_width 0
             :max_height 0
             :border :single
             :win_options {:winblend 0}
             :override (fn [conf])}
      preview {:max_width 0.9
               :min_width [40 0.4]
               :width nil
               :max_height 0.9
               :min_height [5 0.1]
               :height nil
               :border :single
               :win_options {:winblend 0}
               :update_on_cursor_moved true}
      progress {:max_width 0.9
                :min_width [40 0.4]
                :width nil
                :max_height [10 0.9]
                :min_height [5 0.1]
                :height nil
                :border :single
                :minimized_border :none
                :win_options {:winblend 0}}
      ssh {:border :single}]
  (M.setup {:default_file_explorer false
            :delete_to_trash true
            :skip_confirm_for_simple_edits false
            :prompt_save_on_select_new_entry true
            :cleanup_delay_ms 2000
            :lsp_rename_autosave false
            :constrain_cursor :editable
            :experimental_watch_for_changes false
            :use_default_keymaps false
            : columns
            : buf_options
            : win_options
            : keymaps
            : keymaps_help
            : float
            : preview
            : progress
            : ssh}))
