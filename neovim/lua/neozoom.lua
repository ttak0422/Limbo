-- [nfnl] Compiled from neovim/fnl/neozoom.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require["neo-zoom"](require)
local exclude_buftypes = {}
local winopts = {offset = {height = 0.9}, border = {"\226\148\143", "\226\148\129", "\226\148\147", "\226\148\131", "\226\148\155", "\226\148\129", "\226\148\151", "\226\148\131"}}
local presets
local function _1_()
  vim.wo.wrap = true
  return nil
end
presets = {{filetypes = {"dapui_.*", "dap-repl"}, config = {top_ratio = 0.25, left_ratio = 0.4, width_ratio = 0.6, height_ratio = 0.65}, callbacks = {_1_}}}
local popup = {enabled = true}
return M.setup({exclude_buftypes = exclude_buftypes, winopts = winopts, popup = popup, presets = presets})
