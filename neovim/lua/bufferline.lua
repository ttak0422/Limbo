-- [nfnl] Compiled from neovim/fnl/bufferline.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("bufferline")
local options = {separator_style = "thick", offsets = {{filetype = "NvimTree", text = "File Explorer", highlight = "Directory", text_align = "center"}}, show_buffer_close_icons = false, show_close_icon = false, show_buffer_icons = false}
return M.setup({options = options})
