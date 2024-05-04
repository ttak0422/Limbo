(let [cmp (require :cmp)
      types (require :cmp.types)
      compare (require :cmp.config.compare)
      luasnip (require :luasnip)
      snippet {:expand (fn [args]
                         (luasnip.lsp_expand args.body))}
      performance {:debounce 100
                   :throttle 100
                   :fetching_timeout 500
                   :confirm_resolve_timeout 80
                   :async_budget 1
                   :max_view_entries 100}
      preselect types.cmp.PreselectMode.Item
      mapping (let [m cmp.mapping
                    behavior cmp.SelectBehavior.Select]
                {:<C-d> (m.scroll_docs -4)
                 :<C-f> (m.scroll_docs 4)
                 :<C-n> (m.select_next_item {: behavior})
                 :<C-p> (m.select_prev_item {: behavior})
                 :<C-y> (m.confirm {:select true})
                 :<C-e> (m.abort)
                 ;; insert・select only
                 :<C-k> (m (fn [fallback]
                             (if (luasnip.expand_or_jumpable)
                                 (luasnip.expand_or_jump)
                                 (fallback)))
                           [:i :s])
                 :<C-l> (m (fn [fallback]
                             (if (luasnip.expand_or_jumpable)
                                 (luasnip.expand_or_jump)
                                 (fallback)))
                           [:i :s])
                 ;; source mapping
                 :<C-x> (m.complete)
                 :<C-x><C-x> (m.complete)
                 :<C-x><C-f> (m.complete {:config {:sources [{:name :path}]}})
                 :<C-x><C-b> (m.complete {:config {:sources [{:name :buffer}]}})
                 :<C-x><C-l> (m.complete {:config {:sources [{:name :nvim_lsp}]}})})
      completion {:autocomplete [types.cmp.TriggerEvent.TextChanged]
                  :completeopt "menu,menuone,noselect"
                  :keyword_length 2}
      formatting {:expandable_indicator true
                  :fields [:abbr :kind :menu]
                  :format (fn [_ item] item)}
      matching {:disallow_fuzzy_matching false
                :disallow_fullfuzzy_matching false
                :disallow_partial_fuzzy_matching true
                :disallow_partial_matching false
                :disallow_prefix_unmatching false
                :disallow_symbol_nonprefix_matching true}
      sorting {:priority_weight 2
               :comparators [compare.offset
                             compare.exact
                             ;; compare.scopes
                             compare.score
                             compare.recently_used
                             compare.locality
                             compare.kind
                             ;; compare.sort_text
                             compare.length
                             compare.order]}
      sources [{:name :nvim_lsp} {:name :luasnip} {:name :buffer}]
      confirmation {:default_behavior types.cmp.ConfirmBehavior.Insert
                    :get_commit_characters (fn [commit_cs] commit_cs)}
      event []
      experimental {:ghost_text false}
      view (let [entries {:name :custom
                          :selection_order :top_down
                          :follow_cursor false}
                 docs {:auto_open true}]
             {: entries : docs})
      window (let [border ["┏" "━" "┓" "┃" "┛" "━" "┗" "┃"]
                   completion (cmp.config.window.bordered {: border})
                   documentation (cmp.config.window.bordered {: border})]
               {: completion : documentation})]
  (cmp.setup {: snippet
              : performance
              : preselect
              : mapping
              : completion
              : formatting
              : matching
              : sorting
              : sources
              : confirmation
              : event
              : experimental
              : view
              : window})
  (vim.cmd "inoremap <expr> <C-Space> '<C-n>'")
  (cmp.setup.cmdline "/" {:mapping (cmp.mapping.preset.cmdline)
                          :sources [{:name :buffer}]})
  (cmp.setup.cmdline "?" {:mapping (cmp.mapping.preset.cmdline)
                          :sources [{:name :buffer}]})
  (cmp.setup.cmdline ":" {:mapping (cmp.mapping.preset.cmdline)
                          :sources [{:name :cmdline}
                                    {:name :cmdline_history}
                                    {:name :buffer}]}))
