(let [M (require :window-picker) ;;
      ;; picker
      selection_display (fn [char _windowid]
                          (.. "%" char "%"))
      picker_config {:statusline_winbar_picker {: selection_display
                                                :use_winbar :never}
                     :floating_big_letter {:font :ansi-shadow}}
      ;; filter
      filter_rules {:autoselect_one true
                    :include_current_win false
                    :bo {:filetype (dofile args.exclude_ft_path)
                         :buftype (dofile args.exclude_buf_ft_path)}
                    :wo {}
                    :file_path_contains []
                    :file_name_contains []} ;;
      ;; highlights
      statusline {:focused {:fg "#ededed" :bg "#e35e4f" :bold true}
                  :unfocused {:fg "#ededed" :bg "#44cc41" :bold true}}
      winbar {:focused {:fg "#ededed" :bg "#e35e4f" :bold true}
              :unfocused {:fg "#ededed" :bg "#44cc41" :bold true}}
      highlights {: statusline : winbar}]
  (M.setup {:hint :floating-big-letter
            :selection_chars "FJDKSLA;CMRUEIWOQP"
            :show_prompt false
            :prompt_message "Pick window: "
            :filter_func nil
            : picker_config
            : filter_rules
            : highlights}))
