-- [nfnl] Compiled from neovim/fnl/BufferBrowser.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("buffer_browser")
local filetype_filters = dofile(args.exclude_ft_path)
return M.setup({filetype_filters = filetype_filters})
