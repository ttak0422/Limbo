-- [nfnl] Compiled from neovim/fnl/auto-indent.fnl by https://github.com/Olical/nfnl, do not edit.
local auto_indent = require("auto-indent")
local ts_indent = require("nvim-treesitter.indent")
local ignore_filetype = {}
local function _1_(lnum)
  return ts_indent.get_indent(lnum)
end
return auto_indent.setup({lightmode = true, indentexpr = _1_, ignore_filetype = ignore_filetype})
