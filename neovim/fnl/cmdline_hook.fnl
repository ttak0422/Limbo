(let [create_user_command vim.api.nvim_create_user_command
      default_ops {:noremap true :silent true}
      mk_desc (fn [d] {:noremap true :silent true :desc d})
      cmd (fn [c] (.. :<cmd> c :<cr>))
      lua_cmd (fn [c] (cmd (.. "lua " c)))
      ns [[:<leader>/
           (cmd :SearchToQf)
           (mk_desc "register search results to quickfix")]
          [:<leader>?
           (cmd :SearchToQf! (mk_desc "add search results to quickfix"))]]]
  ;; keymaps ;;
  (each [_ k (ipairs ns)]
    (vim.keymap.set :n (. k 1) (. k 2) (or (. k 3) default_ops)))
  ;; commands ;;
  ;; [Vimで直前の検索結果をQuickFixに格納する](https://zenn.dev/vim_jp/articles/7cc48a1df6aba5)
  (create_user_command :SearchToQf
          (fn [opts]
            (let [command (if opts.bang :vimgrepadd :vimgrep)
                  pattern "//gj %"]
              (vim.cmd (.. command " " pattern)))) {:bang true}))
