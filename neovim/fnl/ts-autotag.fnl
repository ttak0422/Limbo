(let [M (require :nvim-ts-autotag)
      filetypes [:javascript :typescript :jsx :tsx :vue :html]]
  (M.setup {: filetypes}))
