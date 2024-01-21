-- [nfnl] Compiled from neovim/fnl/harpoon.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("harpoon")
local global_settings = {save_on_change = true, excluded_filetypes = {"harpoon"}, tabline_prefix = "   ", tabline_suffix = "   ", save_on_toggle = false, enter_on_sendcmd = false, tmux_autoclose_windows = false, mark_branch = false, tabline = false}
return M.setup({global_settings = global_settings})
