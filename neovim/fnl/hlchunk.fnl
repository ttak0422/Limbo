(let [M (require :hlchunk)
      chunk {:chars {:horizontal_line "─"
                     :vertical_line "│"
                     :left_top "┌"
                     :left_bottom "└"
                     :right_arrow "─"}
             :style "#00ffff"
             :use_treesitter true}
      indent {:enable false}
      line_num {:enable false}
      blank {:enable false}]
  (M.setup {: chunk : indent : line_num : blank}))
