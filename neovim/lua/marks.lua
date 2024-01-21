-- [nfnl] Compiled from neovim/fnl/marks.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("marks")
local sign_priority = {lower = 10, upper = 15, builtin = 8, bookmark = 20}
return M.setup({default_mappings = true, cyclic = true, refresh_interval = 500, sign_priority = sign_priority, force_write_shada = false})
