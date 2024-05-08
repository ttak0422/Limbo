-- [nfnl] Compiled from neovim/fnl/glance.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("glance")
local border = {enable = true, top_char = "\226\148\129", bottom_char = "\226\148\129"}
local folds = {fold_closed = "\226\150\184", fold_open = "\226\150\190", folded = false}
return M.setup({border = border, folds = folds})
