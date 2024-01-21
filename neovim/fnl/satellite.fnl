(let [M (require :satellite)
      cursor {:enable true :symbols ["⎺" "⎻" "⎼" "⎽"]}
      search {:enable true}
      diagnostic {:enable true
                  :signs ["-" "" "≡"]
                  :min_severity vim.diagnostic.severity.WARN}
      gitsigns {:enable true :signs {:add "│" :change "│" :delete "-"}}
      marks {:enable false :show_builtins false :key :m}
      quickfix {:signs ["-" "" "≡"]}
      handlers {: cursor : search : diagnostic : gitsigns : marks : quickfix}]
  (M.setup {:current_only true
            :winblend 50
            :zindex 40
            :excluded_filetypes (dofile args.exclude_ft_path)
            :width 2
            : handlers}))
