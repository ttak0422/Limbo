-- [nfnl] Compiled from neovim/fnl/indent-blankline.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("ibl")
local highlight = {"RainbowDelimiterYellow", "RainbowDelimiterBlue", "RainbowDelimiterOrange", "RainbowDelimiterGreen", "RainbowDelimiterViolet", "RainbowDelimiterCyan"}
local scope = {char = "\226\150\143", highlight = highlight, show_end = false, show_start = false}
vim.g.rainbow_delimiters = {highlight = highlight}
return M.setup({scope = scope, debounce = 200})
