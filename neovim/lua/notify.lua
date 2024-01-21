-- [nfnl] Compiled from neovim/fnl/notify.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("notify")
M.setup({timeout = 2500, top_down = true, stages = "static", background_colour = "#000000"})
vim.notify = M
return nil
