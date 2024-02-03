-- [nfnl] Compiled from neovim/fnl/hydra.fnl by https://github.com/Olical/nfnl, do not edit.
local Hydra = require("hydra")
local KeymapUtil = require("hydra.keymap-util")
local Cmd = KeymapUtil.cmd
Hydra.setup({foreign_keys = nil, color = "red", timeout = "false", hint = {show_name = true, position = {"bottom"}, offset = 0, float_opts = {}}, on_enter = nil, on_exit = nil, on_key = nil, invoke_on_body = false, exit = false, debug = false})
local heads
local function _1_()
  return (require("smart-splits")).start_resize_mode()
end
heads = {{"h", "<C-w>h", {exit = true}}, {"j", "<C-w>j", {exit = true}}, {"k", "<C-w>k", {exit = true}}, {"l", "<C-w>l", {exit = true}}, {"w", "<C-w>w", {exit = true}}, {"<C-w>", "<C-w>w", {exit = true, desc = false}}, {"<C-h>", "<C-w>h"}, {"<C-j>", "<C-w>j"}, {"<C-k>", "<C-w>k"}, {"<C-l>", "<C-w>l"}, {"H", Cmd("WinShift left")}, {"J", Cmd("WinShift down")}, {"K", Cmd("WinShift up")}, {"L", Cmd("WinShift right")}, {"e", _1_, {desc = "resize mode", exit = true}}, {"=", "<C-w>=", {desc = "equalize", exit = true}}, {"s", "<C-w>s", {exit = true, desc = false}}, {"v", "<C-w>v", {exit = true, desc = false}}, {"z", Cmd("NeoZoomToggle"), {desc = "zoom", exit = true}}, {"c", "<C-w>c", {desc = "close", exit = true}}, {"o", "<C-w>o", {desc = "close other", exit = true}}, {"<C-o>", "<C-w>o", {exit = true, desc = false}}, {"<Esc>", nil, {exit = true, desc = false}}, {";", nil, {exit = true, desc = false}}, {"<CR>", nil, {exit = true, desc = false}}}
local config = {invoke_on_body = true, hint = {type = "window", position = "middle", float_opts = {border = {"\226\148\143", "\226\148\129", "\226\148\147", "\226\148\131", "\226\148\155", "\226\148\129", "\226\148\151", "\226\148\131"}}}}
local hint = ":Move                 :Swap     :Utils\n--------------------  -------   ----------------------\n   _k_       _<C-k>_         _K_       _e_: start resize mode\n _h_   _l_  _<C-h>_ _<C-l>_    _H_   _L_\n   _j_       _<C-j>_         _J_\n"
return Hydra({name = "Windows", mode = "n", body = "<C-w>", heads = heads, config = config, hint = hint})
