-- [nfnl] Compiled from neovim/fnl/neogit.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("neogit")
local integrations = {telescope = true, diffview = true, fzf_lua = nil}
return M.setup({use_default_keymaps = true, graph_style = "unicode", disable_signs = false, disable_context_highlighting = false, disable_hint = false})
