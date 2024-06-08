-- [nfnl] Compiled from neovim/fnl/headlines.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("headlines")
local markdown = {fat_headlines = false}
local rmd = {fat_headlines = false}
local norg = {fat_headlines = false}
local org = {fat_headlines = false}
return M.setup({markdown = markdown, rmd = rmd, norg = norg, org = org})
