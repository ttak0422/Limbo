-- [nfnl] Compiled from neovim/fnl/rainbow-delimiters.fnl by https://github.com/Olical/nfnl, do not edit.
local rainbow = require("rainbow-delimiters.setup")
local delimiters = require("rainbow-delimiters")
local strategy = {[""] = delimiters.strategy.global, vim = delimiters.strategy["local"]}
local query = {[""] = "rainbow-delimiters", lua = "rainbow-blocks"}
local highlight = {"RainbowDelimiterYellow", "RainbowDelimiterBlue", "RainbowDelimiterOrange", "RainbowDelimiterGreen", "RainbowDelimiterViolet", "RainbowDelimiterCyan"}
return rainbow.setup({strategy = strategy, query = query, highlight = highlight})
