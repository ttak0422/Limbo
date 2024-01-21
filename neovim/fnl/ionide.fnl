(let [M (require :ionide)]
  (M.setup {:autostart true
            :on_attach (dofile args.on_attach_path)
            :capabilities (dofile args.capabilities_path)})
  (vim.cmd :LspStart))
