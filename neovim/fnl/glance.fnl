(let [M (require :glance)
      border {:enable true :top_char "━" :bottom_char "━"}
      folds {:fold_closed "▸" :fold_open "▾" :folded false}]
  (M.setup {: border : folds}))
