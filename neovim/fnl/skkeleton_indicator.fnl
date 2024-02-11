(let [highlights {:SkkeletonIndicatorEiji {:fg "#88c0d0"
                                           :bg "#2e3440"
                                           :bold true}
                  :SkkeletonIndicatorHira {:fg "#2e3440"
                                           :bg "#a3be8c"
                                           :bold true}
                  :SkkeletonIndicatorKata {:fg "#2e3440"
                                           :bg "#ebcb8b"
                                           :bold true}
                  :SkkeletonIndicatorHankata {:fg "#2e3440"
                                              :bg "#b48ead"
                                              :bold true}
                  :SkkeletonIndicatorZenkaku {:fg "#2e3440"
                                              :bg "#88c0d0"
                                              :bold true}
                  :SkkeletonIndicatorAbbrev {:fg "#e5e9f0"
                                             :bg "#bf616a"
                                             :bold true}}
      M (require :skkeleton_indicator)]
  (each [k v (pairs highlights)]
    (vim.api.nvim_set_hl 0 k v))
  (M.setup {}))
