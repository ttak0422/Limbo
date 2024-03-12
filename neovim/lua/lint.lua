-- [nfnl] Compiled from neovim/fnl/lint.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("lint")
local typescript = {"eslint", "typos"}
local javascript = typescript
local java = {"checkstyle", "typos"}
local fennel = {"fennel"}
local nix = {"statix", "typoes"}
M.linters_by_ft = {java = java, typescript = typescript, javascript = javascript, fennel = fennel, nix = nix, lua = {"luacheck", "typos"}}
return nil
