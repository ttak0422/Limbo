-- [nfnl] Compiled from neovim/fnl/notify.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("notify")
local get_option = vim.api.nvim_get_option
local max_height
local function _1_()
  return (get_option("lines") / 3)
end
max_height = _1_
local max_width
local function _2_()
  return ((get_option("columns") / 3) * 2)
end
max_width = _2_
M.setup({timeout = 2500, render = "wrapped-compact", stages = "static", background_colour = "#000000", max_height = max_height, max_width = max_width, top_down = false})
vim.notify = M
return nil
