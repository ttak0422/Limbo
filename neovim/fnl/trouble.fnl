(let [M (require :trouble)
      keys {:close [:q :<c-c>]
            :cancel :<esc>
            :refresh :R
            :jump [:<cr>]
            :open_split :s
            :open_vsplit :v
            :open_tab :t
            :jump_close []
            :toggle_mode []
            :switch_severity :S
            :toggle_preview []
            :hover :K
            :preview []
            :open_code_href []
            :close_folds :zc
            :open_folds :zo
            :toggle_fold :za
            :previous :k
            :next :j
            :help :g?}
      auto_jump [:lsp_definitions]
      include_declaration [:lsp_references
                           :lsp_implementations
                           :lsp_definitions]
      signs {:error ""
             :warning ""
             :hint ""
             :information ""
             :other ""}]
  (M.setup {:position :bottom
            :height 10
            :icons true
            :mode :document_diagnostics
            ; :severity vim.diagnostic.severity.INFO
            :fold_open ""
            :fold_closed ""
            :group true
            :padding true
            :cycle_results false
            :multiline true
            :indent_lines true
            :win_config {:border :none}
            :auto_open false
            :auto_close false
            :auto_preview true
            :auto_fold false
            :use_diagnostic_signs false
            : keys
            : auto_jump
            : include_declaration
            : signs}))
