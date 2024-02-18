-- [nfnl] Compiled from neovim/fnl/kanagawa.fnl by https://github.com/Olical/nfnl, do not edit.
do
  local M = require("kanagawa")
  local function _1_(_)
    return {NormalFloat = {bg = "none"}, FloatBorder = {bg = "none"}, FloatTitle = {bg = "none"}}
  end
  M.setup({compile = true, colors = {palette = {samuraiRed = "#fa4343"}}, overrides = _1_})
end
return vim.cmd("colorscheme kanagawa")
