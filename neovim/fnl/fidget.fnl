(let [fidget (require :fidget)
      progress {; poll per seconds
                :poll_rate 1
                :suppress_on_insert true
                :ignore_done_already true
                :ignore_empty_message true
                :ignore []
                :display {:render_limit 10
                          :done_ttl 3
                          :done_icon "✔"
                          :done_style :Constant
                          :progress_ttl 40
                          :progress_icon {:pattern :dots :period 1}
                          :progress_style :WarningMsg
                          :group_style :Title
                          :icon_style :Question
                          :priority 30
                          :format_message (. (require :fidget.progress.display)
                                             :default_format_message)
                          :format_annote (fn [msg] msg.title)
                          :format_group_name (fn [grp] (tostring grp))
                          :overrides {:rust_analyzer {:name :rust-analyzer}}}}
      notification {; poll per seconds
                    :poll_rate 1
                    :filter vim.log.levels.INFO
                    :override_vim_notify false
                    :configs {:default fidget.notification.default_config}
                    :view {:stack_upwards true
                           :icon_separator " "
                           :group_separator "---"
                           :group_separator_hl :Comment}
                    :window {:normal_hl :Comment
                             :winblend 100
                             :border :none
                             :zindex 45
                             :max_width 0
                             :max_height 0
                             :x_padding 1
                             :y_padding 0
                             :align :bottom
                             :relative :editor}}
      logger {:level vim.log.levels.WARN
              :float_precision 0.01
              :path (string.format "%s/fidget.nvim.log" (vim.fn.stdpath :cache))}]
  (fidget.setup {: progress : notification : logger}))
