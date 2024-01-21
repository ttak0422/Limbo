(let [M (require :mkdnflow)
      modules {:bib false
               :buffers false
               :conceal true
               :cursor true
               :folds false
               :links true
               :lists true
               :maps true
               :paths true
               :tables true
               :yaml false
               :cmp false}
      filetypes {:md true :rmd true :markdown true}
      bib {:default_path nil :find_in_root true}
      perspective {:priority :first
                   :fallback :current
                   :root_tell false
                   :nvim_wd_heel false
                   :update false}
      links {:style :markdown
             :name_is_source false
             :conceal false
             :context 0
             :implicit_extension nil
             :transform_implicit false
             :transform_explicit (fn [text]
                                   (.. (os.date "%Y-%m-%d_")
                                       (: (: text :gsub " " "-") :lower)))}
      new_file_template {:use_template false
                         :placeholders {:before {:title :link_title
                                                 :date :os_date}
                                        :after {}}
                         :template "# {{ title }}"}
      to_do {:symbols [" " "-" :X]
             :update_parents true
             :not_started " "
             :in_progress "-"
             :complete :X}
      tables {:trim_whitespace true
              :format_on_move true
              :auto_extend_rows false
              :auto_extend_cols false}
      mappings {:MkdnEnter [[:n :v] :<CR>]
                :MkdnTab false
                :MkdnSTab false
                :MkdnNextLink false
                :MkdnPrevLink false
                :MkdnNextHeading [:n "]]"]
                :MkdnPrevHeading [:n "[["]
                :MkdnGoBack false
                :MkdnGoForward false
                :MkdnCreateLink false
                :MkdnCreateLinkFromClipboard false
                :MkdnFollowLink false
                :MkdnDestroyLink false
                :MkdnTagSpan false
                :MkdnMoveSource false
                :MkdnYankAnchorLink false
                :MkdnYankFileAnchorLink false
                :MkdnIncreaseHeading [:n "+"]
                :MkdnDecreaseHeading [:n "-"]
                :MkdnToggleToDo [[:n :v] :<C-Space>]
                :MkdnNewListItem false
                :MkdnNewListItemBelowInsert [:n :o]
                :MkdnNewListItemAboveInsert [:n :O]
                :MkdnExtendList false
                :MkdnUpdateNumbering [:n :<localleader>nn]
                :MkdnTableNextCell false
                ; TODO
                :MkdnTablePrevCell false
                ; TODO
                :MkdnTableNextRow [:i :<S-M-CR>]
                :MkdnTablePrevRow [:i :<M-CR>]
                :MkdnTableNewRowBelow [:n :<localleader>ir]
                :MkdnTableNewRowAbove [:n :<localleader>iR]
                :MkdnTableNewColAfter [:n :<localleader>ic]
                :MkdnTableNewColBefore [:n :<localleader>iC]
                :MkdnFoldSection false
                :MkdnUnfoldSection false}]
  (M.setup {:create_dirs true
            :wrap false
            :silent false
            : modules
            : filetypes
            : bib
            : perspective
            : links
            : new_file_template
            : to_do
            : tables
            : mappings}))
