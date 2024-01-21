-- [nfnl] Compiled from neovim/fnl/codewindow.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("codewindow")
local events = {"TextChanged", "InsertLeave", "DiagnosticChanged", "FileWritePost"}
return M.setup({exclude_filetypes = dofile(args.exclude_ft_path), max_minimap_height = nil, max_lines = nil, minimap_width = 10, use_treesitter = true, use_git = true, width_multiplier = 4, z_index = 1, show_cursor = true, window_border = "none", relative = "win", events = events, auto_enable = false, use_lsp = false, active_in_terminals = false})
