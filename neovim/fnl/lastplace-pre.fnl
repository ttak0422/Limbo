(let [ignore_buftype (dofile args.exclude_buf_ft_path)
      ignore_filetype (dofile args.exclude_ft_path)
  (set vim.g.nvim_lastplace {: ignore_buftype
                             : ignore_filetype
                             :open_folds true}))
