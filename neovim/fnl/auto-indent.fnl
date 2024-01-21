(let [auto-indent (require :auto-indent)
      ts-indent (require :nvim-treesitter.indent)]
  (auto-indent.setup {:lightmode true
                      :indentexpr (fn [lnum]
                                    (ts-indent.get_indent lnum))
                      :ignore_filetype {}}))
