-- [nfnl] Compiled from neovim/fnl/winsep.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("colorful-winsep")
local U = require("colorful-winsep.utils")
local symbols = {"\226\148\129", "\226\148\131", "\226\148\143", "\226\148\147", "\226\148\151", "\226\148\155"}
local no_exec_files = dofile(args.exclude_ft_path)
return M.setup({symbols = symbols})
