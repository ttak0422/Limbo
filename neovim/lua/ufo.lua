-- [nfnl] Compiled from neovim/fnl/ufo.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("ufo")
local provider_selector
local function _1_(bufnr, filetype, buftype)
  return {"treesitter", "indent"}
end
provider_selector = _1_
local map = vim.keymap.set
local opts = {foldcolumn = "1", foldlevel = 99, foldlevelstart = 99, foldenable = true, fillchars = "eob: ,fold: ,foldopen:\239\145\188,foldsep: ,foldclose:\239\145\160"}
local opt = {noremap = true, silent = true}
for k, v in pairs(opts) do
  vim.o[k] = v
end
M.setup({provider_selector = provider_selector})
map("n", "zR", M.openAllFolds, opt)
map("n", "zM", M.closeAllFolds, opt)
map("n", "zr", M.openFoldsExceptKinds, opt)
return map("n", "zm", M.closeFoldsWith, opt)
