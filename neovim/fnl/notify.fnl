(let [M (require :notify)]
  (M.setup {:timeout 2500
            :top_down false
            :stages :static
            :background_colour "#000000"})
  (set vim.notify M))
