-- [nfnl] Compiled from neovim/fnl/goto-preview.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("goto-preview")
local border = {"\226\148\143", "\226\148\129", "\226\148\147", "\226\148\131", "\226\148\155", "\226\148\129", "\226\148\151", "\226\148\131"}
local post_open_hook
local function _1_(_, win)
  return vim.api.nvim_win_set_option(win, "winhighlight", "Normal:")
end
post_open_hook = _1_
return M.setup({height = 30, border = border, post_open_hook = post_open_hook})
