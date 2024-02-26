-- [nfnl] Compiled from neovim/fnl/conform.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("conform")
local formatters_by_ft = {java = {"google-java-format"}, fennel = {"fnlfmt"}}
M.setup({formatters_by_ft = formatters_by_ft, notify_on_error = true, format_on_save = false})
local function _1_()
  return M.format({async = true, lsp_fallback = true})
end
return vim.api.nvim_create_user_command("Format", _1_, {})
