(let [M (require :project_nvim)
      detection_methods [:pattern]
      patterns [:.git]]
  (M.setup {:manual_mode false
            :scope_chdir :tab
            : detection_methods
            : patterns}))
