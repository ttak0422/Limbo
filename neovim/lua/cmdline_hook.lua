-- [nfnl] Compiled from neovim/fnl/cmdline_hook.fnl by https://github.com/Olical/nfnl, do not edit.
local opts = {ignorecase = true, smartcase = true, hlsearch = true, incsearch = true}
local create_user_command = vim.api.nvim_create_user_command
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
local ns = {{"<leader>/", cmd("SearchToQf"), mk_desc("register search results to quickfix")}, {"<leader>?", cmd("SearchToQf!", mk_desc("add search results to quickfix"))}}
for k, v in pairs(opts) do
  vim.o[k] = v
end
for _, k in ipairs(ns) do
  vim.keymap.set("n", k[1], k[2], (k[3] or default_ops))
end
local function _4_(opts0)
  local command
  if opts0.bang then
    command = "vimgrepadd"
  else
    command = "vimgrep"
  end
  local pattern = "//gj %"
  return vim.cmd((command .. " " .. pattern))
end
create_user_command("SearchToQf", _4_, {bang = true})
vim.cmd(("source " .. args.viml))
return vim.cmd(("source " .. args.cabbrev))
