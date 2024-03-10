-- [nfnl] Compiled from neovim/fnl/prelude.fnl by https://github.com/Olical/nfnl, do not edit.
local opts = {termguicolors = true, signcolumn = "no", showtabline = 0, foldlevel = 99, foldlevelstart = 99, showmode = false, number = false}
vim.g.loaded_perl_provider = 0
vim.loader.enable()
for k, v in pairs(opts) do
  vim.o[k] = v
end
return nil
