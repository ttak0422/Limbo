-- [nfnl] Compiled from neovim/fnl/satellite.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("satellite")
local cursor = {enable = true, symbols = {"\226\142\186", "\226\142\187", "\226\142\188", "\226\142\189"}}
local search = {enable = true}
local diagnostic = {enable = true, signs = {"-", "", "\226\137\161"}, min_severity = vim.diagnostic.severity.WARN}
local gitsigns = {enable = true, signs = {add = "\226\148\130", change = "\226\148\130", delete = "-"}}
local marks = {key = "m", show_builtins = false, enable = false}
local quickfix = {signs = {"-", "", "\226\137\161"}}
local handlers = {cursor = cursor, search = search, diagnostic = diagnostic, gitsigns = gitsigns, marks = marks, quickfix = quickfix}
return M.setup({current_only = true, winblend = 50, zindex = 40, excluded_filetypes = dofile(args.exclude_ft_path), width = 2, handlers = handlers})
