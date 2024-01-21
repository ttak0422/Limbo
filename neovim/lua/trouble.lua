-- [nfnl] Compiled from neovim/fnl/trouble.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("trouble")
local keys = {close = {"q", "<c-c>"}, cancel = "<esc>", refresh = "R", jump = {"<cr>", "<tab>", "<2-leftmouse>"}, open_split = "<c-s>", open_vsplit = "<c-v>", open_tab = "<c-t>", jump_close = {}, toggle_mode = {}, switch_severity = "s", toggle_preview = {}, hover = "K", preview = {}, open_code_href = {}, close_folds = "zc", open_folds = "zo", toggle_fold = "za", previous = "k", next = "j", help = "?"}
local auto_jump = {"lsp_definitions"}
local include_declaration = {"lsp_references", "lsp_implementations", "lsp_definitions"}
return M.setup({position = "bottom", height = 10, icons = true, mode = "workspace_diagnostics", severity = nil, fold_open = "\239\145\188", fold_closed = "\239\145\160", group = true, padding = true, multiline = true, indent_lines = true, win_config = {border = "single"}, auto_preview = true, use_diagnostic_signs = true, keys = keys, auto_jump = auto_jump, include_declaration = include_declaration, auto_fold = false, auto_open = false, cycle_results = false, auto_close = false})
