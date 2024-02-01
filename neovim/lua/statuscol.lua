-- [nfnl] Compiled from neovim/fnl/statuscol.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("statuscol")
local B = require("statuscol.builtin")
local segments = {{text = {"%C"}, click = "v:lua.ScFa"}, {text = {"%s"}, click = "v:lua.ScFa"}, {text = {B.lnumfunc, " "}, condition = {true, B.not_empty}, click = "v:lua.ScFa"}}
return M.setup({setopt = true, segments = segments, relculright = false})
