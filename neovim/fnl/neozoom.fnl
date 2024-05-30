(let [M (require:neo-zoom)
      exclude_buftypes []
      winopts {:offset {:height 0.9}
               ; :border ["┏" "━" "┓" "┃" "┛" "━" "┗" "┃"]
               :border :none}
      presets [{:filetypes [:dapui_.* :dap-repl]
                :config {:top_ratio 0.25
                         :left_ratio 0.4
                         :width_ratio 0.6
                         :height_ratio 0.65}
                :callbacks [(fn []
                              (set vim.wo.wrap true))]}]
      popup {:enabled true}]
  (M.setup {: exclude_buftypes : winopts : popup : presets}))
