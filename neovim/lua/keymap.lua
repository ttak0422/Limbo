-- [nfnl] Compiled from neovim/fnl/keymap.fnl by https://github.com/Olical/nfnl, do not edit.
vim.g.mapleader = " "
vim.g.maplocalleader = ","
local os = {noremap = true, silent = true}
local mk_desc
local function _1_(d)
  return {noremap = true, silent = true, desc = d}
end
mk_desc = _1_
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
ns = {{"q", "<nop>"}, {"<esc><esc>", cmd("nohl")}, {"j", "gj"}, {"k", "gk"}, {"<leader>tb", cmd("NvimTreeToggle")}, {"<leader>to", cmd("SidebarNvimToggle")}, {"<leader>tm", lua_cmd("require('codewindow').toggle_minimap()"), mk_desc("toggle minimap")}, {"<leader>tr", lua_cmd("require('harpoon.ui').toggle_quick_menu()"), mk_desc("toggle registered buffer menu")}, {"<leader>tg", cmd("TigTermToggle"), mk_desc("toggle tig terminal")}, {"<leader>gg", _9_, mk_desc("git command (echo)")}, {"<leader>gG", _10_, mk_desc("git command (buffer)")}, {"<leader>gb", cmd("execute printf('Gina blame --width=%d', &columns / 3)"), mk_desc("git blame")}, {"<leader>gs", cmd("GinStatus"), mk_desc("git status")}, {"<leader>gl", cmd("GinLog"), mk_desc("git log")}, {"<leader>ff", cmd("Telescope live_grep_args"), mk_desc("search by content")}, {"<leader>fp", cmd("Ddu -name=fd file_fd"), mk_desc("search by file name")}, {"<leader>fP", cmd("Ddu -name=ghq ghq"), mk_desc("search repo (ghq)")}, {"<leader>fb", cmd("Telescope buffers"), mk_desc("search buffer")}, {"<leader>fh", cmd("Legendary"), mk_desc("search legendary")}, {"<leader>ft", cmd("Telescope sonictemplate templates"), mk_desc("search templates")}, {"<leader>fru", cmd("Ddu -name=mru mru"), mk_desc("MRU (Most Recently Used files)")}, {"<leader>frw", cmd("Ddu -name=mrw mrw"), mk_desc("MRW (Most Recently Written files)")}, {"<leader>frr", cmd("Ddu -name=mrr mrr"), mk_desc("MRR (Most Recent git Repositories)")}, {"<leader>fF", lua_cmd("require('spectre').open()"), mk_desc("find and replace with dark power")}}
for _, keymap in ipairs(ns) do
  map("n", keymap[1], keymap[2], (keymap[3] or os))
end
for i = 0, 9 do
  map({"n", "t", "i"}, ("<C-" .. i .. ">"), cmd(("TermToggle " .. i)), mk_desc(("toggle terminal " .. i)))
end
map("n", "<leader>tq", mk_toggle(1, "quickfix", nil, mk_desc("toggle quickfix")))
map("n", "<leader>td", mk_toggle(2, "trouble", {mode = "document_diagnostics"}), mk_desc("toggle diagnostics (document)"))
return map("n", "<leader>tD", mk_toggle(3, "trouble", {mode = "workspace_diagnostics"}), mk_desc("toggle diagnostics (workspace)"))
