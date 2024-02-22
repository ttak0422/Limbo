(let [opts {;; guifg, guibgの有効化
            :termguicolors true
            ;; モードを非表示
            :showmode false
            ;; 入力時に対応する括弧を強調
            :showmatch true
            ;; 補完オプション
            ;; :completeopt (.. :menu "," :menuone "," :preview)
            :completeopt ""
            ;; 行数表示
            :number true
            ;; signcolumnのがたつきを無くす
            :signcolumn :yes
            ;; 短径選択を寛容に
            :virtualedit :block
            ;; コマンドライン非表示
            :cmdheight 0
            ;; ステータスラインを集約
            :laststatus 3
            ;; tablineを常に表示する
            :showtabline 2
            ;; タブでスペースを入力
            :expandtab true
            ;; タブ幅を2
            :tabstop 2
            ;; インデント幅
            :shiftwidth 2
            :foldcolumn :1
            :foldlevel 99
            :foldlevelstart 99
            :foldenable true
            :fillchars "eob: ,fold: ,foldopen:,foldsep: ,foldclose:"
            :cursorline true}
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
