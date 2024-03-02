(let [M (require :conform)
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
                        :nix [:nixfmt]}]
  (M.setup {: formatters_by_ft :notify_on_error true :format_on_save false})
  (vim.api.nvim_create_user_command :Format
                                    (fn []
                                      (M.format {:async false
                                                 :lsp_fallback true}))
                                    {}))
