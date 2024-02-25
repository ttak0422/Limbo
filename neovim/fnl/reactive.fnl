(let [M (require :reactive)
      custom {:name :custom
                           :static {:winhl {:inactive {:CursorLine {:bg "#363646"}}}}
                           :modes {:no {:operators {;; switch case
                                                    [:gu :gU "g~" "~"] {:winhl {:CursorLine {:bg "#363646"}}}
                                                    ;; change
                                                    :c {:winhl {:CursorLine {:bg "#363646"}}}
                                                    ;; delete
                                                    :d {:winhl {:CursorLine {:bg "#363646"}}}
                                                    ;; yank
                                                    :y {:winhl {:CursorLine {:bg "#363646"}}}}}
                                   :i {:winhl {:CursorLine {:bg "#3e3e4e"}}}
                                   :c {:winhl {:CursorLine {:bg "#404046"}}}
                                   :n {:winhl {:CursorLine {:bg "#363646"}}}
                                   ;; visual
                                   [:v :V "\022"] {:winhl {:Visual {:bg "#36365a"}}}
                                   ;; select
                                   [:s :S "\019"] {:winhl {:Visual {:bg "#363646"}}}
                                   ;; replace
                                   :R {:winhl {:CursorLine {:bg "#404046"}}}}}]

  (M.add_preset custom)
  (M.setup {}))
