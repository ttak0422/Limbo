-- [nfnl] Compiled from neovim/fnl/neovide.fnl by https://github.com/Olical/nfnl, do not edit.
local m = vim.keymap.set
local scale = 1.1
local change_scale
local function _1_(delta)
  vim.g.neovide_scale_factor = (vim.g.neovide_scale_factor * delta)
  return nil
end
change_scale = _1_
local toggle_zoom
local function _2_()
  vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
  return nil
end
toggle_zoom = _2_
vim.o.guifont = "PlemolJP Console NF:h15"
m({"n", "i", "c", "t"}, "\194\165", "\\")
local function _3_()
  return change_scale(scale)
end
m("n", "<C-+>", _3_)
local function _4_()
  return change_scale((1 / scale))
end
m("n", "<C-->", _4_)
m("n", "<A-Enter>", toggle_zoom)
return vim.api.nvim_create_user_command("ToggleNeovideFullScreen", toggle_zoom, {})
