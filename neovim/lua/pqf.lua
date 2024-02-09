-- [nfnl] Compiled from neovim/fnl/pqf.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("pqf")
local signs = {error = "E", warning = "W", info = "I", hint = "H"}
return M.setup({signs = signs, max_filename_length = 0, show_multiple_lines = false})
