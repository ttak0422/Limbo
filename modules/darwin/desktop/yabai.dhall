let rules =
      ''
        yabai -m rule --add app='Finder' manage=off
        yabai -m rule --add app='zoom.us' manage=off
        yabai -m rule --add app='Docker*' manage=off
        yabai -m rule --add app='AnyConnect' manage=off
        yabai -m rule --add app='Alacritty' manage=off
        yabai -m rule --add app='システム環境設定' manage=off
        yabai -m rule --add app='WezTerm' manage=off
        yabai -m rule --add app=Emacs manage=on
      ''

let configs =
      ''
        yabai -m config layout            bsp
        yabai -m config mouse_modifier    alt
        yabai -m config mouse_action1     move
        yabai -m config mouse_action2     resize
        yabai -m config mouse_drop_action swap
        yabai -m config external_bar      all:0:26
        yabai -m config top_padding       5
        yabai -m config bottom_padding    5
        yabai -m config left_padding      5
        yabai -m config right_padding     5

      ''

in  { config =
        ''
        ${rules}
        ${configs}
        yabai -m space --gap abs:12
        ''
    }
