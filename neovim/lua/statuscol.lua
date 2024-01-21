-- [nfnl] Compiled from neovim/fnl/statuscol.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("statuscol")
local B = require("statuscol.B")
local segments = {{text = {"%s"}, click = "v:lua.ScFa"}, {text = {" ", B.foldfunc, " "}, condition = {B.not_empty, true, B.not_empty}, click = "v:lua.scfa"}, {text = {B.lnumfunc}}}
return M.setup({setopt = true, relculright = true, segments = segments})
