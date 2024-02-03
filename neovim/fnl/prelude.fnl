(let [cache-path (vim.fn.stdpath :cache)
      opts {;; 日本語の優先度を上げる
            :helplang "ja,en"
            ;; マウス操作
            :mouse :a
            ;; 大文字・小文字を区別しない
            :ignorecase true
            ;; 大文字検索時に通常検索
            :smartcase true
            ;; 検索結果をハイライトする
            :hlsearch true
            ;; インクリメンタル検索
            :incsearch true
            ;; 未保存のバッファ切り替えを許容
            :hidden true
            ;; guifg, guibgの有効化
            :termguicolors true
            ;; モードを非表示
            :showmode false
            ;; 外部で更新されたファイルを自動再読み込み
            :autoread true
            ;; 入力時に対応する括弧を強調
            :showmatch true
            ;; デフォルトモーションで移動時に日空白文字列に移動
            :startofline false
            ;; 補完オプション
            :completeopt (.. :menuone "," :preview)
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
            ;; undofile
            :undofile true
            :undodir (.. cache-path :/undo)
            ;; swapfile
            :swapfile true
            :directory (.. cache-path :/swap)
            ;; カレントウィンドウの最小幅
            :winwidth 20
            ;; カレントウィンドウの最小高
            :winheight 1
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
            ;; ウィンドウ分割時にサイズを均等にしようとしない
            :equalalways false
            ;; backup
            :backup true
            ;; inodeの挙動変更
            :backupcopy :yes
            :backupdir (.. cache-path :/backup)
            ;; diffの挙動制御
            :diffopt "internal,filler,closeoff,vertical"}
      disable_plugins [;; https://qiita.com/yasunori-kirin0418/items/4672919be73a524afb47
                       ;; DisableTOhtml.
                       :loaded_2html_plugin
                       ;; Disablearchivefileopenandbrowse.
                       :loaded_gzip
                       :loaded_tar
                       :loaded_tarPlugin
                       :loaded_zip
                       :loaded_zipPlugin
                       ;; Disablevimball.
                       :loaded_vimball
                       :loaded_vimballPlugin
                       ;; Disablenetrwplugins.
                       :loaded_netrw
                       :loaded_netrwPlugin
                       :loaded_netrwSettings
                       :loaded_netrwFileHandlers
                       ;; Disable`GetLatestVimScript`.
                       :loaded_getscript
                       :loaded_getscriptPlugin
                       ;; Disableotherplugins
                       :loaded_man
                       :loaded_matchit
                       :loaded_matchparen
                       :loaded_shada_plugin
                       :loaded_spellfile_plugin
                       :loaded_tutor_mode_plugin
                       :did_install_default_menus
                       :did_install_syntax_menu
                       :skip_loading_mswin
                       :did_indent_on
                       :did_load_ftplugin
                       :loaded_rrhelper]]
  (set vim.g.loaded_perl_provider 0)
  (vim.loader.enable)
  ;; オプションの適用
  (each [k v (pairs opts)]
    (tset vim.o k v))
  ;; 無効化
  (each [_ p (ipairs disable_plugins)]
    (tset vim.g p 1)))
