(let [M (require :harpoon)
      settings {:save_on_toggle false
                :sync_on_ui_close false
                :key (fn []
                       (vim.loop.cwd))}]
  (M:setup {: settings}))

;; v1
; (let [M (require :harpoon)
;       global_settings {:save_on_toggle false
;                        :save_on_change true
;                        :enter_on_sendcmd false
;                        :tmux_autoclose_windows false
;                        :excluded_filetypes [:harpoon]
;                        :mark_branch false
;                        :tabline false
;                        :tabline_prefix "   "
;                        :tabline_suffix "   "}]
;   (M.setup {: global_settings}))
