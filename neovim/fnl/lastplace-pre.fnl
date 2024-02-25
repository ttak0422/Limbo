(let [ignore_buftype [:quickfix :nofile :help]
      ignore_filetype [:gitcommit :gitrebase :svn :hgcommit]]
  (set vim.g.nvim_lastplace {: ignore_buftype
                             : ignore_filetype
                             :open_folds true}))
