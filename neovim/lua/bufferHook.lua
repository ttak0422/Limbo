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
local ns
local function _4_()
  local dap = require("dap")
  return dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end
local function _5_()
  local dapui = require("dapui")
  return dapui.toggle({reset = true})
end
ns = {{"<leader>mq", cmd("MarksQFListBuf"), mk_desc("marks in current buffer")}, {"<leader>mQ", cmd("MarksQFListGlobal"), mk_desc("marks in all buffer")}, {"gpd", lua_cmd("require('goto-preview').goto_preview_definition()"), mk_desc("preview definition")}, {"gpi", lua_cmd("require('goto-preview').goto_preview_implementation()"), mk_desc("preview implementation")}, {"gpr", lua_cmd("require('goto-preview').goto_preview_references()"), mk_desc("preview references")}, {"gP", lua_cmd("require('goto-preview').close_all_win()"), mk_desc("close all preview")}, {"gh", lua_cmd("require('dropbar.api').pick()"), mk_desc("pick hierarchy")}, {"<leader>q", cmd("BufDel")}, {"<leader>Q", cmd("BufDel!")}, {"<leader>A", cmd("tabclose")}, {"<leader>E", cmd("FeMaco"), mk_desc("edit code block")}, {"<leader>br", lua_cmd("require('harpoon.mark').add_file()"), mk_desc("register buffer (harpoon)")}, {"<leader>tc", cmd("ColorizerToggle"), mk_desc("toggle colorize")}, {"<leader>rr", cmd("FlowRunFile")}, {"<LocalLeader>tT", cmd("Neotest"), mk_desc("test nearest")}, {"<LocalLeader>tt", cmd("NeotestNearest"), mk_desc("test nearest")}, {"<LocalLeader>to", cmd("NeotestToggleSummary"), mk_desc("show test summary")}, {"<F5>", lua_cmd("require('dap').continue()"), mk_desc("continue")}, {"<F10>", lua_cmd("require('dap').step_over()"), mk_desc("step over")}, {"<F11>", lua_cmd("require('dap').step_into()"), mk_desc("step into")}, {"<F12>", lua_cmd("require('dap').step_out()"), mk_desc("step out")}, {"<LocalLeader>db", lua_cmd("require('dap').toggle_breakpoint()"), mk_desc("dap toggle breakpoint")}, {"<LocalLeader>dB", _4_, mk_desc("dap set breakpoint with condition")}, {"<LocalLeader>dr", lua_cmd("require('dap').repl.toggle()"), mk_desc("dap toggle repl")}, {"<LocalLeader>dl", lua_cmd("require('dap').run_last()"), mk_desc("dap run last")}, {"<LocalLeader>dd", _5_, mk_desc("dap toggle ui")}}
local vs = {{"<leader>r", cmd("FlowRunSelected")}, {"<LocalLeader>K", lua_cmd("require('dapui').eval()"), mk_desc("dap evaluate expression")}}
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
