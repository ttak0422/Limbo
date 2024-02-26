(let [M (require :conform)
      formatters_by_ft {:java [:google-java-format] :fennel [:fnlfmt]}]
  (M.setup {: formatters_by_ft :notify_on_error true :format_on_save false})
  (vim.api.nvim_create_user_command :Format
                                    (fn []
                                      (M.format {:async true
                                                 :lsp_fallback true}))
                                    {}))
