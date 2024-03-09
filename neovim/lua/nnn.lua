-- [nfnl] Compiled from neovim/fnl/nnn.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("nnn")
local picker = {}
local feedkeys
local function _1_(keys)
  return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), "n", true)
end
feedkeys = _1_
local mappings = {}
return M.setup({picker = picker, mappings = mappings})
