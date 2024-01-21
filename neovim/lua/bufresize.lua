-- [nfnl] Compiled from neovim/fnl/bufresize.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("bufresize")
local register = {keys = {}, trigger_events = {"BufWinEnter", "WinEnter"}}
local resize = {keys = {}, trigger_events = {"VimResized"}, increment = false}
return M.setup({register = register, resize = resize})
