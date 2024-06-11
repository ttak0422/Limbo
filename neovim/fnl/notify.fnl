(let [M (require :notify)]
  (M.setup {:timeout 2500
            :render :wrapped-compact
            :top_down false
            :stages :static
            :background_colour "#000000"})
  (set vim.notify M))
