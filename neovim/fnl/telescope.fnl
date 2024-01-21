(let [M (require :telescope)
      theme (require :telescope.themes)
      lga_actions (require :telescope-live-grep-args.actions)
      defaults (theme.get_ivy {:path_display [:truncate]
                               :prompt_prefix " "
                               :selection_caret " "
                               :mappings {:i {:<C-j> {1 "<Plug>(skkeleton-enable)"
                                                      :type :command}}}})
      extensions {:live_grep_args {:auto_quoting true
                                   :mappings {:i {:<C-t> (lga_actions.quote_prompt {:postfix " -t "})
                                                  :<C-i> (lga_actions.quote_prompt {:postfix " --iglob "})}}}}]
  (M.setup {: defaults : extensions})
  (M.load_extension :live_grep_args)
  (M.load_extension :sonictemplate))
