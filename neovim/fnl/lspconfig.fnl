;; configured by bundler-nvim
(local on_attach (dofile args.on_attach_path))
(local capabilities (dofile args.capabilities_path))

(vim.diagnostic.config {:severity_sort true})
(vim.lsp.set_log_level :WARN)
(tset vim.lsp.handlers :textDocument/hover
      (vim.lsp.with vim.lsp.handlers.hover {:border :single}))

(let [signs [{:name :DiagnosticSignError :text ""}
             {:name :DiagnosticSignWarn :text ""}
             {:name :DiagnosticSignInfo :text ""}
             {:name :DiagnosticSignHint :text ""}]]
  (each [_ sign (ipairs signs)]
    (vim.fn.sign_define sign.name {:texthl sign.name :text sign.text :numhl ""})))

(local lspconfig (require :lspconfig))
(local util (require :lspconfig.util))
(local windows (require :lspconfig.ui.windows))
(local climb (require :climbdir))
(local marker (require :climbdir.marker))

(set windows.default_options.border ["┏"
                                     "━"
                                     "┓"
                                     "┃"
                                     "┛"
                                     "━"
                                     "┗"
                                     "┃"])

;; lua
(lspconfig.lua_ls.setup {: on_attach
                         : capabilities
                         :settings {:Lua {:runtime {:version :LuaJIT}
                                          :diagnostics {:globals [:vim]}}
                                    :workspace {}
                                    :telemetry {:enable false}}})

;; fennel
(lspconfig.fennel_ls.setup {: on_attach
                            : capabilities
                            :settings {:fennel-ls {:extra-globals :vim}}})

;; nix
(lspconfig.nil_ls.setup {: on_attach
                         : capabilities
                         :autostart true
                         :settings {:nil {:formatting {:command [:nixpkgs-fmt]}}}})

;; bash
(lspconfig.bashls.setup {: on_attach : capabilities})

;; csharp
(lspconfig.csharp_ls.setup {: on_attach : capabilities})

;; python
(lspconfig.pyright.setup {: on_attach : capabilities})

;; ruby
(lspconfig.solargraph.setup {: on_attach : capabilities})

;; toml
(lspconfig.taplo.setup {: on_attach : capabilities})

;; go → use gopls
; (lspconfig.gopls.setup {: on_attach
;                         : capabilities
;                         :settings {:gopls {:analyses {:unusedparams true}}}
;                         :staticcheck true})

;; dart
(lspconfig.dartls.setup {: on_attach : capabilities})

;; dhall
(lspconfig.dhall_lsp_server.setup {: on_attach : capabilities})

;; yaml
(lspconfig.yamlls.setup {: on_attach
                         : capabilities
                         :settings {:yaml {:keyOrdering false}}})

;; html
(lspconfig.html.setup {: on_attach : capabilities})

;; css, css, less
(lspconfig.cssls.setup {: on_attach : capabilities})

;; typescript (node)
(lspconfig.vtsls.setup {: on_attach
                        : capabilities
                        :single_file_support false
                        :settings {:separate_diagnostic_server true
                                   :publish_diagnostic_on :insert_leave
                                   :typescript {:suggest {:completeFunctionCalls true}
                                                :preferences {:importModuleSpecifier :relative}}}
                        :root_dir (fn [path]
                                    (climb.climb path
                                                 (marker.one_of (marker.has_readable_file :package.json)
                                                                (marker.has_directory :node_modules))
                                                 {:halt (marker.one_of (marker.has_readable_file :deno.json))}))
                        :vtsls {:experimental {:completion {:enableServerSideFuzzyMatch true}}}})

;; typescript (deno)
(lspconfig.denols.setup {: on_attach
                         : capabilities
                         :single_file_support false
                         :root_dir (fn [path]
                                     (local found
                                            (climb.climb path
                                                         (marker.one_of (marker.has_readable_file :deno.json)
                                                                        (marker.has_readable_file :deno.jsonc)
                                                                        (marker.has_directory :denops))
                                                         {:halt (marker.one_of (marker.has_readable_file :package.json)
                                                                               (marker.has_directory :node_modules))}))
                                     (local buf (. vim.b (vim.fn.bufnr)))
                                     (when found
                                       (set buf.deno_deps_candidate
                                            (.. found :/deps.ts)))
                                     found)
                         :init_options {:lint true
                                        :unstable false
                                        :suggest {:completeFunctionCalls true
                                                  :names true
                                                  :paths true
                                                  :autoImports true
                                                  :imports {:autoDiscover true
                                                            :hosts (vim.empty_dict)}}}
                         :settings {:deno {:enable true}}})

;; markdown
(lspconfig.marksman.setup {: on_attach : capabilities})

;; ast_grep
(lspconfig.ast_grep.setup {: on_attach : capabilities})

;; efm
(let [fs (require :efmls-configs.fs) ;; linter
      luacheck (require :efmls-configs.linters.luacheck)
      eslint (require :efmls-configs.linters.eslint)
      yamllint (require :efmls-configs.linters.yamllint)
      statix (require :efmls-configs.linters.statix)
      stylelint (require :efmls-configs.linters.stylelint)
      vint (require :efmls-configs.linters.vint)
      staticcheck (require :efmls-configs.linters.staticcheck)
      shellcheck (require :efmls-configs.linters.shellcheck)
      pylint (require :efmls-configs.linters.pylint)
      gitlint (require :efmls-configs.linters.gitlint)
      hadolint (require :efmls-configs.linters.hadolint) ;;
      ;; formatter
      stylua (require :efmls-configs.formatters.stylua)
      fnlfmt (require :efmls-configs.formatters.fnlfmt)
      prettier (require :efmls-configs.formatters.prettier)
      fixjson (require :efmls-configs.formatters.fixjson)
      shfmt (require :efmls-configs.formatters.shfmt)
      taplo (require :efmls-configs.formatters.taplo)
      nixfmt (require :efmls-configs.formatters.nixfmt)
      ;; AOSPが提供されているので時前で定義する
      ;; google_java_format (require :efmls-configs.formatters.google_java_format)
      google_java_format (let [command (.. (fs.executable :google-java-format)
                                           " $(echo -n ${--useless:rowStart} ${--useless:rowEnd}"
                                           " | xargs -n4 -r sh -c 'echo"
                                           " --skip-sorting-imports"
                                           " --skip-removing-unused-imports"
                                           " --skip-reflowing-long-strings"
                                           " --skip-javadoc-formatting"
                                           " --lines $(($1+1)):$(($3+1))'" ") -")]
                           {:formatCanRange true
                            :formatCommand command
                            :formatStdin true
                            :rootMarkers [:.project
                                          :classpath
                                          :pom.xml
                                          :build.gradle]})
      yapf (require :efmls-configs.formatters.yapf)
      goimports (require :efmls-configs.formatters.goimports)
      gofumpt (require :efmls-configs.formatters.gofumpt)
      rustfmt (require :efmls-configs.formatters.rustfmt)
      languages {:lua [luacheck stylua]
                 :fennel [fnlfmt]
                 :typescript [eslint prettier]
                 :javascript [eslint prettier]
                 :json [fixjson]
                 :sh [shellcheck shfmt]
                 :toml [taplo]
                 :yaml [yamllint prettier]
                 :nix [statix nixfmt]
                 :java [google_java_format]
                 :css [stylelint prettier]
                 :scss [stylelint prettier]
                 :less [stylelint prettier]
                 :saas [stylelint prettier]
                 :html [prettier]
                 :vim [vint]
                 :python [pylint yapf]
                 :go [staticcheck goimports gofumpt]
                 :rust [rustfmt]
                 :gitcommit [gitlint]
                 :docker [hadolint]}
      settings {:rootMarkers [:.git/] : languages}
      init_options {:documentFormatting true :documentRangeFormatting true}
      make_settings (fn []
                      {:single_file_support true
                       :filetypes (vim.tbl_keys languages)
                       : settings
                       : init_options
                       : on_attach
                       : capabilities})]
  (lspconfig.efm.setup (make_settings)))

;; create user commands
(vim.api.nvim_create_user_command :Format "lua vim.lsp.buf.format()" {})
