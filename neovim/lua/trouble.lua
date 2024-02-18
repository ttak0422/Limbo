-- [nfnl] Compiled from neovim/fnl/trouble.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("trouble")
local keys = {close = {"q", "<c-c>"}, cancel = "<esc>", refresh = "R", jump = {"<cr>"}, open_split = "s", open_vsplit = "v", open_tab = "t", jump_close = {}, toggle_mode = {}, switch_severity = "S", toggle_preview = {}, hover = "K", preview = {}, open_code_href = {}, close_folds = "zc", open_folds = "zo", toggle_fold = "za", previous = "k", next = "j", help = "g?"}
local auto_jump = {"lsp_definitions"}
local include_declaration = {"lsp_references", "lsp_implementations", "lsp_definitions"}
local signs = {error = "\239\129\151", warning = "\239\129\177", hint = "\239\129\153", information = "\239\129\154", other = "\239\145\132"}
return M.setup({position = "bottom", height = 10, icons = true, mode = "document_diagnostics", severity = vim.diagnostic.severity.INFO, fold_open = "\239\145\188", fold_closed = "\239\145\160", group = true, padding = true, multiline = true, indent_lines = true, win_config = {border = "single"}, auto_preview = true, keys = keys, auto_jump = auto_jump, include_declaration = include_declaration, signs = signs, auto_close = false, auto_open = false, use_diagnostic_signs = false, auto_fold = false, cycle_results = false})
