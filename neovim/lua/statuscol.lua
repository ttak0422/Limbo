-- [nfnl] Compiled from neovim/fnl/statuscol.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("statuscol")
local B = require("statuscol.builtin")
local segments = {{text = {B.lnumfunc}, click = "v:lua.ScLa"}, {text = {B.foldfunc}, click = "v:lua.ScFa"}}
return M.setup({setopt = true, segments = segments, relculright = false})
