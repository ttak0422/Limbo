-- [nfnl] Compiled from neovim/fnl/keymap.fnl by https://github.com/Olical/nfnl, do not edit.
vim.g.mapleader = " "
vim.g.maplocalleader = ","
local os = {noremap = true, silent = true}
local d
local function _1_(d0)
  return {noremap = true, silent = true, desc = d0}
end
d = _1_
local m = vim.keymap.set
local cmd
local function _2_(c)
  return ("<cmd>" .. c .. "<cr>")
end
cmd = _2_
local lcmd
local function _3_(c)
  return cmd(("lua " .. c))
end
lcmd = _3_
local ns
local function _4_()
  return vim.cmd(("Gin " .. vim.fn.input("git command: ")))
end
local function _5_()
  return vim.cmd(("GinBuffer " .. vim.fn.input("git command: ")))
end
ns = {{"q", "<nop>"}, {"<esc><esc>", cmd("nohl")}, {"j", "gj"}, {"k", "gk"}, {"<leader>m", lcmd("require('treesj').toggle()"), d("toggle split/join")}, {"<leader>M", lcmd("require('treesj').toggle({ split = { recursive = true } })"), d("toggle split/join rec")}, {"gpd", lcmd("require('goto-preview').goto_preview_definition()"), d("preview definition")}, {"gpi", lcmd("require('goto-preview').goto_preview_implementation()"), d("preview implementation")}, {"gpr", lcmd("require('goto-preview').goto_preview_references()"), d("preview references")}, {"gP", lcmd("require('goto-preview').close_all_win()"), d("close all preview")}, {"gh", lcmd("require('dropbar.api').pick()"), d("pick hierarchy")}, {"<leader>gg", _4_, d("git command (echo)")}, {"<leader>gG", _5_, d("git command (buffer)")}, {"<leader>gb", cmd("execute printf('Gina blame --width=%d', &columns / 3)"), d("git blame")}, {"<leader>gs", cmd("GinStatus"), d("git status")}, {"<leader>gl", cmd("GinLog"), d("git log")}, {"<leader>q", cmd("BufDel")}, {"<leader>Q", cmd("BufDel!")}, {"<leader>A", cmd("tabclose")}, {"<leader>E", cmd("FeMco"), d("edit code block")}, {"<leader>br", lcmd("require('harpoon.mark').add_file()"), d("register buffer (harpoon)")}, {"<leader>tc", cmd("ColorizerToggle"), d("toggle colorize")}, {"<leader>tb", cmd("NvimTreeToggle")}, {"<leader>tB", cmd("Neotree toggle")}, {"<leader>to", cmd("SidebarNvimToggle")}, {"<leader>tm", lcmd("require('codewindow').toggle_minimap()"), d("toggle minimap")}, {"<leader>tr", lcmd("require('harpoon.ui').toggle_quick_menu()"), d("toggle registered buffer menu")}, {"<leader>tg", cmd("TigTermToggle"), d("toggle tig terminal")}, {"<leader>ff", cmd("Telescope live_grep_args"), d("search by content")}, {"<leader>fp", cmd("Ddu -name=fd file_fd"), d("search by file name")}, {"<leader>fP", cmd("Ddu -name=ghq ghq"), d("search repo (ghq)")}, {"<leader>fb", cmd("Telescope buffers"), d("search buffer")}, {"<leader>fh", cmd("Legendary"), d("search legendary")}, {"<leader>ft", cmd("Telescope sonictemplate templates"), d("search templates")}, {"<leader>fru", cmd("Ddu -name=mru mru"), d("MRU (Most Recently Used files)")}, {"<leader>frw", cmd("Ddu -name=mrw mrw"), d("MRW (Most Recently Written files)")}, {"<leader>frr", cmd("Ddu -name=mrr mrr"), d("MRR (Most Recent git Repositories)")}, {"<leader>fF", lcmd("require('spectre').open()"), d("find and replace with dark power")}, {"<leader>rr", cmd("FlowRunFile")}}
local vs = {{"<leader>r", cmd("FlowRunSelected")}}
for _, keymap in ipairs(ns) do
  m("n", keymap[1], keymap[2], (keymap[3] or os))
end
for _, keymap in ipairs(vs) do
  m("v", keymap[1], keymap[2], (keymap[3] or os))
end
for i = 0, 9 do
  m({"n", "t", "i"}, ("<C-" .. i .. ">"), cmd(("TermToggle " .. i)), d(("toggle terminal " .. i)))
end
m({"n", "x"}, "gs", lcmd("require('reacher').start()"), d("search displayed"))
return m({"n", "x"}, "gS", lcmd("require('reacher').start_multiple()"), d("search displayed"))
