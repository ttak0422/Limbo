-- [nfnl] Compiled from neovim/fnl/lint.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("lint")
local java = {"checkstyle", "typos"}
M.linters_by_ft = {java = java}
local function _1_()
  return M.try_lint()
end
return vim.api.nvim_create_autocmd({"BufWritePost", "BufEnter"}, {callback = _1_})
