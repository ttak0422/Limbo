(let [tshjkl (require :tshjkl)
      keymaps {:toggle :<Leader><CR>
               :parent :h
               :next :j
               :prev :k
               :child :l
               :toggle_named :<S-M-n>}
      marks {:parent {:hl_group :Comment}
             :child {:hl_group :Error}
             :next {:hl_group :InfoFloat}
             :current {:hl_group :Substitute}}]
  (tshjkl.setup {:select_current_node true : keymaps : marks}))
