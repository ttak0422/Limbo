(let [M (require :octo)
      f (fn [key desc] { :lhs key : desc})
      picker_mappings {:open_in_browser {:<C-b> "open issue in browser"}
                       :copy_url {:<C-y> "copy url to system clipboard"}
                       :checkout_pr {:<C-o> "checkout pull request"}
                       ; :merge_pr { :<C-r>  "merge pull request"}
                       }
      picker_config {:use_emojis false :mappings picker_mappings}
      ui {:use_signcolumn true}
      issues {:order_by {:field :CREATED_AT :direction :DESC}}
      pull_requests {:order_by {:field :CREATED_AT :direction :DESC}
                     :always_select_remote_on_create false}
      file_panel {:size 10 :use_icons true}
      colors {:white "#ffffff"
              :grey "#2A354C"
              :black "#000000"
              :red "#fdb8c0"
              :dark_red "#fa4343"
              :green "#acf2bd"
              :dark_green "#238636"
              :yellow "#d3c846"
              :dark_yellow "#735c0f"
              :blue "#58A6FF"
              :dark_blue "#0366d6"
              :purple "#6f42c1"}
      ; issue_mappings {:close_issue (f :<localleader>ci "close issue")
      ;                 :reopen_issue (f :<localleader>oi "reopen issue")
      ;                 :list_issues (f :<localleader>li
      ;                                 "list open issues on same repo")
      ;                 :reload (f :R "reload issue")
      ;                 :open_in_browser (f :<C-b> "open issue in browser")
      ;                 :copy_url (f :<C-y> "copy url to system clipboard")
      ;                 :add_assignee (f :<localleader>aa "add assignee")
      ;                 :remove_assignee (f :<localleader>da "remove assignee")
      ;                 ;; :create_label (f :<localleader>c "create label")
      ;                 :add_label (f :<localleader>al "add label")
      ;                 :remove_label (f :<localleader>dl "remove label")
      ;                 :goto_issue (f :<localleader>gi
      ;                                "navigate to a local repo issue")
      ;                 :add_comment (f :<localleader>ac "add comment")
      ;                 :delete_comment (f :<localleader>dc "delete comment")
      ;                 :next_comment (f "]c" "go to next comment")
      ;                 :prev_comment (f "[c" "go to previous comment")
      ;                 :react_hooray (f :<localleader>rt
      ;                                  "add/remove 🎉 reaction")
      ;                 :react_heart (f :<localleader>rh
      ;                                 "add/remove ❤️ reaction")
      ;                 :react_eyes (f :<localleader>re
      ;                                "add/remove 👀 reaction")
      ;                 :react_thumbs_up (f :<localleader>r+
      ;                                     "add/remove 👍 reaction")
      ;                 :react_thumbs_down (f :<localleader>r-
      ;                                       "add/remove 👎 reaction")
      ;                 :react_rocket (f :<localleader>rr
      ;                                  "add/remove 🚀 reaction")
      ;                 :react_laugh (f :<localleader>rl
      ;                                 "add/remove 😄 reaction")
      ;                 :react_confused (f :<localleader>rc
      ;                                    "add/remove 😕 reaction")}
      ; pull_request_mappings {:checkout_pr (f :<localleader>op "checkout PR")
      ;                        :merge_pr (f :<localleader>mp "merge commit PR")
      ;                        :squash_and_merge_pr (f :<localleader>smp
      ;                                                "squash and merge PR")
      ;                        :rebase_and_merge_pr (f :<localleader>rmp
      ;                                                "rebase and merge PR")
      ;                        :list_commits (f :<localleader>lc
      ;                                         "list PR commits")
      ;                        :list_changed_files (f :<localleader>lC
      ;                                               "list PR changed files")
      ;                        :show_pr_diff (f :<localleader>pd "show PR diff")
      ;                        :add_reviewer (f :<localleader>ar "add reviewer")
      ;                        :remove_reviewer (f :<localleader>dr
      ;                                            "remove reviewer request")
      ;                        :close_issue (f :<localleader>ci "close PR")
      ;                        :reopen_issue (f :<localleader>oi "reopen PR")
      ;                        :list_issues (f :<localleader>li
      ;                                        "list open issues on same repo")
      ;                        :reload (f :R "reload PR")
      ;                        :open_in_browser (f :<C-b> "open PR in browser")
      ;                        :copy_url (f :<C-y> "copy url to system clipboard")
      ;                        :goto_file (f :gf "go to file")
      ;                        :add_assignee (f :<localleader>aa "add assignee")
      ;                        :remove_assignee (f :<localleader>da
      ;                                            "remove assignee")
      ;                        ; :create_label (f :<localleader>lc "create label")
      ;                        :add_label (f :<localleader>al "add label")
      ;                        :remove_label (f :<localleader>dl "remove label")
      ;                        :goto_issue (f :<localleader>gi
      ;                                       "navigate to a local repo issue")
      ;                        :add_comment (f :<localleader>ac "add comment")
      ;                        :delete_comment (f :<localleader>dc
      ;                                           "delete comment")
      ;                        :next_comment (f "]c" "go to next comment")
      ;                        :prev_comment (f "[c" "go to previous comment")
      ;                        :react_hooray (f :<localleader>rt
      ;                                         "add/remove 🎉 reaction")
      ;                        :react_heart (f :<localleader>rh
      ;                                        "add/remove ❤️ reaction")
      ;                        :react_eyes (f :<localleader>re
      ;                                       "add/remove 👀 reaction")
      ;                        :react_thumbs_up (f :<localleader>r+
      ;                                            "add/remove 👍 reaction")
      ;                        :react_thumbs_down (f :<localleader>r-
      ;                                              "add/remove 👎 reaction")
      ;                        :react_rocket (f :<localleader>rr
      ;                                         "add/remove 🚀 reaction")
      ;                        :react_laugh (f :<localleader>rl
      ;                                        "add/remove 😄 reaction")
      ;                        :react_confused (f :<localleader>rc
      ;                                           "add/remove 😕 reaction")
      ;                        :review_start (f :<localleader>sr
      ;                                         "start a review for the current PR")
      ;                        :review_resume (f :<localleader>rr
      ;                                          "resume a pending review for the current PR")}
      ; review_thread_mappings {:goto_issue (f :<localleader>gi
      ;                                        "navigate to a local repo issue")
      ;                         :add_comment (f :<localleader>ac "add comment")
      ;                         :add_suggestion (f :<localleader>as
      ;                                            "add suggestion")
      ;                         :delete_comment (f :<localleader>dc
      ;                                            "delete comment")
      ;                         :next_comment (f "]c" "go to next comment")
      ;                         :prev_comment (f "[c" "go to previous comment")
      ;                         :select_next_entry (f "]q"
      ;                                               "move to previous changed file")
      ;                         :select_prev_entry (f "[q"
      ;                                               "move to next changed file")
      ;                         :select_first_entry (f "[Q"
      ;                                                "move to first changed file")
      ;                         :select_last_entry (f "]Q"
      ;                                               "move to last changed file")
      ;                         :close_review_tab (f :<C-c> "close review tab")
      ;                         :react_hooray (f :<localleader>rt
      ;                                          "add/remove 🎉 reaction")
      ;                         :react_heart (f :<localleader>rh
      ;                                         "add/remove ❤️ reaction")
      ;                         :react_eyes (f :<localleader>re
      ;                                        "add/remove 👀 reaction")
      ;                         :react_thumbs_up (f :<localleader>r+
      ;                                             "add/remove 👍 reaction")
      ;                         :react_thumbs_down (f :<localleader>r-
      ;                                               "add/remove 👎 reaction")
      ;                         :react_rocket (f :<localleader>rr
      ;                                          "add/remove 🚀 reaction")
      ;                         :react_laugh (f :<localleader>rl
      ;                                         "add/remove 😄 reaction")
      ;                         :react_confused (f :<localleader>rc
      ;                                            "add/remove 😕 reaction")}
      ; submit_win_mappings {:approve_review (f :<C-a> "approve review")
      ;                      :comment_review (f :<C-m> "comment review")
      ;                      :request_changes (f :<C-r> "request changes review")
      ;                      :close_review_tab (f :<C-c> "close review tab")}
      ; review_diff_mappings {:submit_review (f :<localleader>sr "submit review")
      ;                       :discard_review (f :<localleader>dr
      ;                                          "discard review")
      ;                       :add_review_comment (f :<localleader>ac
      ;                                              "add a new review comment")
      ;                       :add_review_suggestion (f :<localleader>as
      ;                                                 "add a new review suggestion")
      ;                       :focus_files (f :<localleader>e
      ;                                       "move focus to changed file panel")
      ;                       :toggle_files (f :<localleader>b
      ;                                        "hide/show changed files panel")
      ;                       :next_thread (f "]t" "move to next thread")
      ;                       :prev_thread (f "[t" "move to previous thread")
      ;                       :select_next_entry (f "]q"
      ;                                             "move to previous changed file")
      ;                       :select_prev_entry (f "[q"
      ;                                             "move to next changed file")
      ;                       :select_first_entry (f "[Q"
      ;                                              "move to first changed file")
      ;                       :select_last_entry (f "]Q"
      ;                                             "move to last changed file")
      ;                       :close_review_tab (f :<C-c> "close review tab")
      ;                       :toggle_viewed (f :<localleader><localleader>
      ;                                         "toggle viewer viewed state")
      ;                       :goto_file (f :gf "go to file")}
      ; file_panel_mappings {:submit_review (f :<localleader>sr "submit review")
      ;                      :discard_review (f :<localleader>dr "discard review")
      ;                      :next_entry (f :j "move to next changed file")
      ;                      :prev_entry (f :k "move to previous changed file")
      ;                      :select_entry (f :<cr>
      ;                                       "show selected changed file diffs")
      ;                      :refresh_files (f :R "refresh changed files panel")
      ;                      :focus_files (f :<localleader>e
      ;                                      "move focus to changed file panel")
      ;                      :toggle_files (f :<localleader>b
      ;                                       "hide/show changed files panel")
      ;                      :select_next_entry (f "]q"
      ;                                            "move to previous changed file")
      ;                      :select_prev_entry (f "[q"
      ;                                            "move to next changed file")
      ;                      :select_first_entry (f "[Q"
      ;                                             "move to first changed file")
      ;                      :select_last_entry (f "]Q"
      ;                                            "move to last changed file")
      ;                      :close_review_tab (f :<C-c> "close review tab")
      ;                      :toggle_viewed (f :<localleader><localleader>
      ;                                        "toggle viewer viewed state")}
      ; mappings {:issue issue_mappings
      ;           :pull_request pull_request_mappings
      ;           :review_thread review_thread_mappings
      ;           :submit_win submit_win_mappings
      ;           :review_diff review_diff_mappings
      ;           :file_panel file_panel_mappings}
                ]
  (M.setup {:use_local_fs false
            :enable_builtin false
            :default_remote [:upstream :origin]
            :default_merge_method :commit
            :ssh_aliases {}
            :picker :telescope
            : picker_config
            :comment_icon "▎"
            :outdated_icon "󰅒 "
            :resolved_icon " "
            :reaction_viewer_hint_icon " "
            :user_icon " "
            :timeline_marker " "
            :timeline_indent :2
            :right_bubble_delimiter ""
            :left_bubble_delimiter ""
            :github_hostname ""
            :snippet_context_lines 4
            :gh_cmd :gh
            :gh_env {}
            :timeout 5000
            :default_to_projects_v2 false
            : ui
            : issues
            : pull_requests
            : file_panel
            : colors
            : mappings}))
