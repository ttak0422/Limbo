(let [M (require :legendary)
      keymaps []
      commands [{1 ":UpdateRemotePlugins"
                 :description "[REQUIRE] every time a remote plugin is installed updated or deleted"}
                {1 ":write | edit | TSBufEnable highlight"
                 :description "reload file"}
                {1 ":so $VIMRUNTIME/syntax/hitest.vim"
                 :description "enumerate highlight"}
                {1 ":call denops#plugin#reload('ddc')"
                 :description "[WIP] reload ddc"}]
      functions []
      autocmds []]
  (M.setup {:include_builtin false
            :include_legendary_cmds false
            :col_separator_char ""
            : keymaps
            : commands
            : functions
            : autocmds}))
