(let [opts {;; タブでスペースを入力
            :expandtab true
            ;; タブ幅を2
            :tabstop 2
            ;; インデント幅
            :shiftwidth 2
            ;; 入力時に対応する括弧を強調
            :showmatch true
            ;; 補完オプション
            :completeopt ""
            ;; 短径選択を寛容に
            :virtualedit :block}
      default_ops {:noremap true :silent true}
      mk_desc (fn [d] {:noremap true :silent true :desc d})
      cmd (fn [c] (.. :<cmd> c :<cr>))
      lua_cmd (fn [c] (cmd (.. "lua " c)))
      ns [[:<leader>U (cmd :UndotreeToggle (mk_desc "toggle undotree"))]]]
  ;; options ;;
  (each [k v (pairs opts)]
    (tset vim.o k v))
  ;; keymaps ;;
  (each [_ k (ipairs ns)]
    (vim.keymap.set :n (. k 1) (. k 2) (or (. k 3) default_ops))))
