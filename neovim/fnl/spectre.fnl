(let [M (require :spectre)]
  (M.setup {:color_devicons true
            :open_cmd :new
            :replace_engine {:sed {:cmd :sed}}}))
