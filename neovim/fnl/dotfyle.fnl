(let [M (require :dotfyle_metadata)]
  (set M.dotfyle_path (.. (vim.fn.getcwd) :/dotfyle.json)))
