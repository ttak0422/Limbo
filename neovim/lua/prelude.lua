-- [nfnl] Compiled from neovim/fnl/prelude.fnl by https://github.com/Olical/nfnl, do not edit.
local cache_path = vim.fn.stdpath("cache")
local opts = {helplang = "ja,en", mouse = "a", ignorecase = true, smartcase = true, hlsearch = true, incsearch = true, hidden = true, termguicolors = true, autoread = true, showmatch = true, completeopt = ("menuone" .. "," .. "preview"), number = true, signcolumn = "yes", virtualedit = "block", cmdheight = 0, laststatus = 3, showtabline = 2, undofile = true, undodir = (cache_path .. "/undo"), swapfile = true, directory = (cache_path .. "/swap"), winwidth = 20, winheight = 1, expandtab = true, tabstop = 2, shiftwidth = 2, foldcolumn = "1", foldlevel = 99, foldlevelstart = 99, foldenable = true, fillchars = "eob: ,fold: ,foldopen:\239\145\188,foldsep: ,foldclose:\239\145\160", backup = true, backupcopy = "yes", backupdir = (cache_path .. "/backup"), splitright = true, splitbelow = true, diffopt = "internal,filler,closeoff,vertical", equalalways = false, startofline = false, showmode = false}
local disable_plugins = {"loaded_2html_plugin", "loaded_gzip", "loaded_tar", "loaded_tarPlugin", "loaded_zip", "loaded_zipPlugin", "loaded_vimball", "loaded_vimballPlugin", "loaded_netrw", "loaded_netrwPlugin", "loaded_netrwSettings", "loaded_netrwFileHandlers", "loaded_getscript", "loaded_getscriptPlugin", "loaded_man", "loaded_matchit", "loaded_matchparen", "loaded_shada_plugin", "loaded_spellfile_plugin", "loaded_tutor_mode_plugin", "did_install_default_menus", "did_install_syntax_menu", "skip_loading_mswin", "did_indent_on", "did_load_ftplugin", "loaded_rrhelper"}
vim.g.loaded_perl_provider = 0
vim.loader.enable()
for k, v in pairs(opts) do
  vim.o[k] = v
end
for _, p in ipairs(disable_plugins) do
  vim.g[p] = 1
end
return nil
