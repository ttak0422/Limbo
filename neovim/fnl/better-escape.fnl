(let [M (require :better_escape)]
  (M.setup {:mapping [:jk]
            :timeout vim.o.timeoutlen
            :clear_empty_lines false
            :keys :<Esc>}))
