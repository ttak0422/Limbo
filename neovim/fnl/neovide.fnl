(let [m vim.keymap.set
      scale 1.1
      change_scale (fn [delta]
                     (set vim.g.neovide_scale_factor
                          (* vim.g.neovide_scale_factor delta)))
      toggle_zoom (fn []
                    (set vim.g.neovide_fullscreen
                         (not vim.g.neovide_fullscreen)))]
  (do
    (m [:n :i :c :t] "¥" "\\")
    (m :n :<C-+> (fn [] (change_scale scale)))
    (m :n :<C--> (fn [] (change_scale (/ 1 scale))))
    (m :n :<A-Enter> toggle_zoom)
    (vim.api.nvim_create_user_command :ToggleNeovideFullScreen toggle_zoom {})))
