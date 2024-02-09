(let [M (require :project_nvim)
      detection_methods [:pattern]
      patterns [:.git]
      datapath (vim.fn.stdpath :data)]
  (M.setup {:manual_mode false
            :scope_chdir :tab
            : detection_methods
            : patterns
            : datapath}))
