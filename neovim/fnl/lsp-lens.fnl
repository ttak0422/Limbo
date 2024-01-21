(let [M (require :lsp-lens)
      sections {:definition false :references true :implementation true}
      ignore_filetype [:prisma]]
  (M.setup {:enable false
            :include_declaration false
            : sections
            : ignore_filetype}))
