-- [nfnl] Compiled from neovim/fnl/ufo.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("ufo")
local provider_selector
local function _1_(bufnr, filetype, buftype)
  return {"treesitter", "indent"}
end
provider_selector = _1_
local map = vim.keymap.set
local opt = {noremap = true, silent = true}
M.setup({provider_selector = provider_selector})
map("n", "zR", M.openAllFolds, opt)
map("n", "zM", M.closeAllFolds, opt)
map("n", "zr", M.openFoldsExceptKinds, opt)
return map("n", "zm", M.closeFoldsWith, opt)
