(let [Hydra (require :hydra)
      KeymapUtil (require :hydra.keymap-util)
      Cmd KeymapUtil.cmd
      float_opts {:border ["┏" "━" "┓" "┃" "┛" "━" "┗" "┃"]}]
  ;; default configuration
  (Hydra.setup {:debug false
                :exit false
                :foreign_keys nil
                :color :red
                :timeout 10000
                :invoke_on_body false
                :hint {:show_name true
                       :position [:bottom]
                       :offset 0
                       :float_opts {}}
                :on_enter nil
                :on_exit nil
                :on_key nil})
  ;; window
  (let [heads [;; move window
               [:h :<C-w>h {:exit true}]
               [:j :<C-w>j {:exit true}]
               [:k :<C-w>k {:exit true}]
               [:l :<C-w>l {:exit true}]
               [:w :<C-w>w {:exit true}]
               [:<C-w> :<C-w>w {:desc false :exit true}]
               [:p :<C-w>p {:desc false :exit true}]
               [:<C-h> :<C-w>h]
               [:<C-j> :<C-w>j]
               [:<C-k> :<C-w>k]
               [:<C-l> :<C-w>l]
               ;; swap window
               [:H (Cmd "WinShift left")]
               [:J (Cmd "WinShift down")]
               [:K (Cmd "WinShift up")]
               [:L (Cmd "WinShift right")]
               ;; resize
               [:e
                (fn []
                  ((. (require :smart-splits) :start_resize_mode)))
                {:desc "resize mode" :exit true}]
               ;; window picker
               [:p
                (fn []
                  ((. (require :nvim-window) :pick)))
                {:desc "pick window" :exit true}]
               ["=" :<C-w>= {:desc :equalize :exit true}]
               [:<CR>
                (Cmd :DetourCurrentWindow)
                {:desc "open popup window" :exit true}]
               ;; split
               [:s :<C-w>s {:desc false :exit true}]
               [:v :<C-w>v {:desc false :exit true}]
               ;; zoom
               [:z (Cmd :NeoZoomToggle) {:desc :zoom :exit true}]
               ;; close
               ; [:q
               ;  (Cmd :SafeCloseWindow)
               ;  {:exit true :desc :close}]
               ; [:<C-q>
               ;  (Cmd :SafeCloseWindow)
               ;  {:desc false :exit true}]
               [:c :<C-w>c {:desc :close :exit true}]
               [:o :<C-w>o {:desc "close other" :exit true}]
               [:<C-o> :<C-w>o {:desc false :exit true}]
               ;; quit
               [:<Esc> nil {:desc false :exit true}]
               [";" nil {:desc false :exit true}]
               ;;[:<CR> nil {:desc false :exit true}]
               ]
        config {:invoke_on_body true
                ; :on_exit (fn []
                ;            (vim.schedule (fn []
                ;                            (vim.cmd :redrawstatus))))
                ; :hint {:type :window :position :middle : float_opts}
                :hint {:type :statuslinemanual}}
        ;         hint ":Move                 :Swap     :Utils
        ; --------------------  -------   ------------------------
        ;    _k_       _<C-k>_         _K_       _e_: start resize mode
        ;  _h_   _l_  _<C-h>_ _<C-l>_    _H_   _L_     _<CR>_ open popup window
        ;    _j_       _<C-j>_         _J_
        ; "
        ]
    (Hydra {:name :Windows :mode :n :body :<C-w> : heads : config}))
  ;; venn
  (let [heads [[:H "<C-v>h:VBox<CR>"]
               [:J "<C-v>j:VBox<CR>"]
               [:K "<C-v>k:VBox<CR>"]
               [:L "<C-v>l:VBox<CR>"]
               [:f ":VBox<CR>" {:mode :v}]
               [:<Esc> nil {:desc :close :exit true}]]
        config {:invoke_on_body true
                :color :pink
                :on_enter (fn [] (vim.cmd "setlocal ve=all"))
                :on_exit (fn [] (vim.cmd "setlocal ve="))
                :hint {:type :window :position :bottom-right : float_opts}}
        hint ":Move    Select region with <C-v>
-------  -------------------------
   _K_
 _H_   _L_   _f_: surround it with box
   _J_"]
    (Hydra {:name "Draw Diagram"
            :mode :n
            :body :<Leader>V
            : heads
            : config
            : hint})))
