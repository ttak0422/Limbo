(let [M (require :goto-preview)
      border ["┏" "━" "┓" "┃" "┛" "━" "┗" "┃"]
      post_open_hook (fn [_ win]
                       (vim.api.nvim_win_set_option win :winhighlight "Normal:"))]
  (M.setup {:height 30 : border : post_open_hook}))
