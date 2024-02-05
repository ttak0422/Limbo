(let [M (require :gitsigns)
      current_line_blame_opts {:virt_text true
                               :virt_text_pos :eol
                               :delay 1000
                               :ignore_whitespace false}
      preview_config {:border ["┏" "━" "┓" "┃" "┛" "━" "┗" "┃"]
                      :style :minimal
                      :relative :cursor
                      :row 0
                      :col 1}
      yadm {:enable false}]
  (M.setup {:signcolumn true
            :numhl true
            :current_line_blame true
            :current_line_blame_formatter "<author> <author_time:%Y-%m-%d> - <summary>"
            :sign_priority 6
            :update_debounce 1000
            :max_file_length 40000
            : current_line_blame_opts
            : preview_config
            : yadm}))
