(let [M (require :waitevent)
      E (M.editor {:open (fn [ctx path]
                           (vim.cmd.split path)
                           (ctx.lcd)
                           (set vim.bo.bufhidden :wipe))})]
  (set vim.env.GIT_EDITOR E))
