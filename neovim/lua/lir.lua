-- [nfnl] Compiled from neovim/fnl/lir.fnl by https://github.com/Olical/nfnl, do not edit.
local lir = require("lir")
local actions = require("lir.actions")
local mark_actions = require("lir.mark.actions")
local clipboard_actions = require("lir.clipboard.actions")
local ignore = {".DS_Store"}
local devicons = {enable = true, highlight_dirname = true}
local mappings = {e = actions.edit, l = actions.edit, o = actions.edit, ["<CR>"] = actions.edit, h = actions.up, q = actions.quit, a = actions.newfile, r = actions.rename, d = actions.delete}
local float
local function _1_()
  local width = math.floor((vim.o.columns / 2))
  local height = math.floor((vim.o.lines / 2))
  return {relative = "editor", width = width, height = height, style = "minimal", border = {"\226\148\143", "\226\148\129", "\226\148\147", "\226\148\131", "\226\148\155", "\226\148\129", "\226\148\151", "\226\148\131"}}
end
float = {winblend = 0, curdir_window = {enable = true, highlight_dirname = true}, win_opts = _1_, hide_cursor = true}
return lir.setup({show_hidden_files = true, ignore = ignore, devicons = devicons, mappings = mappings, float = float})
