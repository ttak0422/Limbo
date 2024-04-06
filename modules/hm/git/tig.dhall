let set =
      ''
      set main-view = id date author:email-user commit-title:graph=yes,refs=yes
      set main-view-date = custom
      set main-view-date-format = "%y/%m/%d %H:%M"
      set blame-view  = date:default author:email-user id:yes,color line-number:yes,interval=1 text
      set pager-view  = line-number:yes,interval=1 text
      set stage-view  = line-number:yes,interval=1 text
      set log-view    = line-number:yes,interval=1 text
      set blob-view   = line-number:yes,interval=1 text
      set diff-view   = line-number:yes,interval=1 text:yes,commit-title-overflow=no
      ''

let bind =
      ''
      bind main R !git rebase -i %(commit)
      bind diff R !git rebase -i %(commit)

      bind status C <git commit
      ''

in  { config =
        ''
        ${set}
        ${bind}
        ''
    }
