(let [auto-indent (require :auto-indent)
      ts-indent (require :nvim-treesitter.indent)
      ignore_filetype []]
  (auto-indent.setup {:lightmode true
                      :indentexpr (fn [lnum]
                                    (ts-indent.get_indent lnum))
                      : ignore_filetype}))
