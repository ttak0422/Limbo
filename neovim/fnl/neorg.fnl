(let [neorg (require :neorg)
      callbacks (require :neorg.core.callbacks)
      completion {:engine :nvim-cmp}
      defaults {:disable []}
      dirman {:workspaces {:notes "~/neorg"
                           ;; WIP
                           :dotfiles "~/ghq/github.com/ttak0422/Limbo/notes"}
              :default_workspace :notes}
      leader :<LocalLeader>
      cmd (fn [c]
            (.. :<Cmd> c :<CR>))
      normal_keys {:<LocalLeader>to (cmd "Neorg journal toc open")
                   :<LocalLeader>tO (cmd "Neorg toc")}
      normal_events [[:<C-Space> :core.qol.todo_items.todo.task_cycle]
                     [:<CR> :core.esupports.hop.hop-link]
                     {1 :<M-CR>
                      2 :core.esupports.hop.hop-link
                      3 :vsplit
                      :opts {:desc " Jump to Link (Vertical Split)"}}
                     {1 (.. leader :e)
                      2 :core.looking-glass.magnify-code-block
                      :opts {:desc " Edit Code Block"}}
                     {1 (.. leader :lt)
                      2 :core.pivot.toggle-list-type
                      :opts {:desc " Toggle List Type"}}
                     {1 (.. leader :li)
                      2 :core.pivot.invert-list-type
                      :opts {:desc " Invert List Type"}}]
      insert_events [[:<C-i> :core.integrations.telescope.insert_link]]
      key_opts {:silent true}
      keybinds {:default_keybinds false
                :neorg_leader :<LocalLeader>
                :hook (fn [kb]
                        (each [key cmd (pairs normal_keys)]
                          (kb.map :norg :n key cmd)))}
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
  (callbacks.on_event :core.keybinds.events.enable_keybinds
                      (fn [_ kb]
                        (kb.map_event_to_mode :norg
                                              {:n normal_events
                                               :i insert_events}
                                              key_opts)))
  (cmp.setup.filetype :norg {: sources}))


