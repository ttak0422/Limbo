(let [M (require :colorful-winsep)
      U (require :colorful-winsep.utils)
      symbols ["━" "┃" "┏" "┓" "┗" "┛"]
      no_exec_files (dofile args.exclude_ft_path) ; create_event (fn []
      ;                (if (= (U.calculate_number_windows) 2)
      ;                    (let [win_id (vim.fn.win_getid (vim.fn.winnr :h))
      ;                          filetype (vim.api.nvim_buf_get_option (vim.api.nvim_win_get_buf win_id)
      ;                                                                :filetype)]
      ;                      (if (= filetype :NvimTree) (M.NvimSeparatorDel)))))
      ]
  (M.setup {: symbols : no_exec_files}))
