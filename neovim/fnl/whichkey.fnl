(let [M (require :which-key)
      plugins {:presets {:operators false}}]
  (M.setup {: plugins}))
