-- [nfnl] Compiled from neovim/fnl/lsp-lens.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("lsp-lens")
local sections = {references = true, implementation = true, definition = false}
local ignore_filetype = {"prisma"}
return M.setup({sections = sections, ignore_filetype = ignore_filetype, enable = false, include_declaration = false})
