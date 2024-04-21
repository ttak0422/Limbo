(let [M (require :img-clip)
      filetypes {:markdown {:url_encode_path false
                            :template "![$CURSOR]($FILE_PATH)"
                            :download_images true}}
      default {}]
  (M.setup {: default : filetypes}))
