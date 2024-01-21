-- [nfnl] Compiled from neovim/fnl/ts-autotag.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("nvim-ts-autotag")
local filetypes = {"javascript", "typescript", "jsx", "tsx", "vue", "html"}
return M.setup({filetypes = filetypes})
