-- [nfnl] Compiled from neovim/fnl/gitsigns.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("gitsigns")
local current_line_blame_opts = {virt_text = true, virt_text_pos = "eol", delay = 1000, ignore_whitespace = false}
local preview_config = {border = "none", style = "minimal", relative = "cursor", row = 0, col = 1}
local yadm = {enable = false}
return M.setup({signcolumn = true, numhl = true, current_line_blame = true, current_line_blame_formatter = "<author> <author_time:%Y-%m-%d> - <summary>", sign_priority = 6, update_debounce = 1000, max_file_length = 40000, current_line_blame_opts = current_line_blame_opts, preview_config = preview_config, yadm = yadm})
