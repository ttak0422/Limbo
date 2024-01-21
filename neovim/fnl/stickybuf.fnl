(let [M (require :stickybuf)
      get_auto_pin (fn [bufnr] (M.should_auto_pin bufnr))]
  (do
    (M.setup {: get_auto_pin})
    (vim.api.nvim_create_autocmd :BufEnter
                                 {:callback (fn []
                                              (if (or (not (M.is_pinned))
                                                      (or vim.wo.winfixwidth
                                                          vim.wo.winfixheight))
                                                  (M.pin)))})))
