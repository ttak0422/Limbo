(let [M (require :piccolo-pomodoro)
      T (require :piccolo-pomodoro.type)
      prefix {}
      focus {}
      break {}
      long-break {}
      on_update (fn [] (vim.cmd :redrawstatus))
      focus_format (fn [ctx]
                     (string.format "%s%02d:%02d"
                                    (. (. prefix ctx.timer_mode)
                                       ctx.timer_state)
                                    ctx.m ctx.s))
      break_format (fn [ctx]
                     (string.format "%s%02d %02d"
                                    (. (. prefix ctx.timer_mode)
                                       ctx.timer_state)
                                    ctx.m ctx.s))
      on_start (fn []
                 (if (= (vim.fn.has :mac) 1)
                     (vim.fn.system "osascript -e 'display notification \"Start!\" with title \"pomodoro\" sound name \"Bell\"'")
                     (vim.notify :Start!))
                 (vim.cmd :redrawstatus))
      on_pause (fn []
                 (if (= (vim.fn.has :mac) 1)
                     (vim.fn.system "osascript -e 'display notification \"Pause!\" with title \"pomodoro\" sound name \"Bell\"'")
                     (vim.notify :Pause!))
                 (vim.cmd :redrawstatus))
      on_complete_focus_time (fn []
                               (if (= (vim.fn.has :mac) 1)
                                   (vim.fn.system "osascript -e 'display notification \"Focus time is over!\" with title \"pomodoro\" sound name \"Bell\"'")
                                   (vim.notify "Focus time is over!")))
      on_complete_break_time (fn []
                               (if (= (vim.fn.has :mac) 1)
                                   (vim.fn.system "osascript -e 'display notification \"Focus time is over!\" with title \"pomodoro\" sound name \"Bell\"'")
                                   (vim.notify "Focus time is over!")))]
  (tset focus T.TIMER_STATE.IDLE " ")
  (tset focus T.TIMER_STATE.ACTIVE " ")
  (tset focus T.TIMER_STATE.PAUSE " ")
  (tset break T.TIMER_STATE.IDLE " BREAK ")
  (tset break T.TIMER_STATE.ACTIVE " BREAK ")
  (tset break T.TIMER_STATE.PAUSE " BREAK ")
  (tset long-break T.TIMER_STATE.IDLE " BREAK ")
  (tset long-break T.TIMER_STATE.ACTIVE " BREAK ")
  (tset long-break T.TIMER_STATE.PAUSE " BREAK ")
  (tset prefix T.TIMER_MODE.FOCUS focus)
  (tset prefix T.TIMER_MODE.BREAK break)
  (tset prefix T.TIMER_MODE.LONG_BREAK long-break)
  (M.setup {: on_update
            : focus_format
            : break_format
            : on_start
            : on_pause
            : on_complete_focus_time
            : on_complete_break_time}))
