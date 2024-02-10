-- [nfnl] Compiled from neovim/fnl/treesitter.fnl by https://github.com/Olical/nfnl, do not edit.
do end (vim.opt.runtimepath):prepend(args.parser)
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
local yati = {enable = true, default_lazy = true, default_fallback = "auto"}
local indent = {enable = false}
local matchup = {enable = true}
local textobjects = {select = {enable = true, loopable = true, keymaps = {af = {query = "@function.outer", desc = "outer part of function"}, ["if"] = {query = "@function.inner", desc = "inner part of function"}, ac = {query = "@class.outer", desc = "outer part of class"}, ic = {query = "@class.inner", desc = "inner partof class"}}}, move = {enable = true, set_jumps = true, goto_next_start = {["]f"] = {query = "@function.outer", desc = "next function (start)"}, ["]z"] = {query = "@fold", desc = "next fold (start)"}}, goto_next_end = {["]F"] = {query = "@function.outer", desc = "next function (end)"}}, goto_previous_start = {["[f"] = {query = "@function.outer", desc = "prev function (start)"}, ["[z"] = {query = "@fold", desc = "prev fold (start)"}}, goto_previous_end = {["[F"] = {query = "@function.outer", desc = "prev function (end)"}}}}
return config.setup({ignore_install = {}, parseer_install_dir = args.parser, highlight = highlight, yati = yati, indent = indent, matchup = matchup, textobjects = textobjects, sync_install = false, auto_install = false})
