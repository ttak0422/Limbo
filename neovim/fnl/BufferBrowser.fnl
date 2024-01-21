(let [M (require :buffer_browser)
      filetype_filters [:gitcommit :TelescopePrompt]]
  (M.setup {: filetype_filters}))
