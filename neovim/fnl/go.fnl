(let [go (require :go)
      format (require :go.format)
      icons {:breakpoint "🧘" :currentpos "🏃"}
      diagnostic {:hdlr false
                  :underline true
                  :virtual_text {:spacing 0 :prefix "■"}
                  :signs true
                  :update_in_insert false}
      lsp_inlay_hints {:enable true
                       :style :inlay
                       :only_current_line false
                       :only_current_line_autocmd :CursorHold
                       :show_variable_name true
                       :parameter_hints_prefix "󰊕 "
                       :show_parameter_hints true
                       :other_hints_prefix "> "
                       :max_len_align false
                       :max_len_align_padding 1
                       :right_align false
                       :right_align_padding 6
                       :highlight :Comment}
      floaterm {:posititon :auto :width 0.45 :height 0.98 :title_colors :nord}
      dap_debug_gui {}
      dap_debug_vt {:enabled_commands true :all_frames true}
      on_attach (fn [client bufnr]
                  (let [mk_opts (fn [desc] {:silent true :buffer bufnr : desc})
                        n_keys [[:<LocalLeader>r
                                 (vim.cmd :GoRun)
                                 (mk_opts :Run)]
                                [:<LocalLeader>f
                                 (vim.cmd :GoFmt)
                                 (mk_opts :Format)]
                                [:<LocalLeader>l
                                 (vim.cmd :GoLint (mk_opts :Lint))]
                                [:<LocalLeader>b
                                 (do
                                   (vim.cmd :GoVet)
                                   (vim.cmd :GoBuild))
                                 (mk_opts :Build)]]]
                    ((dofile args.on_attach_path) client bufnr)
                    (each [_ k (ipairs n_keys)]
                      (vim.keymap.set :n (. k 1) (. k 2) (. k 3)))))]
  (go.setup {:disable_defaults false
             :go :go
             :goimports :gopls
             :gofmt :gopls
             :fillstruct :gopls
             :max_line_len 0
             :tag_transform false
             :tag_options :json=omitempty
             :gotests_template ""
             :gotests_template_dir ""
             :comment_placeholder ""
             : icons
             :verbose false
             :lsp_cfg {:capabilities (dofile args.capabilities_path)}
             :lsp_gofumpt true
             :lsp_on_attach on_attach
             :lsp_keymaps false
             :lsp_codelens true
             : diagnostic
             :lsp_document_formatting true
             :lsp_document_formatting true
             : lsp_inlay_hints
             :gopls_cmd nil
             :gopls_remote_auto true
             :gocoverage_sign "█"
             :sign_priority 5
             :dap_debug true
             :dap_debug_keymap false
             : dap_debug_gui
             : dap_debug_vt
             :dap_port 38697
             :dap_timeout 15
             :dap_retries 20
             :build_tags "tag1,tag2"
             :textobjects true
             ;; one of {`go`, `richgo`, `dlv`, `ginkgo`, `gotestsum`}
             :test_runner :go
             :verbose_tests true
             :run_in_floaterm false
             : floaterm
             :trouble false
             :test_efm false
             :luasnip false
             :iferr_vertical_shift 4})
  (vim.api.nvim_create_autocmd [:BufWritePre]
                               {:pattern :*.go
                                :callback (fn []
                                            (format.goimports))})
  (vim.cmd :LspStart))
