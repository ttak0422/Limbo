(let [M (require :lsp-progress)
      format (fn [messages]
               (if (> (length messages) 0)
                   (table.concat messages " ")
                   ""))]
  (M.setup {:spin_update_time 200
            :event_update_time_limit 50
            :regular_internal_update_time 2000
            :max_size 200
            : format}))
