-- [nfnl] Compiled from neovim/fnl/editHook.fnl by https://github.com/Olical/nfnl, do not edit.
local opts = {expandtab = true, tabstop = 2, shiftwidth = 2, showmatch = true, completeopt = "", virtualedit = "block"}
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
local ns = {{"<leader>U", cmd("UndotreeToggle", mk_desc("toggle undotree"))}}
for k, v in pairs(opts) do
  vim.o[k] = v
end
for _, k in ipairs(ns) do
  vim.keymap.set("n", k[1], k[2], (k[3] or default_ops))
end
return nil
