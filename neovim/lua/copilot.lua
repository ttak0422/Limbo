-- [nfnl] Compiled from neovim/fnl/copilot.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("copilot")
local keymap = {jump_prev = "[[", jump_next = "]]", accept = "<CR>", refresh = "<M-r>", open = "<M-CR>", layout = {position = "bottom", ratio = 0.4}}
local suggestion = {enabled = true, auto_trigger = true, debounce = 150, keymap = {accept = "<M-y>", next = "<M-]>", prev = "<M-[>", dismiss = "<M-e>", accept_word = false, accept_line = false}}
local filetypes = {help = false, ["."] = false, gitrebase = false}
return M.setup({enabled = true, keymap = keymap, suggestion = suggestion, filetypes = filetypes, auto_refresh = false})
