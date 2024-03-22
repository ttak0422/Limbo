(let [ht (require :haskell-tools)
      tools {:log {:level vim.log.levels.ERROR}}
      hls {:on_attach (dofile args.on_attach_path)
           :capabilities (dofile args.capabilities_path)
           }
      dap {}]
  (set vim.g.haskell_tools {: tools : hls : dap}))
