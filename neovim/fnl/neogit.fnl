(let [M (require :neogit)
      integrations {:telescope true :diffview true :fzf_lua nil}]
  (M.setup {:use_default_keymaps true
            :disable_hint false
            :disable_context_highlighting false
            :disable_signs false
            :graph_style :unicode
            :console_timeout 10000
            : integrations}))
