(let [M (require :trim)
      ft_blocklist [:markdown]]
  (M.setup {: ft_blocklist
            :trim_on_write true
            :trim_trailing true
            :trim_last_line true
            :trim_first_line true}))
