(let [M (require :pqf)
      signs {:error "" :warning "" :info "" :hint ""}]
  (M.setup {: signs :show_multiple_lines false :max_filename_length 0}))
