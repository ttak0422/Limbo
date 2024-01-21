(let [configs {:translate_source :en
               :translate_target :ja
               ;; If you use DeepL, you need to append the authentication key to the following file.
               ;; $XDG_CONFIG_HOME/denops_translate/deepl_authkey
               ;; $HOME/Library/Preferences/denops_translate/deepl_authkey (for macOS)
               :translate_endpoint "https://api-free.deepl.com/v2/translate"
               :translate_ui :popup
               :translate_sentence_break {:en "." :ja "."}
               :translate_border_chars ["┏"
                                        "━"
                                        "┓"
                                        "┃"
                                        "┛"
                                        "━"
                                        "┗"
                                        "┃"]}]
  (each [k v (pairs configs)]
    (tset vim.g k v)))
