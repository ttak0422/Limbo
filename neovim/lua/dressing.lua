-- [nfnl] Compiled from neovim/fnl/dressing.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("dressing")
local input = {enabled = true, default_prompt = "Input:", title_pos = "center", insert_inly = true, start_in_insert = true, border = "none", relative = "cursor", prefer_width = 0.4, buf_options = {}, win_options = {}, mappings = {n = {["<ESC>"] = "close", ["<CR>"] = "Confirm"}, i = {["<C-c>"] = "Close", ["<CR>"] = "Confirm", ["<Up>"] = "HistoryPrev", ["<Down>"] = "HistoryNext"}}}
local select = {enable = true, backend = {"telescope", "builtin"}, trim_prompt = true, telescope = (require("telescope.themes")).get_cursor()}
return M.setup({input = input, select = select})
