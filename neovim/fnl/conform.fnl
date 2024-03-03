(let [M (require :conform) ;;
      ;; WIP
      is_active_lsp (fn [lsp_name]
                      (let [bufnr (vim.api.nvim_get_current_buf)
                            clients (vim.lsp.buf_get_clients bufnr)]
                        (accumulate [acc false _ client (ipairs clients)]
                          (or acc (= lsp_name client.name)))))
      formatters_by_ft {:dart [:dart_format]
                        :json [:fixjson]
                        :rust [:rustfmt]
                        :shfmt [:shfmt]
                        :lua [:stylua]
                        :toml [:taplo]
                        :html [:htmlbeautifier]
                        :yaml [:yamlfmt]
                        :python [:yapf]
                        :fennel [:fnlfmt]
                        :java [:google-java-format]
                        :nix [:nixfmt]
                        ;; WIP
                        :typescript [:prettier]
                        :javascript [:prettier]}]
  (M.setup {: formatters_by_ft :notify_on_error true :format_on_save false})
  (vim.api.nvim_create_user_command :Format
                                    (fn []
                                      (M.format {:async false
                                                 :lsp_fallback true}))
                                    {}))
