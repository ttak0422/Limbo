-- [nfnl] Compiled from neovim/fnl/tabout.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("tabout")
local tabouts = {{open = "'", close = "'"}, {open = "\"", close = "\""}, {open = "`", close = "`"}, {open = "(", close = ")"}, {open = "[", close = "]"}, {open = "{", close = "}"}, {open = "<", close = ">"}}
return M.setup({tabkey = "<C-k>", backwards_tabkey = "<C-l>", default_tab = "<C-t>", default_shift_tab = "<C-d>", enable_backwards = true, tabouts = tabouts, completion = false, ignoreignore_beginning = false, act_as_tab = false, act_as_shift_tab = false})
