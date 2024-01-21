;; for cspell
(if (not= (vim.fn.filereadable "~/.local/share/cspell/user.txt") 1)
    (do
      (io.popen "mkdir -p ~/.local/share/cspell")
      (io.popen "touch ~/.local/share/cspell/user.txt")))

(fn cspell_append [opts]
  (let [dict_path "~/.local/share/cspell/user.txt"
        word (if (or (not opts.word) (= opts.word ""))
                 (: (vim.call :expand :<cword>) :lower)
                 opts.word)]
    (io.popen (.. "echo " word " >> " dict_path))
    (vim.notify (.. "`" word "`" " is appended to user dictionary.")
                vim.log.levels.INFO {})
    ;; to apply new dictionary
    (if (vim.api.nvim_get_option_value :modifiable {})
        (do
          (vim.api.nvim_set_current_line (vim.api.nvim_get_current_line))
          (vim.api.nvim_command "silent! undo")))))

(fn is_active_lsp [lsp_name]
  (let [bufnr (vim.api.nvim_get_current_buf)
        clients (vim.lsp.buf_get_clients bufnr)]
    (accumulate [acc false _ client (ipairs clients)]
      (or acc (= lsp_name client.name)))))

(let [null (require :null-ls)
      utils (require :null-ls.utils)
      helpers (require :null-ls.helpers)
      formatter_factory (require :null-ls.helpers.formatter_factory)
      methods (require :null-ls.methods) ;;; code actions ;;;
      CODE_ACTION methods.internal.CODE_ACTION
      cspell_append_action {:name :cspell-append
                            :method CODE_ACTION
                            :filetypes []
                            :generator {:fn (fn [...]
                                              (let [lnum (- (. (vim.fn.getcurpos)
                                                               2)
                                                            1)
                                                    col (. (vim.fn.getcurpos) 3)
                                                    diagnostics (vim.diagnostic.get 0
                                                                                    {: lnum})
                                                    regex "^Unknown word %((%w+)%)$"
                                                    word (accumulate [acc "" _ d (ipairs diagnostics)]
                                                           (if (and (= d.source
                                                                       :cspell)
                                                                    (< d.col
                                                                       col)
                                                                    (<= col
                                                                        d.end_col)
                                                                    (string.match d.message
                                                                                  regex))
                                                               (: (string.gsub d.message
                                                                               regex
                                                                               "%1")
                                                                  :lower)
                                                               acc))]
                                                (if (not= word "")
                                                    [{:title (.. "Append " word
                                                                 " to user dictionary")
                                                      :action (fn []
                                                                (cspell_append {:args word}))}])))}}
      ;;; formatting ;;;
      FORMATTING methods.internal.FORMATTING
      dhall-format {:name :dhall-format
                    :method [FORMATTING]
                    :filetypes [:dhall]
                    :generator (null.formatter {:command :dhall
                                                :args [:format :$FILENAME]
                                                :to_stdin true})}
      fnlfmt {:name :fnlfmt
              :method [FORMATTING]
              :filetypes [:fennel]
              :generator (null.formatter {:command :fnlfmt
                                          :args [:$FILENAME]
                                          :to_stdin true})}
      sources [;;; code actions ;;;
               cspell_append_action
               ;;; completion ;;;
               ;;; diagnostics ;;;
               (null.builtins.diagnostics.eslint.with {:prefer_local :node_modules/.bin
                                                       :condition (fn [utils]
                                                                    (utils.root_has_file [;; https://eslint.org/docs/latest/user-guide/configuring/configuration-files-new
                                                                                          :eslint.config.js
                                                                                          ;; https://eslint.org/docs/user-guide/configuring/configuration-files#configuration-file-formats
                                                                                          :.eslintrc
                                                                                          :.eslintrc.js
                                                                                          :.eslintrc.cjs
                                                                                          :.eslintrc.yaml
                                                                                          :.eslintrc.yml
                                                                                          :.eslintrc.json]))})
               (null.builtins.diagnostics.cspell.with {:diagnostics_postprocess (fn [diagnostic]
                                                                                  (set diagnostic.severity
                                                                                       (. vim.diagnostic.severity
                                                                                          :WARN)))
                                                       :disabled_filetypes [:NvimTree]
                                                       :condition (fn []
                                                                    (> (vim.fn.executable :cspell)
                                                                       0))
                                                       :extra_args [:--config
                                                                    "~/.config/cspell/cspell.json"]})
               ; null.builtins.diagnostics.textlint
               ;;; formatting ;;;
               null.builtins.formatting.tidy
               null.builtins.formatting.fixjson
               null.builtins.formatting.taplo
               null.builtins.formatting.shfmt
               null.builtins.formatting.stylua
               null.builtins.formatting.yapf
               null.builtins.formatting.google_java_format
               null.builtins.formatting.nixfmt
               null.builtins.formatting.dart_format
               null.builtins.formatting.gofmt
               null.builtins.formatting.rustfmt
               null.builtins.formatting.yamlfmt
               (null.builtins.formatting.prettier.with {:prefer_local :node_modules/.bin
                                                        :runtime_condition (fn [...]
                                                                             (is_active_lsp :vtsls))})
               (null.builtins.formatting.deno_fmt.with {:runtime_condition (fn [...]
                                                                             (is_active_lsp :denols))})
               dhall-format
               fnlfmt]]
  (null.setup {:border ["┏" "━" "┓" "┃" "┛" "━" "┗" "┃"]
               :cmd [:nvim]
               :debounce 250
               :debug false
               :default_timeout 5000
               :diagnostic_config {}
               :diagnostics_format "#{m}"
               :fallback_severity vim.diagnostic.severity.ERROR
               :log_level :warn
               :notify_format "[null-ls] %s"
               :on_attach nil
               :on_init nil
               :on_exit nil
               :root_dir (utils.root_pattern [:.null-ls-root :.git])
               :should_attach nil
               :temp_dir nil
               :update_in_insert false
               : sources})
  (vim.api.nvim_create_user_command :Format "lua vim.lsp.buf.format()" {})
  nil)

