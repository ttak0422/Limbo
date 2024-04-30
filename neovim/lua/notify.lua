-- [nfnl] Compiled from neovim/fnl/notify.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("notify")
M.setup({timeout = 2500, stages = "static", background_colour = "#000000", top_down = false})
vim.notify = M
return nil
