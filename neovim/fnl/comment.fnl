(let [M (require :Comment)
      toggler {:line :gcc :block :gCc}
      opleader {:line :gc :block :gC}
      mappings {:basic true :extra true}]
  (M.setup {: toggler : opleader : mappings}))
