;; require `npm install -g @vtsls/language-server`
(let [M (require :vtsls)
      lspconfig (require :lspconfig)
      node_root_dir (lspconfig.util.root_pattern :package.json)
      is_node_repo (not= (node_root_dir (vim.api.nvim_buf_get_name 0)) nil)]
  (if is_node_repo
      (M.config {:refactor_auto_rename true})))
