;; direnv
(var is_direnv false)
(var is_direnv_active false)
(local check_direnv
       (fn []
         (vim.loop.spawn :sh
                         {:args [:-c
                                 "direnv status | grep --silent 'Found RC allowed'"]}
                         (fn [handle] (set is_direnv (= handle 0))))))

(local check_direnv_active
       (fn []
         (vim.loop.spawn :sh
                         {:args [:-c
                                 "direnv status | grep --silent 'Found RC allowed true'"]}
                         (fn [handle]
                           (set is_direnv_active (= handle 0))))))

(vim.api.nvim_create_autocmd [:DirChanged]
                             {:pattern "*"
                              :callback (fn []
                                          (check_direnv)
                                          (check_direnv_active))})

; wip
(check_direnv)
(check_direnv_active)
(vim.defer_fn (fn []
                (vim.cmd :redrawstatus)) 1000)

;; lsp
(local ignore_lsp {:copilot true})
(local check_lsp_attach
       (fn []
         (let [clients (vim.lsp.get_active_clients {:bufnr 0})]
           (accumulate [acc false _ client (pairs clients)]
             (or acc (not (. ignore_lsp (. client :name))))))))

;; heirline
(let [;; plugins
      heirline (require :heirline) ;;
      conditions (require :heirline.conditions)
      utils (require :heirline.utils)
      kanagawa (require :kanagawa.colors)
      hydra (require :hydra.statusline) ;; options
      kanagawa_palette (. ((. kanagawa :setup)) :palette)
      kanagawa_colors {:bg kanagawa_palette.sumiInk2
                       :fg kanagawa_palette.sumiInk6
                       :red kanagawa_palette.autumnRed
                       :green kanagawa_palette.autumnGreen
                       :blue kanagawa_palette.crystalBlue
                       :grey kanagawa_palette.fujiGray
                       :orange kanagawa_palette.surimiOrange
                       :purple kanagawa_palette.oniViolet
                       :cyan kanagawa_palette.lotusCyan
                       :diag_warn kanagawa_palette.roninYellow
                       :diag_error kanagawa_palette.samuraiRed
                       :diag_hint kanagawa_palette.dragonBlue
                       :diag_info kanagawa_palette.waveAqua1
                       :git_del kanagawa_palette.autumnRed
                       :git_add kanagawa_palette.autumnGreen
                       :git_change kanagawa_palette.autumnYellow}
      colors kanagawa_colors ;; options
      opts {: colors} ;;
      ;; params
      icons {:terminal ""
             :keyboard " "
             :vim ""
             :circle ""
             :circle_o "⭘"
             :circle_d ""
             :lock ""
             :left_rounded ""
             :left_rounded_thin ""
             :right_rounded ""
             :right_rounded_thin ""
             :bar "|"
             :warn ""
             :error ""
             :document ""}
      seps {:bar (.. " " icons.bar " ")
            :left_rounded_thin (.. " " icons.left_rounded_thin " ")
            :right_rounded_thin (.. " " icons.right_rounded_thin " ")}
      mode_labels {;; ノーマル
                   :n :N
                   ;; オペレータ待機
                   :no :N
                   ;; オペレータ待機 (強制文字単位 o_v)
                   :nov :N
                   ;; オペレータ待機 (強制行単位 o_V)
                   :noV :N
                   ;; オペレータ待機 (強制ブロック単位 o_CTRL-V);
                   "no\022" :N
                   ;; Insert-mode で i_CTRL-O を使用したノーマル
                   :niI :N
                   ;; Replace-mode で i_CTRL-O を使用したノーマル
                   :niR :N
                   ;; Virtual-Replace-mode で i_CTRL-O を使用したノーマル
                   :niV :N
                   ;; 端末ノーマル (挿入により端末ジョブモードになる)
                   :nt :N
                   ;; 文字単位ビジュアル
                   :v :V
                   ;; 選択モードで v_CTRL-O を利用した時の文字単位ビジュアル
                   :vs :V
                   ;; 行単位ビジュアル
                   :V :V
                   ;; 選択モードで v_CTRL-O を利用した時の行単位ビジュアル
                   :Vs :V
                   ;; 矩形ビジュアル
                   "\022" :V
                   ;; 選択モードで v_CTRL-O を利用した時の矩形ビジュアル
                   "\022s" :V
                   ;; 文字単位選択
                   :s :S
                   ;; 行単位選択
                   :S :S
                   ;; 矩形選択
                   "\019" :S
                   ;; 挿入モード
                   :i :I
                   ;; 挿入モード補完 compl-generic
                   :ic :I
                   ;; 挿入モード i_CTRL-X 補完
                   :ix :I
                   ;; 置換 R
                   :R :R
                   ;; 置換モード補完 compl-generic
                   :Rc :R
                   ;; 置換モード i_CTRL-X 補完
                   :Rx :R
                   ;; 仮想置換 gR
                   :Rv :R
                   ;; 補完での仮想置換モード compl-generic
                   :Rvc :R
                   ;; i_CTRL-X 補完での仮想置換モード
                   :Rvx :R
                   ;; コマンドライン編集
                   :c :C
                   ;; 端末ジョブモードでのコマンドライン編集
                   :ct :C
                   ;; Vim Ex モード gQ
                   :cv :Ex
                   ;; ノーマル Ex モード Q
                   :ce :C
                   ;; Hit-enter プロンプト
                   :r "..."
                   ;; -- more -- プロンプト
                   :rm :M
                   ;; ある種の :confirm 問い合わせ
                   :r? "?"
                   ;; シェルまたは外部コマンド実行中
                   :! "!"
                   ;; 端末ジョブモード: キー入力がジョブに行く
                   :t :T}
      mode_colors {:n :red
                   :no :red
                   :nov :red
                   :noV :red
                   "no\022" :red
                   :niI :red
                   :niR :red
                   :niV :red
                   :nt :red
                   :v :blue
                   :vs :blue
                   :V :blue
                   :Vs :blue
                   "\022" :blue
                   "\022s" :blue
                   :s :purple
                   :S :purple
                   "\019" :purple
                   :i :green
                   :ic :green
                   :ix :green
                   :R :orange
                   :Rc :orange
                   :Rx :orange
                   :Rv :orange
                   :Rvc :orange
                   :Rvx :orange
                   :c :red
                   :ct :red
                   :cv :red
                   :ce :red
                   :r :red
                   :rm :red
                   :r? :red
                   :! :red
                   :t :red}
      skk_mode_labels {"" "英数"
                       :hira "ひら"
                       :kata "カナ"
                       :hankata "半カ"
                       :zenkaku "全英"
                       :abbrev :abbr} ;;
      ;; components
      align {:provider "%="}
      left_cap {:provider "▌"}
      space {:provider " "}
      bar {:provider seps.bar}
      round_right {:provider seps.right_rounded_thin}
      mode (let [;; symbol
                 readonly_symbol {:condition (fn []
                                               (or (not vim.bo.modifiable)
                                                   vim.bo.readonly))
                                  :provider (.. icons.lock " ")
                                  :hl {:fg colors.bg}}
                 vim_symbol {:provider (.. icons.vim " ") :hl {:fg colors.bg}}
                 symbol {:fallthrough false 1 readonly_symbol 2 vim_symbol}
                 ;; vim mode
                 mode_vim {:provider (fn [self]
                                       (.. (or (. mode_labels
                                                  (: self.mode :sub 1 1))
                                               (: self.mode :sub 1 1))
                                           " | "))
                           :hl (fn [self]
                                 {:fg colors.bg :bg (. mode_colors self.mode)})}
                 ;; skk mode
                 mode_skk {:init (fn [self]
                                   (set self.skk_mode
                                        (or ((. vim.fn "skkeleton#mode")) "")))
                           :provider (fn [self]
                                       (or (. skk_mode_labels self.skk_mode)
                                           self.skk_mode))
                           :hl {:fg colors.bg}}]
             {:init (fn [self] (set self.mode (vim.fn.mode 1)))
              :update [:ModeChanged]
              1 (utils.surround [icons.left_rounded icons.right_rounded]
                                (fn [self]
                                  (. mode_colors (: self.mode :sub 1 1)))
                                [symbol mode_vim mode_skk])})
      git (let [active {:condition conditions.is_git_repo
                        :init (fn [self]
                                (set self.git_status vim.b.gitsigns_status_dict))
                        ;; branch
                        1 {:provider (fn [self]
                                       (.. " " self.git_status.head))}
                        ;; changes
                        2 {1 {:provider (fn [self]
                                          (.. "  "
                                              (or self.git_status.added 0)))
                              :hl {:fg colors.git_add}}
                           2 {:provider (fn [self]
                                          (.. "  "
                                              (or self.git_status.changed 0)))
                              :hl {:fg colors.git_change}}
                           3 {:provider (fn [self]
                                          (.. "  "
                                              (or self.git_status.removed 0)))
                              :hl {:fg colors.git_del}}}}
                inactive {1 {:provider " ------"}
                          2 {1 {:provider "  -  -  -"}}}]
            {:fallthrough false 1 active 2 inactive})
      diagnostics (let [active {:condition conditions.has_diagnostics
                                :init (fn [self]
                                        (set self.errors
                                             (length (vim.diagnostic.get 0
                                                                         {:severity vim.diagnostic.severity.ERROR})))
                                        (set self.warns
                                             (length (vim.diagnostic.get 0
                                                                         {:severity vim.diagnostic.severity.WARN}))))
                                :on_click {:callback (fn []
                                                       ((. (require :trouble)
                                                           :toggle) {:mode :document_diagnostics}))
                                           :name :heirline_diagnostics}
                                :provider (fn [self]
                                            (.. icons.error " " self.errors " "
                                                icons.warn " " self.warns))}
                        inactive {:provider (.. icons.error " - " icons.warn
                                                " -")}]
                    {:fallthrough false 1 active 2 inactive})
      pomodoro {:provider (fn []
                            ((. (require :piccolo-pomodoro) :status)))
                :on_click {:callback (fn []
                                       ((. (require :piccolo-pomodoro) :toggle)))
                           :name :toggle_pomodoro}}
      search_count {:condition (fn []
                                 (and (not= vim.v.hlsearch 0)
                                      (= vim.o.cmdheight 0)))
                    :init (fn [self]
                            (let [(ok search) (pcall vim.fn.searchcount)]
                              (if (and ok search.total)
                                  (set self.search search))))
                    :provider (fn [self]
                                (string.format "[%d/%d]" self.search.current
                                               (math.min self.search.total
                                                         self.search.maxcount)))}
      ruler {:provider "%7(%l,%c%)"}
      file_properties (let [encoding {:condition (fn [self]
                                                   (set self.encoding
                                                        (or (and (not= vim.bo.fileencoding
                                                                       "")
                                                                 vim.bo.fileencoding)
                                                            vim.o.encoding nil))
                                                   self.encoding)
                                      :provider (fn [self]
                                                  (or (. self.encoding_label
                                                         self.encoding)
                                                      self.encoding))
                                      :static {:encoding_label {:utf-8 :UTF-8}}}
                            format {:condition (fn [self]
                                                 (set self.format
                                                      vim.bo.fileformat)
                                                 self.format)
                                    :provider (fn [self]
                                                (or (. self.format_label
                                                       self.format)
                                                    self.format))
                                    :static {:format_label {:dos :CRLF
                                                            :mac :CR
                                                            :unix :LF}}}]
                        {:update [:WinNew :WinClosed :BufEnter]
                         1 encoding
                         2 space
                         3 format})
      indicator (let [direnv {:provider (fn []
                                          (if is_direnv_active "  direnv "
                                              "  direnv "))}
                      lsp {:provider (fn [self]
                                       (if self.lsp_active "  LSP "
                                           "  LSP "))
                           :update [:LspAttach :LspDetach]}]
                  {:condition (fn [self]
                                (set self.lsp_active (check_lsp_attach))
                                (or self.lsp_active is_direnv))
                   :on_click {:callback (fn []
                                          (vim.defer_fn (fn []
                                                          (vim.cmd :LspInfo))
                                            100))
                              :name :heirline_lsp}
                   1 lsp
                   2 direnv})
      root (let []
             {:init (fn [self]
                      (let [cwd ((. vim.fn :fnamemodify) ((. vim.fn :getcwd))
                                                         ":t")]
                        (set self.root (or (. self.alias cwd) cwd))))
              :provider (fn [self] (.. "   %4(" self.root "%) "))
              :update [:DirChanged]
              :hl {:fg colors.bg :bg colors.orange}
              :static {:alias {"" :ROOT}}})
      help_name {:condition (fn [] (= vim.bo.filetype :help))
                 :provider (fn []
                             (vim.fn.fnamemodify (vim.api.nvim_buf_get_name 0)
                                                 ":t"))
                 :hl {:fg colors.fg}}
      terminal_name {:provider (fn []
                                 (let [(name _) (: (vim.api.nvim_buf_get_name 0)
                                                   :gsub ".*:" "")]
                                   name))
                     :hl {:fg colors.fg}} ;;
      ;; statusline
      hydra_status (let [name {:provider (fn [] (or (hydra.get_name) :HYDRA))}
                         hint {:condition hydra.get_hint
                               :provider hydra.get_hint}]
                     {:condition (fn [self]
                                   (and (hydra.is_active)
                                        (not (. self.hydra_ignore
                                                (hydra.get_name)))))
                      :static {:hydra_ignore {:BarBar true}}
                      ;; left
                      1 left_cap
                      2 (utils.surround [icons.left_rounded
                                         icons.right_rounded]
                                        (fn [] colors.cyan) [name])
                      3 align
                      ;; center
                      4 hint
                      5 align
                      ;; right
                      })
      special_status {:condition (fn []
                                   (conditions.buffer_matches {:buftype [:nofile
                                                                         :prompt
                                                                         :help
                                                                         :quickfix]
                                                               :filetype [:^git.*
                                                                          :fugative]}))
                      ;; left
                      1 left_cap
                      2 mode
                      3 align
                      ;; center
                      4 help_name
                      5 align
                      ;; right
                      6 {:provider (fn []
                                     (.. " " icons.document " "
                                         (string.upper vim.bo.filetype) " "))
                         :hl {:fg colors.bg :bg colors.blue}
                         :update [:WinNew :WinClosed :BufEnter]}}
      terminal_status {:condition (fn []
                                    (conditions.buffer_matches {:buftype [:terminal]}))
                       ;; left
                       1 left_cap
                       2 mode
                       3 align
                       ;; center
                       4 terminal_name
                       5 align
                       ;; right
                       6 {:provider (fn [] (.. " " icons.terminal " TERMINAL "))
                          :hl {:fg colors.bg :bg colors.red}
                          :update [:WinNew :WinClosed :BufEnter]}}
      default_status_line [;; left
                           left_cap
                           mode
                           space
                           git
                           round_right
                           diagnostics
                           round_right
                           pomodoro
                           align
                           ;; center
                           search_count
                           align
                           ;; right
                           ruler
                           bar
                           file_properties
                           bar
                           indicator
                           root]
      statusline {:fallthrough false
                  :hl {:fg colors.fg :bg colors.bg :bold true}
                  1 hydra_status
                  2 special_status
                  3 terminal_status
                  4 default_status_line}]
  (heirline.setup {: statusline : opts}))
