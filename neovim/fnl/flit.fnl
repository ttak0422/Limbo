(let [M (require :flit)
      keys {:f :f :F :F :t :t :T :T}
      opts {}]
  (M.setup {:labeled_modes :v :multiline true : keys : opts}))
