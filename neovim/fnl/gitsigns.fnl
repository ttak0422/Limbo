(let [M (require :gitsigns)
      status_formatter (fn [status]
                         (let [added status.added
                               changed status.changed
                               removed status.removed
                               status_txt {}]
                           (if (and added (> added 0))
                               (table.insert status_txt (.. " " added))
                               (if (and changed (> changed 0))
                                   (table.insert status_txt (.. " " changed))
                                   (if (and removed (> removed 0))
                                       (table.insert status_txt
                                                     (.. " " removed)))))
                           (table.concat status_txt " ")))
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
            : status_formatter
            : current_line_blame_opts
            : preview_config
            : yadm}))
