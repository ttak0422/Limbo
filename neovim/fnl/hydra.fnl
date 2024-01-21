(local hydra (require :hydra))
(local cmd (. (require :hydra.keymap-util) :cmd))
(local config
       {:invoke_on_body true
        :hint {:border ["┏" "━" "┓" "┃" "┛" "━" "┗" "┃"]}})

;; submode for window
(local window (let [heads [;; move window
                           [:h :<C-w>h {:exit true}]
                           [:j :<C-w>j {:exit true}]
                           [:k :<C-w>k {:exit true}]
                           [:l :<C-w>l {:exit true}]
                           [:w :<C-w>w {:exit true}]
                           [:<C-w> :<C-w>w {:desc false :exit true}]
                           [:<C-h> :<C-w>h]
                           [:<C-j> :<C-w>j]
                           [:<C-k> :<C-w>k]
                           [:<C-l> :<C-w>l]
                           ;; swap window
                           [:H (cmd "WinShift left")]
                           [:J (cmd "WinShift down")]
                           [:K (cmd "WinShift up")]
                           [:L (cmd "WinShift right")]
                           [:e
                            ;; resize
                            (fn []
                              ((. (require :smart-splits) :start_resize_mode)))
                            {:desc "resize mode" :exit true}]
                           ["=" :<C-w>= {:desc :equalize :exit true}]
                           ;; split
                           [:s :<C-w>s {:desc false :exit true}]
                           [:v :<C-w>v {:desc false :exit true}]
                           ;; zoom
                           [:z (cmd :NeoZoomToggle) {:desc :zoom :exit true}]
                           ;; close
                           ; [:q
                           ;  (cmd :SafeCloseWindow)
                           ;  {:exit true :desc :close}]
                           ; [:<C-q>
                           ;  (cmd :SafeCloseWindow)
                           ;  {:desc false :exit true}]
                           [:c :<C-w>c {:desc :close :exit true}]
                           [:o :<C-w>o {:desc "close other" :exit true}]
                           [:<C-o> :<C-w>o {:desc false :exit true}]
                           ;; quit
                           [:<Esc> nil {:desc false :exit true}]
                           [";" nil {:desc false :exit true}]
                           [:<CR> nil {:desc false :exit true}]]
                    hint ":Move                 :Swap     :Utils
--------------------  -------   ----------------------
   _k_       _<C-k>_         _K_       _e_: start resize mode
 _h_   _l_  _<C-h>_ _<C-l>_    _H_   _L_
   _j_       _<C-j>_         _J_
"]
                (hydra {:name :Windows
                        :mode :n
                        :body :<C-w>
                        : hint
                        : heads
                        : config})))

nil
