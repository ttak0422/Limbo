-- [nfnl] Compiled from neovim/fnl/goto-preview.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("goto-preview")
local border = "none"
local post_open_hook
local function _1_(_, win)
  return vim.api.nvim_win_set_option(win, "winhighlight", "Normal:")
end
post_open_hook = _1_
local post_close_hook = nil
return M.setup({height = 20, width = 120, focus_on_open = true, opacity = nil, border = border, post_close_hook = post_close_hook, resizing_mappings = false, dismiss_on_move = false, debug = false, default_mappings = false})
