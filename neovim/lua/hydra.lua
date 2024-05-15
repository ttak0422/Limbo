-- [nfnl] Compiled from neovim/fnl/hydra.fnl by https://github.com/Olical/nfnl, do not edit.
local Hydra = require("hydra")
local KeymapUtil = require("hydra.keymap-util")
local Cmd = KeymapUtil.cmd
local float_opts = {border = {"\226\148\143", "\226\148\129", "\226\148\147", "\226\148\131", "\226\148\155", "\226\148\129", "\226\148\151", "\226\148\131"}}
Hydra.setup({foreign_keys = nil, color = "red", timeout = 10000, hint = {show_name = true, position = {"bottom"}, offset = 0, float_opts = {}}, on_enter = nil, on_exit = nil, on_key = nil, debug = false, invoke_on_body = false, exit = false})
do
  local heads
  local function _1_()
    return (require("smart-splits")).start_resize_mode()
  end
  local function _2_()
    return (require("nvim-window")).pick()
  end
  heads = {{"h", "<C-w>h", {exit = true}}, {"j", "<C-w>j", {exit = true}}, {"k", "<C-w>k", {exit = true}}, {"l", "<C-w>l", {exit = true}}, {"w", "<C-w>w", {exit = true}}, {"<C-w>", "<C-w>w", {exit = true, desc = false}}, {"p", "<C-w>p", {exit = true, desc = false}}, {"<C-h>", "<C-w>h"}, {"<C-j>", "<C-w>j"}, {"<C-k>", "<C-w>k"}, {"<C-l>", "<C-w>l"}, {"H", Cmd("WinShift left")}, {"J", Cmd("WinShift down")}, {"K", Cmd("WinShift up")}, {"L", Cmd("WinShift right")}, {"e", _1_, {desc = "resize mode", exit = true}}, {"p", _2_, {desc = "pick window", exit = true}}, {"=", "<C-w>=", {desc = "equalize", exit = true}}, {"<CR>", Cmd("DetourCurrentWindow"), {desc = "open popup window", exit = true}}, {"s", "<C-w>s", {exit = true, desc = false}}, {"v", "<C-w>v", {exit = true, desc = false}}, {"z", Cmd("NeoZoomToggle"), {desc = "zoom", exit = true}}, {"c", "<C-w>c", {desc = "close", exit = true}}, {"o", "<C-w>o", {desc = "close other", exit = true}}, {"<C-o>", "<C-w>o", {exit = true, desc = false}}, {"<Esc>", nil, {exit = true, desc = false}}, {";", nil, {exit = true, desc = false}}}
  local config = {invoke_on_body = true, hint = false}
  Hydra({name = "Windows", mode = "n", body = "<C-w>", heads = heads, config = config})
end
local heads = {{"H", "<C-v>h:VBox<CR>"}, {"J", "<C-v>j:VBox<CR>"}, {"K", "<C-v>k:VBox<CR>"}, {"L", "<C-v>l:VBox<CR>"}, {"f", ":VBox<CR>", {mode = "v"}}, {"<Esc>", nil, {desc = "close", exit = true}}}
local config
local function _3_()
  return vim.cmd("setlocal ve=all")
end
local function _4_()
  return vim.cmd("setlocal ve=")
end
config = {invoke_on_body = true, color = "pink", on_enter = _3_, on_exit = _4_, hint = {type = "window", position = "bottom-right", float_opts = float_opts}}
local hint = ":Move    Select region with <C-v>\n-------  -------------------------\n   _K_\n _H_   _L_   _f_: surround it with box\n   _J_"
return Hydra({name = "Draw Diagram", mode = "n", body = "<Leader>V", heads = heads, config = config, hint = hint})
