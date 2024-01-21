(let [M (require :haskell-tools)]
  (M.setup {:on_attach (dofile args.on_attach_path)
            :capabilities (dofile args.capabilities_path)}))
