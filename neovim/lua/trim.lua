-- [nfnl] Compiled from neovim/fnl/trim.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("trim")
local ft_blocklist = {"markdown"}
return M.setup({ft_blocklist = ft_blocklist, trim_on_write = true, trim_trailing = true, trim_last_line = true, trim_first_line = true})
