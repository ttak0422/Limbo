(let [rainbow (require :rainbow-delimiters.setup)
              delimiters (require :rainbow-delimiters)
      strategy {"" delimiters.strategy.global :vim delimiters.strategy.local}
      query {"" :rainbow-delimiters :lua :rainbow-blocks}
      highlight [:RainbowDelimiterYellow
                 :RainbowDelimiterBlue
                 :RainbowDelimiterOrange
                 :RainbowDelimiterGreen
                 :RainbowDelimiterViolet
                 :RainbowDelimiterCyan]]
  (rainbow.setup {: strategy : query : highlight}))
