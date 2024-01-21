(let [M (require :indent-o-matic)]
  (M.setup {:max_lines 2048 :standard_widths [2 4 8] :skip_multiline true}))
