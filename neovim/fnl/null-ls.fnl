(let [null_ls (require :null-ls)
      utils (require :null-ls.utils)
      sources []]
  (null_ls.setup {:border ["┏" "━" "┓" "┃" "┛" "━" "┗" "┃"]
                  :cmd [:nvim]
                  :debounce 250
                  :debug false
                  :default_timeout 5000
                  :diagnostic_config {}
                  :diagnostics_format "#{m} (#{s})"
                  :fallback_severity vim.diagnostic.severity.ERROR
                  :log_level :warn
                  :notify_format "[null-ls] %s"
                  :on_attach nil
                  :on_init nil
                  :on_exit nil
                  :root_dir (utils.root_pattern [:.null-ls-root :.git])
                  :root_dir_async nil
                  :should_attach nil
                  :temp_dir nil
                  :update_in_insert false
                  : sources}))
