(let [M (require :bqf)
      func_map {:open :<CR>
                :openc :o
                :drop :O
                :split :<C-x>
                :vsplit :<C-v>
                ;; open the item in a new tab
                :tab :t
                ;; open the item in a new tab but stay in quickfix window
                :tabb :T
                ;; open the item in a new tab and close quickfix window
                :tabc :<C-t>
                :tabdrop ""
                :ptogglemode :zp
                :ptoggleitem :p
                :ptoggleauto :P
                :pscrollup :<C-b>
                :pscrolldown :<C-f>
                :pscrollorig :zo
                :prevfile ""
                :nextfile ""
                :prevhist ""
                :nexthist ""
                :lastleave "'\""
                :stoggleup :<S-Tab>
                :stoggledown :<Tab>
                :stogglevm :<Tab>
                :stogglebuf "'<Tab>"
                :sclear :z<Tab>
                :filter :zn
                :filterr :zN
                :fzffilter :zf}]
  (M.setup {: func_map}))
