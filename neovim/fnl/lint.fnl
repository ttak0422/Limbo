(let [M (require :lint)
        typescript [:eslint :typos]
        javascript typescript
      java [:checkstyle :typos]]
  (set M.linters_by_ft {: java : typescript : javascript :nix [:statix] :lua [:luacheck]}))
