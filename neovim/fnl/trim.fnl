(let [M (require :trim)]
  (M.setup {:ft_blocklist [:markdown]
            :trim_on_write true
            :trim_trailing true
            :trim_last_line true
            :trim_first_line false}))
