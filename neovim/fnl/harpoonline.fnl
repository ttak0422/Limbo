(let [M (require :harpoonline)
      formatter_opts {:default {:inactive " %s "
                                :active "[%s]"
                                :max_slots 4
                                :more "…"}
                      :short {:inner_separator "|"}}
      on_update (fn [] (vim.cmd.redrawstatus))]
  (M.setup {:icon ""
            :default_list_name ""
            :formatter :default
            :custom_formatter nil
            : formatter_opts
            : on_update}))
