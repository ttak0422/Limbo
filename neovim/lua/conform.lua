-- [nfnl] Compiled from neovim/fnl/conform.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("conform")
local is_active_lsp
local function _1_(lsp_name)
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.buf_get_clients(bufnr)
  local acc = false
  for _, client in ipairs(clients) do
    acc = (acc or (lsp_name == client.name))
  end
  return acc
end
is_active_lsp = _1_
local formatters_by_ft = {dart = {"dart_format"}, json = {"fixjson"}, rust = {"rustfmt"}, shfmt = {"shfmt"}, lua = {"stylua"}, toml = {"taplo"}, html = {"htmlbeautifier"}, yaml = {"yamlfmt"}, python = {"yapf"}, fennel = {"fnlfmt"}, java = {"google-java-format"}, nix = {"nixfmt"}, typescript = {"prettier"}, javascript = {"prettier"}}
M.setup({formatters_by_ft = formatters_by_ft, notify_on_error = true, format_on_save = false})
local function _2_()
  return M.format({lsp_fallback = true, async = false})
end
return vim.api.nvim_create_user_command("Format", _2_, {})
