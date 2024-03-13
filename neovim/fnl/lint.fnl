(let [M (require :lint)
      java [:checkstyle :typos]]
  (set M.linters_by_ft {: java})
  (vim.api.nvim_create_autocmd [:BufWritePost :BufEnter]
                               {:callback (fn [] (M.try_lint))}))
