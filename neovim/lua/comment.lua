-- [nfnl] Compiled from neovim/fnl/comment.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("Comment")
local toggler = {line = "gcc", block = "gCc"}
local opleader = {line = "gc", block = "gC"}
local mappings = {basic = true, extra = true}
return M.setup({toggler = toggler, opleader = opleader, mappings = mappings})
