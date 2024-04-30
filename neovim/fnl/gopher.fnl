(let [gopher (require :gopher)
      gopher_dap (require :gopher.dap)]
  (gopher.setup)
  (gopher_dap.setup))
