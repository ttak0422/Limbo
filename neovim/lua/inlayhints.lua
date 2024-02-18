-- [nfnl] Compiled from neovim/fnl/inlayhints.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("lsp-inlayhints")
local inlay_hints = {parameter_hints = {show = true, prefix = "\226\134\144 ", separator = " ", remove_colon_end = true, remove_colon_start = false}, type_hints = {show = true, prefix = "", separator = " ", remove_colon_start = false, remove_colon_end = false}, labels_separator = " ", max_len_align_padding = 1, highlight = "LspInlayHint", priority = 0, only_current_line = false, max_len_align = false}
return M.setup({enabled_at_startup = true, inlay_hints = inlay_hints, debug_mode = false})
