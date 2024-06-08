(let [M (require :headlines)
      markdown {:fat_headlines false}
      rmd {:fat_headlines false}
      norg {:fat_headlines false}
      org {:fat_headlines false}]
  (M.setup {: markdown : rmd : norg : org}))
