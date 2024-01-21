(let [M (require :rust-tools)
      E (require :rust-tools.executors)
      tools {:executor E.toggleterm
             :on_initialized nil
             :reload_workspace_from_cargo_toml true
             :inlay_hints {;; use lsp-inlayhints.nvim
                           :auto false}
             :hover_actions {:border {["┏" :FloatBorder] ["━" :FloatBorder]
                                      ["┓" :FloatBorder] ["┃" :FloatBorder]
                                      ["┛" :FloatBorder] ["━" :FloatBorder]
                                      ["┗" :FloatBorder] ["┃" :FloatBorder]}
                             :max_width nil
                             :max_height nil
                             :auto_focus false}}
      on_attach (dofile args.on_attach_path)
      capabilities (dofile args.capabilities_path)
      rust-analyzer {:assist {:expressionFillDefault :todo}
                     :cachePriming {:enable true :numThreads 0}
                     :cargo {:autoreload true
                             :buildScripts {:enable true
                                            :useRustcWrapper true
                                            :noSysroot false
                                            :unsetTest [:core]}}
                     :check {:allTargets true :checkOnSave true :extraArgs []}
                     :completion {:autoimport {:enable true}
                                  :autoself {:enable true}
                                  :callable {:snippets :fill_arguments}
                                  :postfix {:enable true}
                                  :privateEditable {:enable false}}
                     :diagnostics {:enable true
                                   :disabled []
                                   :experimental {:enable false}
                                   :remapPrefix []
                                   :warningsAsHint []
                                   :warningsAsInfo []}
                     :files {:excludeDirs [] :watcher :client}
                     :highlightRelated {:breakPoints {:enable true}
                                        :exitPoints {:enable true}
                                        :references {:enable true}
                                        :yieldPoints {:enable true}}
                     :hover {:actions {:enable true
                                       :debug {:enable true}
                                       :gotoTypeDef {:enable true}
                                       :implementations {:enable true}
                                       :references {:enable true}
                                       :run {:enable true}}
                             :documentation {:enable true}
                             :links {:enable true}}
                     :imports {:granularity {:enforce false :group :crate}
                               :group {:enable true}
                               :merge {:glob true}
                               :prefix :plain}
                     :joinLines {:joinAssignments true
                                 :joinElseIf true
                                 :removeTrailingComma true
                                 :unwrapTrivialBlock true}
                     :lens {:enable true
                            :debug {:enable true}
                            :forceCustomCommands true
                            :implementations {:enable true}
                            :references {:atd {:enable false}
                                         :enumVariant {:enable false}
                                         :method {:enable false}
                                         :trait {:enable false}
                                         :run {:enable true}}}
                     :linkedProjects []
                     :notifications {:cargoTomlNotFound true}
                     :procMacro {:enable true
                                 :attributes {:enable true}
                                 :ignored []}
                     :runnables {:extraArgs []}
                     :rustfmt {:extraArgs [] :rangeFormatting {:enable false}}
                     :semanticHighlighting {:strings {:enable true}}
                     :signatureInfo {:detail :full
                                     :documentation {:enable true}}
                     :typing {:autoClosingAngleBrackets {:enable false}}
                     :workspace {:symbol {:search {:kind :only_types
                                                   :limit 128
                                                   :scope :workspace}}}}
      server {: on_attach : capabilities :settings {: rust-analyzer}}]
  (M.setup {: tools : server}))
