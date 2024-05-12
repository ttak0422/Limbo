-- [nfnl] Compiled from neovim/fnl/tshjkl.fnl by https://github.com/Olical/nfnl, do not edit.
local tshjkl = require("tshjkl")
local keymaps = {toggle = "<Leader><CR>", parent = "h", next = "j", prev = "k", child = "l", toggle_named = "<S-M-n>"}
local marks = {parent = {hl_group = "Comment"}, child = {hl_group = "Error"}, next = {hl_group = "InfoFloat"}, current = {hl_group = "Substitute"}}
return tshjkl.setup({select_current_node = true, keymaps = keymaps, marks = marks})
