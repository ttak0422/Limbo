-- [nfnl] Compiled from neovim/fnl/treesitter-pre.fnl by https://github.com/Olical/nfnl, do not edit.
local parser_install_dir = (vim.fn.stdpath("state") .. "/parser")
return (vim.opt.runtimepath):prepend(parser_install_dir)
