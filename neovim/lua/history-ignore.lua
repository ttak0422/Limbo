-- [nfnl] Compiled from neovim/fnl/history-ignore.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("history-ignore")
local ignore_words = {"^buf$", "^history$", "^h$", "^q$", "^qa$", "^w$", "^wq$", "^wa$", "^wqa$", "^q!$", "^qa!$", "^w!$", "^wq!$", "^wa!$", "^wqa!$"}
return M.setup({ignore_words = ignore_words})
