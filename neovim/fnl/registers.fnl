(let [M (require :registers)
      bind_keys {:normal (M.show_window {:mode :motion})
                 :visual (M.show_window {:mode :motion})
                 :insert (M.show_window {:mode :insert})
                 :registers (M.apply_register {:delay 0.1})
                 :<CR> (M.apply_register)
                 :<Esc> (M.close_window)
                 :<C-n> (M.move_cursor_down)
                 :<C-p> (M.move_cursor_up)
                 :<C-j> (M.move_cursor_down)
                 :<C-k> (M.move_cursor_up)
                 :<Del> (M.clear_highlighted_register)
                 :<BS> (M.clear_highlighted_register)}
      events {:on_register_highlighted (M.preview_highlighted_register {:if_mode {:insert :paste}})}
      symbols {:newline "⏎"
               :space " "
               :tab "·"
               :register_type_charwise "ᶜ"
               :register_type_linewise "ˡ"
               :register_type_blockwise "ᵇ"}
      window {:max_width 100
              :highlight_cursorline true
              :border ["┏" "━" "┓" "┃" "┛" "━" "┗" "┃"]
              :transparency 0}
      sign_highlights {:cursorlinesign :CursorLine
                       :signcolumn :SignColumn
                       :cursorline :Visual
                       :selection :Constant
                       :default :Function
                       :unnamed :Statement
                       :read_only :Type
                       :expression :Exception
                       :black_hole :Error
                       :alternate_buffer :Operator
                       :last_search :Tag
                       :delete :Special
                       :yank :Delimiter
                       :history :Number
                       :named :Todo}]
  (M.setup {:show "*\"/1234567890abcdefghijklmnopqrstuvwxyz#%.:"
            :show_empty false
            :register_user_command true
            :system_clipboard true
            :trim_whitespace true
            :hide_only_whitespace true
            :show_register_types true
            : bind_keys
            : events
            : symbols
            : window
            : sign_highlights}))
