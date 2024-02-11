(let [tree (require :nvim-tree)
      api (require :nvim-tree.api)
      on_attach (fn [bufnr]
                  (let [f (fn [desc]
                            {: desc
                             :buffer bufnr
                             :noremap true
                             :silent true
                             :nowait true})
                        keys [[:K api.node.show_info_popup :Info]
                              [:t api.node.open.tab "Open: New Tab"]
                              [:v api.node.open.vertical "Open: Vertical"]
                              [:s api.node.open.horizontal "Open: Horizontal"]
                              [:<BS>
                               api.node.navigate.parent_close
                               "Close Directory"]
                              [:<CR> api.node.open.edit :Open]
                              [:a api.fs.create "Create File Or Directory"]
                              ["[c" api.node.navigate.git.prev "Prev Git"]
                              ["]c" api.node.navigate.git.next "Next Git"]
                              ["[d"
                               api.node.navigate.diagnostics.prev
                               "Prev Diagnostic"]
                              ["]d"
                               api.node.navigate.diagnostics.next
                               "Next Diagnostic"]
                              [:d api.fs.remove :Delete]
                              [:D api.fs.trash :Trash]
                              [:f api.live_filter.start "Start Filter"]
                              [:F api.live_filter.clear "Clear Filter"]
                              [:g? api.tree.toggle_help :Help]
                              [:H
                               api.tree.toggle_hidden_filter
                               "Toggle Hidden"]
                              [:I
                               api.tree.toggle_hidden_filter
                               "Toggle Ignore"]
                              ["." api.node.run.cmd "Run Command"]
                              [:o api.node.open.edit :Open]
                              [:r api.fs.rename :Rename]
                              [:R api.tree.reload :Reload]]]
                    (each [_ k (ipairs keys)]
                      (vim.keymap.set :n (. k 1) (. k 2) (f (. k 3))))))
      root_dirs []
      sort {:sorter :name :folders_first true :files_first false}
      view {:centralize_selection false
            :cursorline true
            :debounce_delay 50
            :side :left
            :preserve_window_proportions false
            :number false
            :relativenumber false
            :signcolumn :yes
            :width {:min 30 :max -1 :padding 1}
            :float {:enable false :quit_on_focus_loss true}}
      renderer (let [indent_markers {:enable true
                                     :icons {:corner " "
                                             :edge " "
                                             :item " "
                                             :bottom " "
                                             :none " "}}
                     web_devicons {:file {:enable true :color false}
                                   :folder {:enable true :color false}}
                     show {:file true
                           :folder true
                           :folder_arrow true
                           :git true
                           :modified true
                           :diagnostics true
                           :bookmarks true}
                     glyphs {:default ""
                             :symlink ""
                             :modified "●"
                             :folder {:arrow_closed ""
                                      :arrow_open ""
                                      :default ""
                                      :open ""
                                      :empty ""
                                      :empty_open ""
                                      :symlink ""
                                      :symlink_open ""}
                             :git {:unstaged "✗"
                                   :staged "✓"
                                   :unmerged ""
                                   :renamed "➜"
                                   :untracked "★"
                                   :deleted ""
                                   :ignored "◌"}}
                     icons {:git_placement :before
                            :diagnostics_placement :signcolumn
                            :modified_placement :after
                            :bookmarks_placement :signcolumn
                            :padding " "
                            :symlink_arrow " ➛ "
                            : web_devicons
                            : show
                            : glyphs}]
                 {:add_trailing false
                  :group_empty true
                  :full_name false
                  :root_folder_label false
                  :indent_width 1
                  :special_files [:README.md :LICENSE]
                  :symlink_destination true
                  :highlight_git :name
                  :highlight_diagnostics :name
                  :highlight_opened_files :none
                  :highlight_modified :none
                  :highlight_bookmarks :none
                  :highlight_clipboard :none
                  : indent_markers
                  : icons})
      hijack_directories {:enable true :auto_open true}
      update_focused_file {:enable true :update_root false}
      git {:enable true
           :show_on_dirs true
           :show_on_open_dirs true
           :disable_for_dirs []
           :timeout 500
           :cygwin_support false}
      diagnostics {:enable true
                   :debounce_delay 100
                   :show_on_dirs false
                   :show_on_open_dirs true
                   :severity {:min vim.diagnostic.severity.INFO
                              :max vim.diagnostic.severity.ERROR}
                   :icons {:hint "" :info "" :warning "" :error ""}}
      modified {:enable true :show_on_dirs true :show_on_open_dirs true}
      filters {:git_ignored false
               :dotfiles false
               :git_clean false
               :no_buffer false
               :custom [:.DS_Store :.git]
               :exclude []}
      live_filter {:prefix "[FILTER]: " :always_show_folders true}
      actions (let [change_dir {:enable true
                                :global false
                                :restrict_above_cwd false}
                    expand_all {:max_folder_discovery 300 :exclude []}
                    file_popup {:open_win_config {:col 1
                                                  :row 1
                                                  :relative :cursor
                                                  :border :single
                                                  :style :minimal}}
                    open_file {:quit_on_open false
                               :eject true
                               :resize_window true
                               :window_picker {:enable true
                                               :picker :default
                                               :chars :ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890
                                               :exclude {:filetype [:notify
                                                                    :qf]
                                                         :buftype [:nofile
                                                                   :terminal
                                                                   :help]}}}
                    remove_file {:close_window true}]
                {: change_dir
                 : expand_all
                 : file_popup
                 : open_file
                 : remove_file})
      tab {:sync {:open false :close false :ignore []}}
      notify {:threshold vim.log.levels.INFO :absolute_path true}
      help {:sort_by :key}
      ui {:confirm {:remove true :trash true :default_yes false}}
      log {:enable false}
      default_cursor vim.opt.guicursor]
  (tree.setup {:hijack_cursor true
               :auto_reload_on_write true
               :disable_netrw true
               :hijack_netrw true
               :hijack_unnamed_buffer_when_opening false
               :prefer_startup_root false
               :sync_root_with_cwd true
               :reload_on_bufenter false
               :respect_buf_cwd false
               :select_prompts true
               : on_attach
               : root_dirs
               : sort
               : view
               : renderer
               : hijack_directories
               : update_focused_file
               : git
               : diagnostics
               : modified
               : filters
               : live_filter
               : actions
               : tab
               : notify
               : help
               : ui
               : log})
  (vim.api.nvim_create_autocmd [:WinEnter :BufWinEnter]
                               {:pattern :NvimTree*
                                :callback (fn []
                                            (let [def (vim.api.nvim_get_hl_by_name :Cursor
                                                                                   true)]
                                              (vim.api.nvim_set_hl 0 :Cursor
                                                                   (vim.tbl_extend :force
                                                                                   def
                                                                                   {:blend 100}))
                                              (: vim.opt.guicursor :append
                                                 "a:Cursor/lCursor")))})
  (vim.api.nvim_create_autocmd [:BufLeave :WinClosed]
                               {:pattern :NvimTree*
                                :callback (fn []
                                            (let [def (vim.api.nvim_get_hl_by_name :Cursor
                                                                                   true)]
                                              (vim.api.nvim_set_hl 0 :Cursor
                                                                   (vim.tbl_extend :force
                                                                                   def
                                                                                   {:blend 0}))
                                              (set vim.opt.guicursor
                                                   default_cursor)))}))
