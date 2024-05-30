(let [hover (require :hover)
      init (fn [] (require :hover.providers.lsp))
      preview_opts {:border :none}
      mouse_providers [:LSP]]
  (hover.setup {: init
                : preview_opts
                :preview_window false
                : mouse_providers
                :mouse_dely 1000}))
