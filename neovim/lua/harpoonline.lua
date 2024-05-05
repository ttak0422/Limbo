-- [nfnl] Compiled from neovim/fnl/harpoonline.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("harpoonline")
local formatter_opts = {default = {inactive = " %s ", active = "[%s]", max_slots = 4, more = "\226\128\166"}, short = {inner_separator = "|"}}
local on_update
local function _1_()
  return vim.cmd.redrawstatus()
end
on_update = _1_
return M.setup({icon = "\239\128\174", default_list_name = "", formatter = "default", custom_formatter = nil, formatter_opts = formatter_opts, on_update = on_update})
