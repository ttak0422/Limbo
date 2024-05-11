(let [neorg (require :neorg)
      completion {:engine :nvim-cmp}
      defaults {:disable []}
      dirman {:workspaces {:notes "~/notes"} :default_workspace :notes}
      keybinds {:default_keybinds false}
      load {:core.autocommands {}
            :core.completion {:config completion}
            ; :core.concealer {} ;; WIP: https://github.com/nvim-neorg/neorg/issues/1393
            :core.defaults {:config defaults}
            :core.dirman {:config dirman}
            :core.integrations.nvim-cmp {}
            :core.integrations.treesitter {}
            :core.keybinds {:config keybinds}
            :core.storage {}
            :core.summary {}
            :core.ui {}
            ; :core.tempus {} ;; MEMO: require nvim 0.10+
            ; :core.ui.calendar {} ;; MEMO: require core.tempus
            }
      cmp (require :cmp)
      sources (cmp.config.sources [{:name :neorg}] [{:name :buffer}])]
  (neorg.setup {: load})
  (cmp.setup.filetype :norg {: sources}))
