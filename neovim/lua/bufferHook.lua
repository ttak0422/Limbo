-- [nfnl] Compiled from neovim/fnl/bufferHook.fnl by https://github.com/Olical/nfnl, do not edit.
local cache_path = vim.fn.stdpath("cache")
local opts = {helplang = "ja,en", mouse = "a", hidden = true, autoread = true, undofile = true, undodir = (cache_path .. "/undo"), swapfile = true, directory = (cache_path .. "/swap"), backup = true, backupcopy = "yes", backupdir = (cache_path .. "/backup"), diffopt = "internal,filler,closeoff,vertical", splitright = true, splitbelow = true, winwidth = 20, winheight = 1, equalalways = false, startofline = false}
local default_ops = {noremap = true, silent = true}
local mk_desc
local function _1_(d)
  return {noremap = true, silent = true, desc = d}
end
mk_desc = _1_
local cmd
local function _2_(c)
  return ("<cmd>" .. c .. "<cr>")
end
cmd = _2_
local lua_cmd
local function _3_(c)
  return cmd(("lua " .. c))
end
lua_cmd = _3_
local ns = {{"<leader>mq", cmd("MarksQFListBuf"), mk_desc("marks in current buffer")}, {"<leader>mQ", cmd("MarksQFListGlobal"), mk_desc("marks in all buffer")}, {"gpd", lua_cmd("require('goto-preview').goto_preview_definition()"), mk_desc("preview definition")}, {"gpi", lua_cmd("require('goto-preview').goto_preview_implementation()"), mk_desc("preview implementation")}, {"gpr", lua_cmd("require('goto-preview').goto_preview_references()"), mk_desc("preview references")}, {"gP", lua_cmd("require('goto-preview').close_all_win()"), mk_desc("close all preview")}, {"gh", lua_cmd("require('dropbar.api').pick()"), mk_desc("pick hierarchy")}, {"<leader>q", cmd("BufDel")}, {"<leader>Q", cmd("BufDel!")}, {"<leader>A", cmd("tabclose")}, {"<leader>E", cmd("FeMaco"), mk_desc("edit code block")}, {"<leader>br", lua_cmd("require('harpoon.mark').add_file()"), mk_desc("register buffer (harpoon)")}, {"<leader>tc", cmd("ColorizerToggle"), mk_desc("toggle colorize")}, {"<leader>rr", cmd("FlowRunFile")}, {"<LocalLeader>tT", cmd("Neotest"), mk_desc("test nearest")}, {"<LocalLeader>tt", cmd("NeotestNearest"), mk_desc("test nearest")}, {"<LocalLeader>to", cmd("NeotestToggleSummary"), mk_desc("show test summary")}}
local vs = {{"<leader>r", cmd("FlowRunSelected")}}
for k, v in pairs(opts) do
  vim.o[k] = v
end
for _, k in ipairs(ns) do
  vim.keymap.set("n", k[1], k[2], (k[3] or default_ops))
end
for _, k in ipairs(vs) do
  vim.keymap.set("v", k[1], k[2], (k[3] or default_ops))
end
vim.keymap.set({"n", "x"}, "gs", lua_cmd("require('reacher').start()"), mk_desc("search displayed"))
vim.keymap.set({"n", "x"}, "gS", lua_cmd("require('reacher').start_multiple()"), mk_desc("search displayed"))
return vim.keymap.set({"n", "i", "c", "t"}, "\194\165", "\\")
