-- [nfnl] Compiled from neovim/fnl/conform.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("conform")
local formatters_by_ft = {dart = {"dart_format"}, json = {"fixjson"}, rust = {"rustfmt"}, shfmt = {"shfmt"}, lua = {"stylua"}, toml = {"taplo"}, html = {"htmlbeautifier"}, yaml = {"yamlfmt"}, python = {"yapf"}, fennel = {"fnlfmt"}, java = {"google-java-format"}, nix = {"nixfmt"}}
M.setup({formatters_by_ft = formatters_by_ft, notify_on_error = true, format_on_save = false})
local function _1_()
  return M.format({lsp_fallback = true, async = false})
end
return vim.api.nvim_create_user_command("Format", _1_, {})
