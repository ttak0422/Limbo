-- [nfnl] Compiled from neovim/fnl/telescope.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("telescope")
local theme = require("telescope.themes")
local lga_actions = require("telescope-live-grep-args.actions")
local defaults = theme.get_ivy({path_display = {"truncate"}, prompt_prefix = "\239\128\130 ", selection_caret = "\239\129\161 ", mappings = {i = {["<C-j>"] = {"<Plug>(skkeleton-enable)", type = "command"}}}})
local extensions = {live_grep_args = {auto_quoting = true, mappings = {i = {["<C-t>"] = lga_actions.quote_prompt({postfix = " -t "}), ["<C-i>"] = lga_actions.quote_prompt({postfix = " --iglob "})}}}}
M.setup({defaults = defaults, extensions = extensions})
M.load_extension("live_grep_args")
return M.load_extension("sonictemplate")
