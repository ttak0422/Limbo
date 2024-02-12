(local parser_install_dir (.. (vim.fn.stdpath :state) :/parser))
(: vim.opt.runtimepath :prepend parser_install_dir)

(let [config (require :nvim-treesitter.configs)
      highlight {:enable true
                 :additional_vim_regex_highlighting false
                 :disable (fn [lang buf]
                            (if (= lang :nix)
                                true
                                (let [max_filesize (* 100 1024)
                                      (ok stats) (pcall vim.loop.fs_stat
                                                        (vim.api.nvim_buf_get_name buf))]
                                  (and ok stats (> stats.size max_filesize)))))}
      yati {:enable true :default_lazy true :default_fallback :auto}
      indent {:enable false}
      matchup {:enable true}
      textobjects {:select {:enable true
                            :loopable true
                            :keymaps {:af {:query "@function.outer"
                                           :desc "outer part of function"}
                                      :if {:query "@function.inner"
                                           :desc "inner part of function"}
                                      :ac {:query "@class.outer"
                                           :desc "outer part of class"}
                                      :ic {:query "@class.inner"
                                           :desc "inner partof class"}}}
                   :move {:enable true
                          :set_jumps true
                          :goto_next_start {"]f" {:query "@function.outer"
                                                  :desc "next function (start)"}
                                            "]z" {:query "@fold"
                                                  :desc "next fold (start)"}}
                          :goto_next_end {"]F" {:query "@function.outer"
                                                :desc "next function (end)"}}
                          :goto_previous_start {"[f" {:query "@function.outer"
                                                      :desc "prev function (start)"}
                                                "[z" {:query "@fold"
                                                      :desc "prev fold (start)"}}
                          :goto_previous_end {"[F" {:query "@function.outer"
                                                    :desc "prev function (end)"}}}}]
  (config.setup {:sync_install false
                 :auto_install false
                 :ignore_install []
                 : parser_install_dir
                 ;; :parseer_install_dir args.parser
                 : highlight
                 : yati
                 : indent
                 : matchup
                 : textobjects}))
