-- [nfnl] Compiled from neovim/fnl/prelude.fnl by https://github.com/Olical/nfnl, do not edit.
local opts = {termguicolors = true, showmatch = true, completeopt = "", number = true, signcolumn = "yes", virtualedit = "block", cmdheight = 0, laststatus = 3, showtabline = 2, expandtab = true, tabstop = 2, shiftwidth = 2, foldcolumn = "1", foldlevel = 99, foldlevelstart = 99, foldenable = true, fillchars = "eob: ,fold: ,foldopen:\239\145\188,foldsep: ,foldclose:\239\145\160", cursorline = true, showmode = false}
vim.g.loaded_perl_provider = 0
vim.loader.enable()
for k, v in pairs(opts) do
  vim.o[k] = v
end
return nil
