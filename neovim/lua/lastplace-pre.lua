-- [nfnl] Compiled from neovim/fnl/lastplace-pre.fnl by https://github.com/Olical/nfnl, do not edit.
local ignore_buftype = {"quickfix", "nofile", "help"}
local ignore_filetype = {"gitcommit", "gitrebase", "svn", "hgcommit"}
vim.g.nvim_lastplace = {ignore_buftype = ignore_buftype, ignore_filetype = ignore_filetype, open_folds = true}
return nil
