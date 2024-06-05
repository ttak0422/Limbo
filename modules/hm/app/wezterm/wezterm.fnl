(let [wezterm (require :wezterm)
      act wezterm.action
      keys [;; unbind `QuickSelect`
            {:key :Space
             :mods :CTRL|SHIFT
             :action act.DisableDefaultAssignment}
            {:key "=" :mods :CTRL :action act.IncreaseFontSize}
            {:key :Enter :mods :ALT :action act.ToggleFullScreen}
            {:key :f :mods :SHIFT|SUPER :action act.ToggleFullScreen}
            {:key :0 :mods :CTRL :action (act.SendString "\027[48;5u")}
            {:key :1 :mods :CTRL :action (act.SendString "\027[49;5u")}
            {:key :2 :mods :CTRL :action (act.SendString "\027[50;5u")}
            {:key :3 :mods :CTRL :action (act.SendString "\027[51;5u")}
            {:key :4 :mods :CTRL :action (act.SendString "\027[52;5u")}
            {:key :5 :mods :CTRL :action (act.SendString "\027[53;5u")}
            {:key :6 :mods :CTRL :action (act.SendString "\027[54;5u")}
            {:key :7 :mods :CTRL :action (act.SendString "\027[55;5u")}
            {:key :8 :mods :CTRL :action (act.SendString "\027[56;5u")}
            {:key :9 :mods :CTRL :action (act.SendString "\027[57;5u")}]
      window_padding {:left 5 :right 5 :top 5 :bottom 0}
      default_prog [:zsh :-l :-c "zellij attach --index 0 --create"]
      morimo {:foreground "#b5D2a9"
              :background "#2a2a2e"
              :cursor_bg "#98b18e"
              :cursor_fg "#98b18e"
              :cursor_border "#98b18e"
              :selection_fg "#98b18e"
              :selection_bg "#7aa7b3"
              :scrollbar_thumb "#313135"
              :split "#313135"
              :ansi ["#2a2a2e"
                     "#d76e6e"
                     "#679f68"
                     "#d3c785"
                     "#789cbc"
                     "#b384b1"
                     "#7aa7b3"
                     "#98b18e"]
              :brights ["#b0b7be"
                        "#ff6e6e"
                        "#98c593"
                        "#e0d7a3"
                        "#9bb9d4"
                        "#d0a3d0"
                        "#a0c8cc"
                        "#b5d2a9"]}]
  {; :color_scheme "Kanagawa (Gogh)"
   :colors morimo
   :font (wezterm.font_with_fallback ["PlemolJP Console NF"
                                      "JetBrains Mono"
                                      "Noto Color Emoji"
                                      "Symbols Nerd Font Mono"])
   :allow_square_glyphs_to_overflow_width :WhenFollowedBySpace
   :window_decorations :RESIZE
   :enable_tab_bar false
   :adjust_window_size_when_changing_font_size false
   :audible_bell :Disabled
   :default_cursor_style :SteadyBlock
   :force_reverse_video_cursor true
   : keys
   : window_padding
   : default_prog})
