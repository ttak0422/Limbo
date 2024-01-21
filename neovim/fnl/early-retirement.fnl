(let [M (require :early-retirement)]
  (M.setup {:retirementAgeMins 20
            :ignoredFiletypes []
            :ignoreAltFile true
            :ignoreUnsavedChangesBufs true
            :ignoreSpecialBuftypes true
            :notificationOnAutoClose false}))
