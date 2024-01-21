-- [nfnl] Compiled from neovim/fnl/stickybuf.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("stickybuf")
local get_auto_pin
local function _1_(bufnr)
  return M.should_auto_pin(bufnr)
end
get_auto_pin = _1_
M.setup({get_auto_pin = get_auto_pin})
local function _2_()
  if (not M.is_pinned() or (vim.wo.winfixwidth or vim.wo.winfixheight)) then
    return M.pin()
  else
    return nil
  end
end
return vim.api.nvim_create_autocmd("BufEnter", {callback = _2_})
