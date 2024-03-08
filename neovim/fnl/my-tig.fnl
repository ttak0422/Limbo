(vim.api.nvim_create_user_command :TigTermToggle
                                  (fn []
                                    (let [detour (require :detour)
                                          current_dir (vim.fn.expand "%:p:h")
                                          ok (detour.Detour)]
                                      (if ok
                                          (do
                                            (vim.cmd.lcd current_dir)
                                            (vim.cmd.terminal :tig)
                                            (set vim.bo.bufhidden :delete)
                                            (vim.keymap.set :t :<Esc> :<Esc>
                                                            {:buffer true})
                                            (vim.cmd.startinsert)
                                            (vim.api.nvim_create_autocmd [:BufLeave]
                                                                         (let [buf_id (vim.api.nvim_get_current_buf)]
                                                                           {:buffer buf_id
                                                                            :callback (fn []
                                                                                        (vim.cmd (.. "bd! "
                                                                                                     buf_id)))}))
                                            (vim.api.nvim_create_autocmd [:TermClose]
                                                                         {:buffer (vim.api.nvim_get_current_buf)
                                                                          :callback (fn []
                                                                                      (vim.api.nvim_feedkeys :i
                                                                                                             :n
                                                                                                             false))})))))
                                  [])
