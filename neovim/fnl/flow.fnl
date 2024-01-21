(let [flow (require :flow)
      output {:buffer true
              :size 80
              :focused true
              :modifiable false
              :window_override {:border :single
                                :title :Output
                                :title_pos :center
                                :style :minimal}} ;; WIP
      filetype_cmd_map {:python "python3 <<-EOF\n%s\nEOF"}
      sql_configs nil]
  (flow.setup {: output : filetype_cmd_map : sql_configs}))
