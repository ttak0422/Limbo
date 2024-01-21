-- [nfnl] Compiled from neovim/fnl/waitevent.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("waitevent")
local E
local function _1_(ctx, path)
  vim.cmd.split(path)
  ctx.lcd()
  vim.bo.bufhidden = "wipe"
  return nil
end
E = M.editor({open = _1_})
vim.env.GIT_EDITOR = E
return nil
