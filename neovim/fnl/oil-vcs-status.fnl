(let [M (require :oil-vcs-status)
      status_const (require :oil-vcs-status.constant.status)
      StatusType status_const.StatusType
      status_symbol {StatusType.Added ""
                     StatusType.Copied "󰆏"
                     StatusType.Deleted ""
                     StatusType.Ignored ""
                     StatusType.Modified ""
                     StatusType.Renamed ""
                     StatusType.TypeChanged "󰉺"
                     StatusType.Unmodified " "
                     StatusType.Unmerged ""
                     StatusType.Untracked ""
                     StatusType.External ""
                     StatusType.UpstreamAdded "󰈞"
                     StatusType.UpstreamCopied "󰈢"
                     StatusType.UpstreamDeleted ""
                     StatusType.UpstreamIgnored " "
                     StatusType.UpstreamModified "󰏫"
                     StatusType.UpstreamRenamed ""
                     StatusType.UpstreamTypeChanged "󱧶"
                     StatusType.UpstreamUnmodified " "
                     StatusType.UpstreamUnmerged ""
                     StatusType.UpstreamUntracked " "
                     StatusType.UpstreamExternal ""}
      status_priority {StatusType.UpstreamIgnored 0
                       StatusType.Ignored 0
                       StatusType.UpstreamUntracked 1
                       StatusType.Untracked 1
                       StatusType.UpstreamUnmodified 2
                       StatusType.Unmodified 2
                       StatusType.UpstreamExternal 2
                       StatusType.External 2
                       StatusType.UpstreamCopied 3
                       StatusType.UpstreamRenamed 3
                       StatusType.UpstreamTypeChanged 3
                       StatusType.UpstreamDeleted 4
                       StatusType.UpstreamModified 4
                       StatusType.UpstreamAdded 4
                       StatusType.UpstreamUnmerged 5
                       StatusType.Copied 13
                       StatusType.Renamed 13
                       StatusType.TypeChanged 13
                       StatusType.Deleted 14
                       StatusType.Modified 14
                       StatusType.Added 14
                       StatusType.Unmerged 15}
      vcs_specific {:git {:status_update_debounce 200}}]
  (M.setup {":fs_event_debounce" 500
            : status_symbol
            : status_priority
            : vcs_specific}))
