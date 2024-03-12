(let [M (require :lint)
      typescript [:eslint :typos]
      javascript typescript
      java [:checkstyle :typos]
      fennel [:fennel]
        nix [:statix :typoes]
      ]
  (set M.linters_by_ft {: java
                        : typescript
                        : javascript
                        : fennel
                        : nix
                        :lua [:luacheck :typos]}))
