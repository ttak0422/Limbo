;; TODO: fix diagnostic highlits
(let [M (require :nvim-tree)
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
            ;; WIP → function
            :float {:enable false :quit_on_focus_loss true}}
      renderer {:add_trailing false
                :group_empty true
                :full_name false
                :root_folder_label false
                :indent_width 1
                :special_files [:README.md :LICENSE]
                :symlink_destination true
                :highlight_git true
                :highlight_diagnostics true
                :highlight_opened_files :icon
                :highlight_modified :icon
                :highlight_bookmarks :icon
                :highlight_clipboard :icon
                :indent_markers {:enable true
                                 :icons {:corner "└"
                                         :edge "│"
                                         :item "│"
                                         :bottom "─"
                                         :none " "}}
                :icons {:web_devicons {:file {:enable true :color false}
                                       :folder {:enable true :color false}}
                        :git_placement :before
                        :diagnostics_placement :signcolumn
                        :modified_placement :after
                        :bookmarks_placement :signcolumn
                        :padding " "
                        :symlink_arrow " ➛ "
                        :show {:file true
                               :folder true
                               :folder_arrow true
                               :git true
                               :modified true
                               :diagnostics true
                               :bookmarks true}
                        :glyphs {:default ""
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
                                       :ignored "◌"}}}}
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
                   :severity {:min vim.diagnostic.severity.HINT
                              :max vim.diagnostic.severity.ERROR}
                   :icons {:hint "" :info "" :warning "" :error ""}}
      modified {:enable true :show_on_dirs true :show_on_open_dirs true}
      filters {:git_ignored true
               :dotfiles false
               :git_clean false
               :no_buffer false
               :custom [:.DS_Store]
               :exclude []}
      live_filter {:prefix "[FILTER]: " :always_show_folders true}
      actions {:change_dir {:enable true
                            :global false
                            :restrict_above_cwd false}
               :expand_all {:max_folder_discovery 300 :exclude []}
               :file_popup {:open_win_config {:col 1
                                              :row 1
                                              :relative :cursor
                                              :border :single
                                              :style :minimal}}
               :open_file {:quit_on_open false
                           :eject true
                           :resize_window true
                           :window_picker {:enable true
                                           :picker :default
                                           ;; WIP
                                           :chars :ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890
                                           :exclude {:filetype [:notify
                                                                :packer
                                                                :qf
                                                                :diff
                                                                :fugitive
                                                                :fugitiveblame]
                                                     :buftype [:nofile
                                                               :terminal
                                                               :help]}}}
               :remove_file {:close_window true}}
      tab {:sync {:open false :close false :ignore []}}
      notify {:threshold vim.log.levels.INFO :absolute_path true}
      help {:sort_by :key}
      ui {:confirm {:remove true :trash true :default_yes false}}
      log {:enable false}
      on_attach (fn [bufnr]
                  (let [api (require :nvim-tree.api)
                        opt (fn [d]
                              {:desc d
                               :buffer bufnr
                               :noremap true
                               :silent true
                               :nowait true})
                        keys [;; BEGIN_CUSTOM_ON_ATTACH
                              [:K api.node.show_info_popup (opt :Info)]
                              [:<C-s>
                               api.node.open.horizontal
                               (opt "Open: Horizontal Split")]
                              ["]d"
                               api.node.navigate.diagnostics.next
                               (opt "Next Diagnostic")]
                              ["[e"
                               api.node.navigate.diagnostics.prev
                               (opt "Prev Diagnostic")]
                              ;; END_CUSTOM_ON_ATTACH
                              ;; BEGIN_DEFAULT_ON_ATTACH
                              ["<C-]>" api.tree.change_root_to_node (opt :CD)]
                              [:<C-e>
                               api.node.open.replace_tree_buffer
                               (opt "Open: In Place")]
                              ; [:<C-k> api.node.show_info_popup (opt :Info)]
                              [:<C-r>
                               api.fs.rename_sub
                               (opt "Rename: Omit Filename")]
                              [:<C-t> api.node.open.tab (opt "Open: New Tab")]
                              [:<C-v>
                               api.node.open.vertical
                               (opt "Open: Vertical Split")]
                              ; [:<C-x>
                              ;  api.node.open.horizontal
                              ;  (opt "Open: Horizontal Split")]
                              [:<BS>
                               api.node.navigate.parent_close
                               (opt "Close Directory")]
                              [:<CR> api.node.open.edit (opt :Open)]
                              [:<Tab>
                               api.node.open.preview
                               (opt "Open Preview")]
                              [">"
                               api.node.navigate.sibling.next
                               (opt "Next Sibling")]
                              ["<"
                               api.node.navigate.sibling.prev
                               (opt "Previous Sibling")]
                              ["." api.node.run.cmd (opt "Run Command")]
                              ["-" api.tree.change_root_to_parent (opt :Up)]
                              [:a
                               api.fs.create
                               (opt "Create File Or Directory")]
                              [:bd
                               api.marks.bulk.delete
                               (opt "Delete Bookmarked")]
                              [:bt
                               api.marks.bulk.trash
                               (opt "Trash Bookmarked")]
                              [:bmv
                               api.marks.bulk.move
                               (opt "Move Bookmarked")]
                              [:B
                               api.tree.toggle_no_buffer_filter
                               (opt "Toggle Filter: No Buffer")]
                              [:c api.fs.copy.node (opt :Copy)]
                              [:C
                               api.tree.toggle_git_clean_filter
                               (opt "Toggle Filter: Git Clean")]
                              ["[c"
                               api.node.navigate.git.prev
                               (opt "Prev Git")]
                              ["]c"
                               api.node.navigate.git.next
                               (opt "Next Git")]
                              [:d api.fs.remove (opt :Delete)]
                              [:D api.fs.trash (opt :Trash)]
                              [:E api.tree.expand_all (opt "Expand All")]
                              [:e
                               api.fs.rename_basename
                               (opt "Rename: Basename")]
                              ; ["]e"
                              ;  api.node.navigate.diagnostics.next
                              ;  (opt "Next Diagnostic")]
                              ; ["[e"
                              ;  api.node.navigate.diagnostics.prev
                              ;  (opt "Prev Diagnostic")]
                              [:F api.live_filter.clear (opt "Clean Filter")]
                              [:f api.live_filter.start (opt :Filter)]
                              [:g? api.tree.toggle_help (opt :Help)]
                              [:gy
                               api.fs.copy.absolute_path
                               (opt "Copy Absolute Path")]
                              [:H
                               api.tree.toggle_hidden_filter
                               (opt "Toggle Filter: Dotfiles")]
                              [:I
                               api.tree.toggle_gitignore_filter
                               (opt "Toggle Filter: Git Ignore")]
                              [:J
                               api.node.navigate.sibling.last
                               (opt "Last Sibling")]
                              ; [:K
                              ;  api.node.navigate.sibling.first
                              ;  (opt "First Sibling")]
                              [:m api.marks.toggle (opt "Toggle Bookmark")]
                              [:o api.node.open.edit (opt :Open)]
                              [:O
                               api.node.open.no_window_picker
                               (opt "Open: No Window Picker")]
                              [:p api.fs.paste (opt :Paste)]
                              [:P
                               api.node.navigate.parent
                               (opt "Parent Directory")]
                              [:q api.tree.close (opt :Close)]
                              [:r api.fs.rename (opt :Rename)]
                              [:R api.tree.reload (opt :Refresh)]
                              ; [:s api.node.run.system (opt "Run System")]
                              ; [:S api.tree.search_node (opt :Search)]
                              [:u api.fs.rename_full (opt "Rename: Full Path")]
                              [:U
                               api.tree.toggle_custom_filter
                               (opt "Toggle Filter: Hidden")]
                              [:W api.tree.collapse_all (opt :Collapse)]
                              [:x api.fs.cut (opt :Cut)]
                              [:y api.fs.copy.filename (opt "Copy Name")]
                              [:Y
                               api.fs.copy.relative_path
                               (opt "Copy Relative Path")]
                              [:<2-LeftMouse> api.node.open.edit (opt :Open)]
                              [:<2-RightMouse>
                               api.tree.change_root_to_node
                               (opt :CD)]
                              ;; END_DEFAULT_ON_ATTACH
                              ]]
                    (each [_ k (ipairs keys)]
                      (vim.keymap.set :n (. k 1) (. k 2) (. k 3)))))]
  (M.setup {: on_attach
            :hijack_cursor true
            :auto_reload_on_write true
            :disable_netrw false
            :hijack_netrw true
            :hijack_unnamed_buffer_when_opening false
            :root_dirs []
            :prefer_startup_root false
            :sync_root_with_cwd true
            :reload_on_bufenter false
            :respect_buf_cwd false
            :select_prompts false
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
            : log
            : on_attach}))
