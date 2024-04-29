(let [M (require :nap)
      diagnostic_wrn_options {:severity {:min vim.diagnostic.severity.WARN}
                              :float false}
      diagnostic_err_options {:severity {:min vim.diagnostic.severity.ERROR}
                              :float false}
      cmd (fn [c] (.. :<cmd> c :<cr>))
      lua_cmd (fn [c] (.. :<cmd> "lua " c :<cr>))
      get_qflist_nr (fn [nr]
                      (. (vim.fn.getqflist {: nr}) :nr))
      safe_qf_colder (fn []
                       (let [idx (get_qflist_nr 0)]
                         (if (< 1 idx)
                             (vim.cmd "silent colder")
                             (vim.notify "reached start of quickfix list"))))
      safe_qf_cnewer (fn []
                       (let [idx (get_qflist_nr 0)
                             last_idx (get_qflist_nr "$")]
                         (if (< idx last_idx)
                             (vim.cmd "silent cnewer")
                             (vim.notify "reached end of quickfix list"))))
      operators {:h {:prev {:rhs (fn []
                                   (: (: (require :harpoon) :list) :prev))
                            :opts {:desc "prev registered file"}}
                     :next {:rhs (fn []
                                   (: (: (require :harpoon) :list) :next))
                            :opts {:desc "next registered file"}}}
                 :m {:prev {:rhs "<Plug>(Marks-prev)"
                            :opts {:desc "prev mark"}}
                     :next {:rhs "<Plug>(Marks-next)"
                            :opts {:desc "next mark"}}}
                 :b {:prev {:rhs (cmd :bprevious) :opts {:desc "prev buffer"}}
                     :next {:rhs (cmd :bnext) :opts {:desc "next buffer"}}}
                 :B {:prev {:rhs (lua_cmd "require('buffer_browser').prev()")
                            :opts {:desc "prev buffer (history)"}}
                     :next {:rhs (lua_cmd "require('buffer_browser').next()")
                            :opts {:desc "next buffer (history)"}}}
                 :r {:prev {:rhs (lua_cmd "require('harpoon.ui').nav_prev()")
                            :opts {:desc "prev registered buffer"}}
                     :next {:rhs (lua_cmd "require('harpoon.ui').nav_next()")
                            :opts {:desc "next registered buffer"}}}
                 :e {:prev {:rhs "g," :opts {:desc "prev edit"}}
                     :next {:rhs "g;" :opts {:desc "next edit"}}}
                 :d {:prev {:rhs (fn []
                                   (vim.diagnostic.goto_prev diagnostic_wrn_options))
                            :opts {:desc "prev diagnostic warning"}}
                     :next {:rhs (fn []
                                   (vim.diagnostic.goto_next diagnostic_wrn_options))
                            :opts {:desc "next diagnostic warning"}}
                     :mode [:n :v :o]}
                 :D {:prev {:rhs (fn []
                                   (vim.diagnostic.goto_prev diagnostic_err_options))
                            :opts {:desc "prev diagnostic error"}}
                     :next {:rhs (fn []
                                   (vim.diagnostic.goto_next diagnostic_err_options))
                            :opts {:desc "next diagnostic error"}}
                     :mode [:n :v :o]}
                 :q {:prev {:rhs (cmd :cN) :opts {:desc "prev quickfix"}}
                     :next {:rhs (cmd :cn) :opts {:desc "next quickfix"}}}
                 :Q {:prev {:rhs (cmd :cfirst) :opts {:desc "first quickfix"}}
                     :next {:rhs (cmd :clast) :opts {:desc "last quickfix"}}}
                 :<C-q> {:prev {:rhs (cmd :cpfile)
                                :opts {:desc "prev quickfix file"}}
                         :next {:rhs (cmd :cnfile)
                                :opts {:desc "next quickfix file"}}}
                 :<M-q> {:prev {:rhs safe_qf_colder
                                :opts {:desc "prev quickfix list"}}
                         :next {:rhs safe_qf_cnewer
                                :opts {:desc "next quickfix list"}}}
                 :l {:prev {:rhs (cmd :Lprev) :opts {:desc "prev location"}}
                     :next {:rhs (cmd :Lnext) :opts {:desc "next location"}}}
                 :L {:prev {:rhs (cmd :lfirst) :opts {:desc "first location"}}
                     :next {:rhs (cmd :llast) :opts {:desc "last location"}}}
                 :<C-l> {:prev {:rhs (cmd :lpfile)
                                :opts {:desc "prev location file"}}
                         :next {:rhs (cmd :lnfile)
                                :opts {:desc "next location file"}}}
                 :<M-l> {:prev {:rhs (cmd :lolder)
                                :opts {:desc "prev location list"}}
                         :next {:rhs (cmd :lnewer)
                                :opts {:desc "next location list"}}}}]
  (M.setup {:next_prefix "]"
            :prev_prefix "["
            :next_repeat :<c-n>
            :prev_repeat :<c-p>
            : operators}))
