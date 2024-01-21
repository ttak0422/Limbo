(let [M (require :smart-splits)
      ignored_filetypes [:nofile :quickfix :prompt]
      ignored_buftypes [:NvimTree]
      ignored_events [:BufEnter :WinEnter]
      resize_mode {:quit_key :<ESC>
                   :resize_keys [:h :j :k :l]
                   :silent false
                   :hooks {:on_enter nil :on_leave nil}}]
  (M.setup {: ignored_filetypes
            : ignored_buftypes
            : ignored_events
            : resize_mode
            :default_amount 3
            :at_edge :wrap
            :move_cursor_same_row false
            :cursor_follows_swapped_bufs false
            :multiplexer_integration nil
            :disable_multiplexer_nav_when_zoomed true
            :kitty_password nil
            :log_level :warn}))
