(let [M (require :history-ignore)
      ignore_words [:^buf$
                    :^history$
                    :^h$
                    :^q$
                    :^qa$
                    :^w$
                    :^wq$
                    :^wa$
                    :^wqa$
                    :^q!$
                    :^qa!$
                    :^w!$
                    :^wq!$
                    :^wa!$
                    :^wqa!$]]
  (M.setup {: ignore_words}))
