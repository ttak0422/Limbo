(let [M (require :notify)]
  (M.setup {:timeout 2500
            :top_down true
            :stages :static
            :background_colour "#000000"})
  (set vim.notify M))
