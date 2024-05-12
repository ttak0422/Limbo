(let [neorg (require :neorg)
      completion {:engine :nvim-cmp}
      defaults {:disable []}
      dirman {:workspaces {:notes "~/neorg"} :default_workspace :notes}
      keybinds {:default_keybinds false
                :neorg_leader :<LocalLeader>
                :hook (fn [keybinds]
                        (let [leader keybinds.leader
                              norg_keymap_n []
                              norg_keymap_i []
                              norg_event_n [[(.. leader :e)
                                             :core.looking-glass.magnify-code-block]
                                            [(.. leader :tu)
                                             :core.qol.todo_items.todo.task_undone]
                                            [(.. leader :tp)
                                             :core.qol.todo_items.todo.task_pending]
                                            [(.. leader :td)
                                             :core.qol.todo_items.todo.task_done]
                                            [(.. leader :th)
                                             :core.qol.todo_items.todo.task_on_hold]
                                            [(.. leader :tc)
                                             :core.qol.todo_items.todo.task_cancelled]
                                            [(.. leader :tr)
                                             :core.qol.todo_items.todo.task_recurring]
                                            [(.. leader :ti)
                                             :core.qol.todo_items.todo.task_important]
                                            [(.. leader :ta)
                                             :core.qol.todo_items.todo.task_ambiguous]
                                            [:<C-Space>
                                             :core.qol.todo_items.todo.task_cycle]
                                            [(.. leader :nn)
                                             :core.dirman.new.note]
                                            [:<CR>
                                             :core.esupports.hop.hop-link]
                                            [:gd :core.esupports.hop.hop-link]
                                            [:gf :core.esupports.hop.hop-link]
                                            [:gF :core.esupports.hop.hop-link]
                                            [">>" :core.promo.promote]
                                            ["<<" :core.promo.demote]
                                            [:lt :core.pivot.toggle-list-type]
                                            [:li :core.pivot.invert-list-type]
                                            ;; telescope (defined in global)
                                            ; [(.. leader :f)
                                            ;  :core.integrations.telescope.find_linkable]
                                            ]
                              norg_event_i [[:<C-t> :core.promo.promote]
                                            [:<C-d> :core.promo.demote]
                                            ;; telescope
                                            [:<C-i>
                                             :core.integrations.telescope.insert_link]]]
                          (each [_ [key cmd] (ipairs norg_keymap_n)]
                            (keybinds.map :norg :n key cmd))
                          (each [_ [key cmd] (ipairs norg_keymap_i)]
                            (keybinds.map :norg :i key cmd))
                          (each [_ [key ev] (ipairs norg_event_n)]
                            (keybinds.remap_event :norg :n key ev))
                          (each [_ [key ev] (ipairs norg_event_i)]
                            (keybinds.remap_event :norg :i key ev))))}
      journal {:journal_folder :journal :strategy :nested}
      metagen {:type :auto}
      templates {:templates_dir [] :default_subcommand :fload}
      load {:core.autocommands {}
            :core.completion {:config completion}
            :core.defaults {:config defaults}
            :core.dirman {:config dirman}
            :core.integrations.nvim-cmp {}
            :core.integrations.treesitter {}
            :core.keybinds {:config keybinds}
            :core.storage {}
            :core.summary {}
            :core.ui {}
            :core.journal {:config journal}
            :core.esupports.metagen {:config metagen}
            ; :core.concealer {} ;; WIP: https://github.com/nvim-neorg/neorg/issues/1393
            ; :core.tempus {} ;; MEMO: require nvim 0.10+
            ; :core.ui.calendar {} ;; MEMO: require core.tempus
            :core.integrations.telescope {}
            ;; WIP
            :external.jupyter {}
            :external.templates {:config templates}}
      cmp (require :cmp)
      sources (cmp.config.sources [{:name :neorg}] [{:name :buffer}])]
  (neorg.setup {: load})
  (cmp.setup.filetype :norg {: sources}))
