-- [nfnl] Compiled from neovim/fnl/treesitter.fnl by https://github.com/Olical/nfnl, do not edit.
local parser_install_dir = args.parser
do end (vim.opt.runtimepath):prepend(parser_install_dir)
local config = require("nvim-treesitter.configs")
local highlight
local function _1_(lang, buf)
  if (lang == "nix") then
    return true
  else
    local max_filesize = (100 * 1024)
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    return (ok and stats and (stats.size > max_filesize))
  end
end
highlight = {enable = true, disable = _1_, additional_vim_regex_highlighting = false}
local indent = {enable = false}
return config.setup({ignore_install = {}, parser_install_dir = parser_install_dir, highlight = highlight, indent = indent, sync_install = false, auto_install = false})
