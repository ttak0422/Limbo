-- [nfnl] Compiled from neovim/fnl/reactive.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("reactive")
local custom = {name = "custom", static = {winhl = {inactive = {CursorLine = {bg = "#363646"}}}}, modes = {no = {operators = {[{"gu", "gU", "g~", "~"}] = {winhl = {CursorLine = {bg = "#363646"}}}, c = {winhl = {CursorLine = {bg = "#363646"}}}, d = {winhl = {CursorLine = {bg = "#363646"}}}, y = {winhl = {CursorLine = {bg = "#363646"}}}}}, i = {winhl = {CursorLine = {bg = "#363646"}}}, c = {winhl = {CursorLine = {bg = "#363646"}}}, n = {winhl = {CursorLine = {bg = "#363646"}}}, [{"v", "V", "\22"}] = {winhl = {Visual = {bg = "#363646"}}}, [{"s", "S", "\19"}] = {winhl = {Visual = {bg = "#363646"}}}, R = {winhl = {CursorLine = {bg = "#363646"}}}}}
M.add_preset(custom)
return M.setup({load = {"custom"}})
