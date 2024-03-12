-- [nfnl] Compiled from neovim/fnl/oil.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("oil")
local columns = {"icon"}
local border = {"\226\148\143", "\226\148\129", "\226\148\147", "\226\148\131", "\226\148\155", "\226\148\129", "\226\148\151", "\226\148\131"}
local buf_options = {bufhidden = "hide", buflisted = false}
local win_options = {signcolumn = "number", foldcolumn = "0", conceallevel = 3, concealcursor = "nvic", wrap = false, list = false, cursorcolumn = false, spell = false}
local keymaps = {["g?"] = "actions.show_help", ["<CR>"] = "actions.select", e = "actions.select", q = "actions.close", ["<C-c>"] = "actions.close", R = "actions.refresh", H = "actions.parent", L = "actions.select"}
local keymaps_help = {border = border}
local view_options
local function _1_(name, bufnr)
  return vim.startswith(name, ".")
end
local function _2_(name, bufnr)
  return false
end
view_options = {show_hidden = true, is_hidden_file = _1_, is_always_hidden = _2_, sort = {{"type", "asc"}, {"name", "asc"}}}
local float
local function _3_(conf)
end
float = {padding = 2, max_width = 90, max_height = 45, border = border, win_options = {winblend = 0}, override = _3_}
local preview = {max_width = 0.9, min_width = {40, 0.4}, width = nil, max_height = 0.9, min_height = {5, 0.1}, height = nil, border = border, win_options = {winblend = 0}, update_on_cursor_moved = true}
local progress = {max_width = 0.9, min_width = {40, 0.4}, width = nil, max_height = {10, 0.9}, min_height = {5, 0.1}, height = nil, border = border, minimized_border = "none", win_options = {winblend = 0}}
local ssh = {border = "single"}
local lsp_file_methods = {timeout_ms = 1000, autosave_changes = false}
return M.setup({delete_to_trash = true, prompt_save_on_select_new_entry = true, cleanup_delay_ms = 2000, constrain_cursor = "editable", lsp_file_methods = lsp_file_methods, columns = columns, buf_options = buf_options, win_options = win_options, keymaps = keymaps, keymaps_help = keymaps_help, view_options = view_options, float = float, preview = preview, progress = progress, ssh = ssh, experimental_watch_for_changes = false, use_default_keymaps = false, default_file_explorer = false, skip_confirm_for_simple_edits = false})
