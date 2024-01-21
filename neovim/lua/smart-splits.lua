-- [nfnl] Compiled from neovim/fnl/smart-splits.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("smart-splits")
local ignored_filetypes = {"nofile", "quickfix", "prompt"}
local ignored_buftypes = {"NvimTree"}
local ignored_events = {"BufEnter", "WinEnter"}
local resize_mode = {quit_key = "<ESC>", resize_keys = {"h", "j", "k", "l"}, hooks = {on_enter = nil, on_leave = nil}, silent = false}
return M.setup({ignored_filetypes = ignored_filetypes, ignored_buftypes = ignored_buftypes, ignored_events = ignored_events, resize_mode = resize_mode, default_amount = 3, at_edge = "wrap", multiplexer_integration = nil, disable_multiplexer_nav_when_zoomed = true, kitty_password = nil, log_level = "warn", cursor_follows_swapped_bufs = false, move_cursor_same_row = false})
