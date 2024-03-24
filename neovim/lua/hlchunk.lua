-- [nfnl] Compiled from neovim/fnl/hlchunk.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("hlchunk")
local chunk = {chars = {horizontal_line = "\226\148\128", vertical_line = "\226\148\130", left_top = "\226\148\140", left_bottom = "\226\148\148", right_arrow = "\226\148\128"}, style = "#00ffff", use_treesitter = true}
local indent = {enable = false}
local line_num = {enable = false}
local blank = {enable = false}
return M.setup({chunk = chunk, indent = indent, line_num = line_num, blank = blank})
