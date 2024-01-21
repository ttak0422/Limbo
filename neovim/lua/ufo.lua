-- [nfnl] Compiled from neovim/fnl/ufo.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("ufo")
local provider_selector
local function _1_(bufnr, filetype, buftype)
  return {"treesitter", "indent"}
end
provider_selector = _1_
local m = vim.keymap.set
local o = {noremap = true, silent = true}
M.setup({provider_selector = provider_selector})
m("n", "zR", M.openAllFolds, o)
m("n", "zM", M.closeAllFolds, o)
m("n", "zr", M.openFoldsExceptKinds, o)
return m("n", "zm", M.closeFoldsWith, o)
