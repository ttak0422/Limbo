(let [M (require :global-note)
      get_project_name (fn []
                         (let [result (: (vim.system [:git
                                                      :rev-parse
                                                      :--show-toplevel]
                                                     {:text true})
                                         :wait)]
                           (if (not= result.stderr "")
                               (vim.notify result.stderr vim.log.levels.WARN)
                               (let [project_directory (: result.stdout :gsub
                                                          "\n" "")
                                     project_name (vim.fs.basename project_directory)]
                                 (if (= project_name nil)
                                     (vim.notify "Unable to get the project name"
                                                 vim.log.levels.WARN)
                                     project_name)))))
      additional_presets {:project_local {:command_name :ProjectNote
                                          :filename (fn []
                                                      (.. (get_project_name)
                                                          :.md))
                                          :title "Project note"}}]
  (M.setup {:filename :global.md :directory "~/notes/" : additional_presets}))
