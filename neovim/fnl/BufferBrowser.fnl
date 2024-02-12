(let [M (require :buffer_browser)
      filetype_filters (dofile args.exclude_ft_path)]
  (M.setup {: filetype_filters}))
