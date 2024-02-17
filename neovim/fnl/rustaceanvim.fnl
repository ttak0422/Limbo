(let [server {:on_attach (dofile args.on_attach_path)}
      tools (let [executors (require :rustaceanvim.executors)
                  code_actions {:ui_select_fallback true}
                  float_win_config {:border ["┏"
                                             "━"
                                             "┓"
                                             "┃"
                                             "┛"
                                             "━"
                                             "┗"
                                             "┃"]}]
              {: executors : code_actions : float_win_config})]
  (set vim.g.rustaceanvim {: server : tools} ))
