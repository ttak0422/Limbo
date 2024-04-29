-- [nfnl] Compiled from neovim/fnl/harpoon.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("harpoon")
local settings
local function _1_()
  return vim.loop.cwd()
end
settings = {key = _1_, sync_on_ui_close = false, save_on_toggle = false}
return M:setup({settings = settings})
