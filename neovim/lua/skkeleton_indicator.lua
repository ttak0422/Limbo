-- [nfnl] Compiled from neovim/fnl/skkeleton_indicator.fnl by https://github.com/Olical/nfnl, do not edit.
local highlights = {SkkeletonIndicatorEiji = {fg = "#88c0d0", bg = "#2e3440", bold = true}, SkkeletonIndicatorHira = {fg = "#2e3440", bg = "#a3be8c", bold = true}, SkkeletonIndicatorKata = {fg = "#2e3440", bg = "#ebcb8b", bold = true}, SkkeletonIndicatorHankata = {fg = "#2e3440", bg = "#b48ead", bold = true}, SkkeletonIndicatorZenkaku = {fg = "#2e3440", bg = "#88c0d0", bold = true}, SkkeletonIndicatorAbbrev = {fg = "#e5e9f0", bg = "#bf616a", bold = true}}
local M = require("skkeleton_indicator")
for k, v in pairs(highlights) do
  vim.api.nvim_set_hl(0, k, v)
end
return M.setup({})
