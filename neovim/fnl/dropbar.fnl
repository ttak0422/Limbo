(let [dropbar (require :dropbar)
      utils (require :dropbar.utils)
      api (require :dropbar.api)
      sources (require :dropbar.sources)
      general (let [attach_events [:OptionSet :BufWinEnter :BufWritePost]
                    update_events {:win [:CursorMoved
                                         :InsertLeave
                                         ;; "CursorMovedI"
                                         :WinEnter
                                         :WinResized]
                                   :buf [:BufModifiedSet
                                         :FileChangedShellPost
                                         :TextChanged
                                         :TextChangedI]
                                   :global [:DirChanged :VimResized]}]
                {: attach_events : update_events :update_interval 100})
      icons (let [kinds {:use_devicons true
                         :symbols {:Array "󰅪 "
                                   :Boolean " "
                                   :BreakStatement "󰙧 "
                                   :Call "󰃷 "
                                   :CaseStatement "󱃙 "
                                   :Class " "
                                   :Color "󰏘 "
                                   :Constant "󰏿 "
                                   :Constructor " "
                                   :ContinueStatement "→ "
                                   :Copilot " "
                                   :Declaration "󰙠 "
                                   :Delete "󰩺 "
                                   :DoStatement "󰑖 "
                                   :Enum " "
                                   :EnumMember " "
                                   :Event " "
                                   :Field " "
                                   :File "󰈔 "
                                   :Folder "󰉋 "
                                   :ForStatement "󰑖 "
                                   :Function "󰊕 "
                                   :H1Marker "󰉫 "
                                   :H2Marker "󰉬 "
                                   :H3Marker "󰉭 "
                                   :H4Marker "󰉮 "
                                   :H5Marker "󰉯 "
                                   :H6Marker "󰉰 "
                                   :Identifier "󰀫 "
                                   :IfStatement "󰇉 "
                                   :Interface " "
                                   :Keyword "󰌋 "
                                   :List "󰅪 "
                                   :Log "󰦪 "
                                   :Lsp " "
                                   :Macro "󰁌 "
                                   :MarkdownH1 "󰉫 "
                                   :MarkdownH2 "󰉬 "
                                   :MarkdownH3 "󰉭 "
                                   :MarkdownH4 "󰉮 "
                                   :MarkdownH5 "󰉯 "
                                   :MarkdownH6 "󰉰 "
                                   :Method "󰆧 "
                                   :Module "󰏗 "
                                   :Namespace "󰅩 "
                                   :Null "󰢤 "
                                   :Number "󰎠 "
                                   :Object "󰅩 "
                                   :Operator "󰆕 "
                                   :Package "󰆦 "
                                   :Pair "󰅪 "
                                   :Property " "
                                   :Reference "󰦾 "
                                   :Regex " "
                                   :Repeat "󰑖 "
                                   :Scope "󰅩 "
                                   :Snippet "󰩫 "
                                   :Specifier "󰦪 "
                                   :Statement "󰅩 "
                                   :String "󰉾 "
                                   :Struct " "
                                   :SwitchStatement "󰺟 "
                                   :Terminal " "
                                   :Text " "
                                   :Type " "
                                   :TypeParameter "󰆩 "
                                   :Unit " "
                                   :Value "󰎠 "
                                   :Variable "󰀫 "
                                   :WhileStatement "󰑖 "}}
                  ui {:bar {:separator " " :extends "…"}
                      :menu {:separator " " :indicator " "}}]
              {:enable true : kinds : ui})
      bar {:hover true
           :sources (fn [buf _]
                      (let [ft (. (. vim.bo buf) :filetype)
                            buftype (. (. vim.bo buf) :buftype)]
                        (if (= ft :markdown) [sources.path sources.markdown]
                            (if (= buftype :terminal) [sources.terminal]
                                [sources.path
                                 ; (utils.source.fallback [
                                 ;                        sources.lsp
                                 ;                         sources.treesitter])
                                 ]))))
           :padding {:left 1 :right 1}
           :pick {:pivots :abcdefghijklmnopqrstuvwxyz}
           :truncate true}
      menu (let [select (fn []
                          (let [menu (utils.menu.get_current)]
                            (if menu
                                (let [cursor (vim.api.nvim_win_get_cursor menu.win)
                                      c1 (. cursor 1)
                                      c2 (. cursor 2)
                                      component (: (. menu.entries c1)
                                                   :first_clickable c2)]
                                  (if component
                                      (: menu :click_on component nil 1 :l))))))
                 keymaps {:<CR> select
                          :o select
                          :zf (fn []
                                (let [menu (utils.menu.get_current)]
                                  (if menu (: menu :fuzzy_find_open))))}
                 win_configs {:border :single :style :minimal}]
             {:preview true
              :quick_navigation true
              :entry {:padding {:left 1 :right 1}}
              :scrollbar {:enable true :background true}
              : keymaps
              : win_configs})
      fzf (let [keymaps {:<C-p> api.fuzzy_find_prev
                         :<C-n> api.fuzzy_find_next
                         :<CR> api.fuzzy_find_click}]
            {: keymaps})]
  (dropbar.setup {: general : icons : bar : menu : fzf}))
