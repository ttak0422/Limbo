; (let [M (require :ddc_source_lsp)]
;   (M.make_client_capabilities))
(let [M (require :cmp_nvim_lsp)]
  (M.default_capabilities))
