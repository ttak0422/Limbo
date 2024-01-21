-- [nfnl] Compiled from neovim/fnl/reacher.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("reacher")
local m = vim.keymap.set
local o = {noremap = true, silent = true, buffer = true}
local pattern = {"reacher"}
local callback
local function _1_()
  m("i", "<cr>", reacher.finish, o)
  m("i", "<esc>", reacher.cancel, o)
  m("i", "<Tab>", reacher.next, o)
  m("i", "<S-Tab>", reacher.previous, o)
  m("i", "<C-n>", reacher.forward_history, o)
  return m("i", "<C-p>", reacher.backward_history, o)
end
callback = _1_
return vim.api.nvim_create_autocmd({"FileType"}, {pattern = pattern, callback = callback})
