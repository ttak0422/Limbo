(let [opts {;; guifg, guibgの有効化
            :termguicolors true
            ;; モードを非表示
            :showmode false
            ;; 起動時に行数を非表示表示
            :number false
            ;; signcolumnを起動時に非表示
            :signcolumn :no
            ;; tablineを起動時に非表示
            :showtabline 0}
      ; disable_plugins [;; https://qiita.com/yasunori-kirin0418/items/4672919be73a524afb47
      ;                  ;; DisableTOhtml.
      ;                  :loaded_2html_plugin
      ;                  ;; Disablearchivefileopenandbrowse.
      ;                  :loaded_gzip
      ;                  :loaded_tar
      ;                  :loaded_tarPlugin
      ;                  :loaded_zip
      ;                  :loaded_zipPlugin
      ;                  ;; Disablevimball.
      ;                  :loaded_vimball
      ;                  :loaded_vimballPlugin
      ;                  ;; Disablenetrwplugins.
      ;                  :loaded_netrw
      ;                  :loaded_netrwPlugin
      ;                  :loaded_netrwSettings
      ;                  :loaded_netrwFileHandlers
      ;                  ;; Disable`GetLatestVimScript`.
      ;                  :loaded_getscript
      ;                  :loaded_getscriptPlugin
      ;                  ;; Disableotherplugins
      ;                  :loaded_man
      ;                  :loaded_matchit
      ;                  :loaded_matchparen
      ;                  :loaded_shada_plugin
      ;                  :loaded_spellfile_plugin
      ;                  :loaded_tutor_mode_plugin
      ;                  :did_install_default_menus
      ;                  :did_install_syntax_menu
      ;                  :skip_loading_mswin
      ;                  :did_indent_on
      ;                  :did_load_ftplugin
      ;                  :loaded_rrhelper]
      ]
  (set vim.g.loaded_perl_provider 0)
  (vim.loader.enable)
  ;; オプションの適用
  (each [k v (pairs opts)]
    (tset vim.o k v))
  ;; 無効化 ; (each [_ p (ipairs disable_plugins)] ;   (tset vim.g p 1))
  )
