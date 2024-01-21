-- [nfnl] Compiled from neovim/fnl/better-escape.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("better_escape")
return M.setup({mapping = {"jk"}, timeout = vim.o.timeoutlen, keys = "<Esc>", clear_empty_lines = false})
