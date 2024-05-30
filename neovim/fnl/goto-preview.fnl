(let [M (require :goto-preview)
      ; border ["┏" "━" "┓" "┃" "┛" "━" "┗" "┃"]
      border :none
      post_open_hook (fn [_ win]
                       (vim.api.nvim_win_set_option win :winhighlight "Normal:"))
      post_close_hook nil]
  (M.setup {:height 20
            :width 120
            :default_mappings false
            :resizing_mappings false
            :focus_on_open true
            :dismiss_on_move false
            :debug false
            :opacity nil
            : border
            ; : post_open_hook
            : post_close_hook}))
