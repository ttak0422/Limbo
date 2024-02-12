(let [M (require :noice)
      U (require :noice.util)
      L (require :noice.lsp)
      cmdline (let [opts {:zindex 95
                          ;; relative  :cursor
                          ;; position  [ row  0 col  0 ]
                          }
                    format {:cmdline {:pattern "^:"
                                      :icon ""
                                      :lang :vim
                                      :title ""}
                            :search_down {:kind :search
                                          :pattern "^/"
                                          :icon " "
                                          :lang :regex
                                          :title ""}
                            :search_up {:kind :search
                                        :pattern "^%?"
                                        :icon " "
                                        :lang :regex
                                        :title ""}
                            :filter {:pattern "^:%s*!"
                                     :icon "$"
                                     :lang :bash
                                     :title ""}
                            :lua {:pattern "^:%s*lua%s+"
                                  :icon ""
                                  :lang :lua
                                  :title ""}
                            :help {:pattern "^:%s*he?l?p?%s+"
                                   :icon "?"
                                   :title ""}
                            :input {}}]
                {:enabled true :view :cmdline : opts : format})
      messages {:enabled true
                :view :notify
                :view_error :notify
                :view_warn :notify
                :view_history :messages
                :view_search :virtualtext}
      popupmenu {:enabled true :backend :nui :kind_icons {}}
      redirect {:view :popup :filter {:event :msg_show}}
      commands (let [history {:view :split
                              :opts {:enter true :format :details}
                              :filter {:any [{:event :notify}
                                             {:error true}
                                             {:warning true}
                                             {:event :msg_show :kind [""]}
                                             {:event :lsp :kind :message}]}}
                     last {:view :popup
                           :opts {:enter true :format :details}
                           :filter {:any [{:event :notify}
                                          {:error true}
                                          {:warning true}
                                          {:event :msg_show :kind [""]}
                                          {:event :lsp :kind :message}]}
                           :filter_opts {:count 1}}
                     errors {:view :popup
                             :opts {:enter true :format :details}
                             :filter {:error true}
                             :filter_opts {:reverse true}}]
                 {: history : last : errors})
      notify {:enabled true :view :notify}
      lsp (let [progress {;; use fidget-nvim
                          :enabled false}
                override [:vim.lsp.util.convert_input_to_markdown_lines
                          true
                          :vim.lsp.util.stylize_markdown
                          true]
                hover {:enabled true :silent true :view :hover :opts {}}
                signature {;; use ddc-vim
                           :enabled false}
                message {:enabled true :view :notify :opts {}}
                documentation {:view :hover
                               :opts {:lang :markdown
                                      :replace true
                                      :render :plain
                                      :format ["{message}"]
                                      :win_options {:concealcursor :n
                                                    :conceallevel 3}}}]
            {: progress
             : override
             : hover
             : signature
             : message
             : documentation})
      markdown {:hover ["|(%S-)|" vim.cmd.help "%[.-%]%((%S-)%)" U.open]
                :highlights ["|%S-|"
                             "@text.reference"
                             "@%S+"
                             "@parameter"
                             "^%s*(Parameters:)"
                             "@text.title"
                             "^%s*(Return:)"
                             "@text.title"
                             "^%s*(See also:)"
                             "@text.title"
                             "{%S-}"
                             "@parameter"]}
      health {:checker true}
      smart_move {:excluded_filetypes (dofile args.exclude_ft_path)}
      presets {:bottom_search true
               :command_palette false
               :long_message_to_split true
               :inc_rename false
               :lsp_doc_border true}
      throttle (/ 1000 30)
      views (let [border ["┏" "━" "┓" "┃" "┛" "━" "┗" "┃"]
                  cmdline_popup {:border {:style border}
                                 :filter_options {}
                                 :win_options {:winhighlight {:Normal :NormalFloat
                                                              :FloatBorder :FloatBorder}}}
                  hover {:border {:style border}}]
              {: cmdline_popup : hover})
      routes [{:filter {:event :msg_show
                        :any [{:find "%d+L %d+B"}
                              {:find "; after #%d+"}
                              {:find "; before #%d+"}
                              {:find "; 前方 #%d+"}
                              {:find "; 後方 #%d+"}
                              {:find "番目の該当"}
                              {:find "唯一の該当"}
                              {:find "始めに戻る"}
                              {:find "%d fewer lines"}
                              {:find "%d more lines"}
                              {:find "書込み$"}]}
               :opts {:skip true}}]]
  (M.setup {: cmdline
            : messages
            : popupmenu
            : redirect
            : commands
            : notify
            : lsp
            : markdown
            : health
            : smart_move
            : presets
            : throttle
            : views
            : routes})
  (vim.keymap.set [:n :i :s] :<C-f> (fn [] (if (L.scroll 4) :<C-f>))
                  {:silent true :expr true})
  (vim.keymap.set [:n :i :s] :<C-b> (fn [] (if (L.scroll 4) :<C-b>))
                  {:silent true :expr true}))
