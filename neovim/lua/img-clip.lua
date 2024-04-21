-- [nfnl] Compiled from neovim/fnl/img-clip.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("img-clip")
local filetypes = {markdown = {template = "![$CURSOR]($FILE_PATH)", download_images = true, url_encode_path = false}}
local default = {}
return M.setup({default = default, filetypes = filetypes})
