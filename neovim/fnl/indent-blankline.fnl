(let [M (require :ibl)
      highlight [:RainbowDelimiterYellow
                 :RainbowDelimiterBlue
                 :RainbowDelimiterOrange
                 :RainbowDelimiterGreen
                 :RainbowDelimiterViolet
                 :RainbowDelimiterCyan]
      ;; indent {:char "▏" : highlight}
      scope {:char "▏" :show_start false :show_end false : highlight}]
  (set vim.g.rainbow_delimiters {: highlight})
  (M.setup {;; : indent
            : scope
            :debounce 200}))
