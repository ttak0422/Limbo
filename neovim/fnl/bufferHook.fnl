(let [cache-path (vim.fn.stdpath :cache)
      opts {;; 日本語の優先度を上げる
            :helplang "ja,en"
            ;; マウス操作
            :mouse :a
            ;; 未保存のバッファ切り替えを許容
            :hidden true
            ;; 外部で更新されたファイルを自動再読み込み
            :autoread true
            ;; デフォルトモーションで移動時に日空白文字列に移動
            :startofline false
            ;; undofile
            :undofile true
            :undodir (.. cache-path :/undo)
            ;; swapfile
            :swapfile true
            :directory (.. cache-path :/swap)
            ;; backup
            :backup true
            ;; inodeの挙動変更
            :backupcopy :yes
            :backupdir (.. cache-path :/backup)
            ;; diffの挙動制御
            :diffopt "internal,filler,closeoff,vertical"
            ;; 分割の挙動を変更
            :splitright true
            :splitbelow true
            ;; ウィンドウ分割時にサイズを均等にしようとしない
            :equalalways false
            ;; カレントウィンドウの最小幅
            :winwidth 20
            ;; カレントウィンドウの最小高
            :winheight 1}
      default_ops {:noremap true :silent true}
      mk_desc (fn [d] {:noremap true :silent true :desc d})
      cmd (fn [c] (.. :<cmd> c :<cr>))
      lua_cmd (fn [c] (cmd (.. "lua " c)))
      ns [;; marks
          [:<leader>mq
           (cmd :MarksQFListBuf)
           (mk_desc "marks in current buffer")]
          [:<leader>mQ
           (cmd :MarksQFListGlobal)
           (mk_desc "marks in all buffer")]
          [:gpd
           (lua_cmd "require('goto-preview').goto_preview_definition()")
           (mk_desc "preview definition")]
          [:gpi
           (lua_cmd "require('goto-preview').goto_preview_implementation()")
           (mk_desc "preview implementation")]
          [:gpr
           (lua_cmd "require('goto-preview').goto_preview_references()")
           (mk_desc "preview references")]
          [:gP
           (lua_cmd "require('goto-preview').close_all_win()")
           (mk_desc "close all preview")]
          [:gh
           (lua_cmd "require('dropbar.api').pick()")
           (mk_desc "pick hierarchy")]
          ;; tools
          [:<leader>q (cmd :BufDel)]
          [:<leader>Q (cmd :BufDel!)]
          [:<leader>A (cmd :tabclose)]
          [:<leader>E (cmd :FeMaco) (mk_desc "edit code block")]
          ;; buffer
          [:<leader>br
           (lua_cmd "require('harpoon.mark').add_file()")
           (mk_desc "register buffer (harpoon)")]
          ;; toggle
          [:<leader>tc (cmd :ColorizerToggle) (mk_desc "toggle colorize")]
          ;; runner
          [:<leader>rr (cmd :FlowRunFile)]
          ;; common tests
          [:<LocalLeader>tT (cmd :Neotest) (mk_desc "test nearest")]
          [:<LocalLeader>tt (cmd :NeotestNearest) (mk_desc "test nearest")]
          [:<LocalLeader>to
           (cmd :NeotestToggleSummary)
           (mk_desc "show test summary")]]
      vs [;; runner
          [:<leader>r (cmd :FlowRunSelected)]]]
  ;; options ;;
  (each [k v (pairs opts)]
    (tset vim.o k v))
  ;; keymap ;;
  (each [_ k (ipairs ns)]
    (vim.keymap.set :n (. k 1) (. k 2) (or (. k 3) default_ops)))
  (each [_ k (ipairs vs)]
    (vim.keymap.set :v (. k 1) (. k 2) (or (. k 3) default_ops)))
  ;; reacher
  (vim.keymap.set [:n :x] :gs (lua_cmd "require('reacher').start()")
                  (mk_desc "search displayed"))
  (vim.keymap.set [:n :x] :gS (lua_cmd "require('reacher').start_multiple()")
                  (mk_desc "search displayed"))
  (vim.keymap.set [:n :i :c :t] "¥" "\\"))
