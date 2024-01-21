(let [M (require :trouble)
      keys {:close [:q :<c-c>]
            :cancel :<esc>
            :refresh :R
            :jump [:<cr> :<tab> :<2-leftmouse>]
            :open_split :<c-s>
            :open_vsplit :<c-v>
            :open_tab :<c-t>
            :jump_close []
            :toggle_mode []
            :switch_severity :s
            :toggle_preview []
            :hover :K
            :preview []
            :open_code_href []
            :close_folds :zc
            :open_folds :zo
            :toggle_fold :za
            :previous :k
            :next :j
            :help "?"}
      auto_jump [:lsp_definitions]
      include_declaration [:lsp_references
                           :lsp_implementations
                           :lsp_definitions]]
  (M.setup {:position :bottom
            :height 10
            :icons true
            :mode :workspace_diagnostics
            :severity nil
            :fold_open ""
            :fold_closed ""
            :group true
            :padding true
            :cycle_results false
            :multiline true
            :indent_lines true
            :win_config {:border :single}
            :auto_open false
            :auto_close false
            :auto_preview true
            :auto_fold false
            :use_diagnostic_signs true
            : keys
            : auto_jump
            : include_declaration}))
