-- [nfnl] Compiled from neovim/fnl/flit.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("flit")
local keys = {f = "f", F = "F", t = "t", T = "T"}
local opts = {}
return M.setup({labeled_modes = "v", multiline = true, keys = keys, opts = opts})
