(let [M (require :notify)
      get_option vim.api.nvim_get_option
      max_height (fn []
                   (/ (get_option :lines) 3))
      max_width (fn []
                  (* (/ (get_option :columns) 3) 2))]
  (M.setup {:timeout 2500
            :render :wrapped-compact
            :top_down false
            :stages :static
            :background_colour "#000000"
            : max_height
            : max_width})
  (set vim.notify M))
