-- [nfnl] Compiled from neovim/fnl/vtsls.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("vtsls")
local lspconfig = require("lspconfig")
local node_root_dir = lspconfig.util.root_pattern("package.json")
local is_node_repo = (node_root_dir(vim.api.nvim_buf_get_name(0)) ~= nil)
if is_node_repo then
  return M.config({refactor_auto_rename = true})
else
  return nil
end
