(let [ddc_source_lsp_setup (require :ddc_source_lsp_setup)]
  (ddc_source_lsp_setup.setup
  {:override_capabilities true :respect_trigger true}))
