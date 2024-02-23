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
            :virtualedit :block
            :cursorline true}]
  (each [k v (pairs opts)]
    (tset vim.o k v)))
