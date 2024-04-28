-- [nfnl] Compiled from neovim/fnl/statuscol.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("statuscol")
local B = require("statuscol.builtin")
local segments = {{text = {"%s"}, maxwidth = 2, click = "v:lua.ScSa"}, {text = {B.lnumfunc}, click = "v:lua.ScLa"}, {text = {" ", B.foldfunc, " "}, click = "v:lua.ScFa"}}
local statuses = {"NeotestPassed", "NeotestFailed", "NeotestRunning", "NeotestSkipped"}
vim.o.number = true
vim.o.signcolumn = "yes"
M.setup({setopt = true, segments = segments, relculright = false})
for _, s in ipairs(statuses) do
  vim.api.nvim_set_hl(0, s, {bg = "#2a2a37"})
end
return nil
