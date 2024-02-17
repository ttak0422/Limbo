-- [nfnl] Compiled from neovim/fnl/keymap.fnl by https://github.com/Olical/nfnl, do not edit.
vim.g.mapleader = " "
vim.g.maplocalleader = ","
local os = {noremap = true, silent = true}
local desc
local function _1_(d)
  return {noremap = true, silent = true, desc = d}
end
desc = _1_
local map = vim.keymap.set
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
local mk_toggle
local function _4_()
  local state = {pre_id = nil, is_open = false}
  local function _5_(id, mod, opt)
    local function _6_()
      local T = require("toolwindow")
      if (state.pre_id ~= id) then
        T.open_window(mod, opt)
        do end (state)["is_open"] = true
      else
        if state.is_open then
          T.close()
          do end (state)["is_open"] = false
        else
          T.open_window(mod, opt)
          do end (state)["is_open"] = true
        end
      end
      state["pre_id"] = id
      return nil
    end
    return _6_
  end
  return _5_
end
mk_toggle = _4_()
local ns
local function _9_()
  return vim.cmd(("Gin " .. vim.fn.input("git command: ")))
end
local function _10_()
  return vim.cmd(("GinBuffer " .. vim.fn.input("git command: ")))
end
ns = {{"q", "<nop>"}, {"<esc><esc>", cmd("nohl")}, {"j", "gj"}, {"k", "gk"}, {"<leader>mq", cmd("MarksQFListBuf"), desc("marks in current buffer")}, {"<leader>mQ", cmd("MarksQFListGlobal"), desc("marks in all buffer")}, {"gpd", lua_cmd("require('goto-preview').goto_preview_definition()"), desc("preview definition")}, {"gpi", lua_cmd("require('goto-preview').goto_preview_implementation()"), desc("preview implementation")}, {"gpr", lua_cmd("require('goto-preview').goto_preview_references()"), desc("preview references")}, {"gP", lua_cmd("require('goto-preview').close_all_win()"), desc("close all preview")}, {"gh", lua_cmd("require('dropbar.api').pick()"), desc("pick hierarchy")}, {"<leader>gg", _9_, desc("git command (echo)")}, {"<leader>gG", _10_, desc("git command (buffer)")}, {"<leader>gb", cmd("execute printf('Gina blame --width=%d', &columns / 3)"), desc("git blame")}, {"<leader>gs", cmd("GinStatus"), desc("git status")}, {"<leader>gl", cmd("GinLog"), desc("git log")}, {"<leader>q", cmd("BufDel")}, {"<leader>Q", cmd("BufDel!")}, {"<leader>A", cmd("tabclose")}, {"<leader>E", cmd("FeMaco"), desc("edit code block")}, {"<leader>br", lua_cmd("require('harpoon.mark').add_file()"), desc("register buffer (harpoon)")}, {"<leader>tc", cmd("ColorizerToggle"), desc("toggle colorize")}, {"<leader>tb", cmd("NvimTreeToggle")}, {"<leader>to", cmd("SidebarNvimToggle")}, {"<leader>tm", lua_cmd("require('codewindow').toggle_minimap()"), desc("toggle minimap")}, {"<leader>tr", lua_cmd("require('harpoon.ui').toggle_quick_menu()"), desc("toggle registered buffer menu")}, {"<leader>tg", cmd("TigTermToggle"), desc("toggle tig terminal")}, {"<leader>ff", cmd("Telescope live_grep_args"), desc("search by content")}, {"<leader>fp", cmd("Ddu -name=fd file_fd"), desc("search by file name")}, {"<leader>fP", cmd("Ddu -name=ghq ghq"), desc("search repo (ghq)")}, {"<leader>fb", cmd("Telescope buffers"), desc("search buffer")}, {"<leader>fh", cmd("Legendary"), desc("search legendary")}, {"<leader>ft", cmd("Telescope sonictemplate templates"), desc("search templates")}, {"<leader>fru", cmd("Ddu -name=mru mru"), desc("MRU (Most Recently Used files)")}, {"<leader>frw", cmd("Ddu -name=mrw mrw"), desc("MRW (Most Recently Written files)")}, {"<leader>frr", cmd("Ddu -name=mrr mrr"), desc("MRR (Most Recent git Repositories)")}, {"<leader>fF", lua_cmd("require('spectre').open()"), desc("find and replace with dark power")}, {"<leader>rr", cmd("FlowRunFile")}}
local vs = {{"<leader>r", cmd("FlowRunSelected")}}
local is = {}
for _, keymap in ipairs(ns) do
  map("n", keymap[1], keymap[2], (keymap[3] or os))
end
for _, keymap in ipairs(vs) do
  map("v", keymap[1], keymap[2], (keymap[3] or os))
end
for _, keymap in ipairs(is) do
  map("v", keymap[1], keymap[2], (keymap[3] or os))
end
for i = 0, 9 do
  map({"n", "t", "i"}, ("<M-" .. i .. ">"), cmd(("TermToggle " .. i)), desc(("toggle terminal " .. i)))
end
map("n", "<leader>tq", mk_toggle(1, "quickfix", nil, desc("toggle quickfix")))
map("n", "<leader>td", mk_toggle(2, "trouble", {mode = "document_diagnostics"}), desc("toggle diagnostics (document)"))
map("n", "<leader>tD", mk_toggle(3, "trouble", {mode = "workspace_diagnostics"}), desc("toggle diagnostics (workspace)"))
map({"n", "x"}, "gs", lua_cmd("require('reacher').start()"), desc("search displayed"))
map({"n", "x"}, "gS", lua_cmd("require('reacher').start_multiple()"), desc("search displayed"))
return map({"n", "i", "c", "t"}, "\194\165", "\\")
