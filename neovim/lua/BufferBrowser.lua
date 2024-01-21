-- [nfnl] Compiled from neovim/fnl/BufferBrowser.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("buffer_browser")
local filetype_filters = {"gitcommit", "TelescopePrompt"}
return M.setup({filetype_filters = filetype_filters})
