-- [nfnl] Compiled from neovim/fnl/surround.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("nvim-surround")
local keymaps = {insert = "<C-g>s", insert_line = "<C-g>S", normal = "ys", normal_cur = "yss", normal_line = "yS", normal_cur_line = "ySS", visual = "Y", visual_line = "gY", delete = "ds", change = "cs", change_line = "cS"}
return M.setup({keymaps = keymaps})
