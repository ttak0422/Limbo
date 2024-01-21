(let [M (require :dap-go)
      dap_configurations [{:type :go
                           :name "Attach remote"
                           :mode :remote
                           :request :attach}]
      delve {:initialize_timeout_sec 20 :port "${port}"}]
  (M.setup {: dap_configurations : delve}))
