-- [nfnl] Compiled from neovim/fnl/oil.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("oil")
local columns = {"icon"}
local buf_options = {bufhidden = "hide", buflisted = false}
local win_options = {signcolumn = "number", foldcolumn = "0", conceallevel = 3, concealcursor = "nvic", wrap = false, list = false, cursorcolumn = false, spell = false}
local keymaps = {["g?"] = "actions.show_help", ["<CR>"] = "actions.select", e = "actions.select", ["<C-c>"] = "actions.close", R = "actions.refresh", h = "actions.parent", l = "actions.select"}
local keymaps_help = {border = "rounded"}
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
float = {padding = 2, max_width = 0, max_height = 0, border = "single", win_options = {winblend = 0}, override = _3_}
local preview = {max_width = 0.9, min_width = {40, 0.4}, width = nil, max_height = 0.9, min_height = {5, 0.1}, height = nil, border = "single", win_options = {winblend = 0}, update_on_cursor_moved = true}
local progress = {max_width = 0.9, min_width = {40, 0.4}, width = nil, max_height = {10, 0.9}, min_height = {5, 0.1}, height = nil, border = "single", minimized_border = "none", win_options = {winblend = 0}}
local ssh = {border = "single"}
return M.setup({delete_to_trash = true, prompt_save_on_select_new_entry = true, cleanup_delay_ms = 2000, constrain_cursor = "editable", columns = columns, buf_options = buf_options, win_options = win_options, keymaps = keymaps, keymaps_help = keymaps_help, float = float, preview = preview, progress = progress, ssh = ssh, default_file_explorer = false, use_default_keymaps = false, lsp_rename_autosave = false, skip_confirm_for_simple_edits = false, experimental_watch_for_changes = false})
