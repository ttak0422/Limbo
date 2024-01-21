-- [nfnl] Compiled from neovim/fnl/kanagawa.fnl by https://github.com/Olical/nfnl, do not edit.
do
  local kanagawa = require("kanagawa")
  local function _1_(colors)
    return {NormalFloat = {bg = "none"}, FloatBorder = {bg = "none"}, FloatTitle = {bg = "none"}}
  end
  kanagawa.setup({compile = true, undercurl = true, commentStyle = {italic = true}, functionStyle = {}, keywordStyle = {italic = true}, statementStyle = {bold = true}, typeStyle = {}, terminalColors = true, colors = {palette = {samuraiRed = "#fa4343"}, theme = {wave = {}, lotus = {}, dragon = {}, all = {}}}, overrides = _1_, theme = "wave", background = {dark = "wave", light = "lotus"}, dimInactive = false, transparent = false})
end
return vim.cmd("colorscheme kanagawa")
