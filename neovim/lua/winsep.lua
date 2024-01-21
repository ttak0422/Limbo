-- [nfnl] Compiled from neovim/fnl/winsep.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("colorful-winsep")
local U = require("colorful-winsep.utils")
local symbols = {"\226\148\129", "\226\148\131", "\226\148\143", "\226\148\147", "\226\148\151", "\226\148\155"}
local create_event
local function _1_()
  if (U.calculate_number_windows() == 2) then
    local win_id = vim.fn.win_getid(vim.fn.winnr("h"))
    local filetype = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(win_id), "filetype")
    if (filetype == "NvimTree") then
      return M.NvimSeparatorDel()
    else
      return nil
    end
  else
    return nil
  end
end
create_event = _1_
return M.setup({symbols = symbols, create_event = create_event})
