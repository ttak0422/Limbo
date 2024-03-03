-- [nfnl] Compiled from neovim/fnl/lspconfig.fnl by https://github.com/Olical/nfnl, do not edit.
local on_attach = dofile(args.on_attach_path)
local capabilities = dofile(args.capabilities_path)
vim.diagnostic.config({severity_sort = true})
vim.lsp.set_log_level("WARN")
do end (vim.lsp.handlers)["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "single"})
do
  local signs = {{name = "DiagnosticSignError", text = "\239\129\151"}, {name = "DiagnosticSignWarn", text = "\239\129\177"}, {name = "DiagnosticSignInfo", text = "\239\129\154"}, {name = "DiagnosticSignHint", text = "\239\129\153"}}
  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, {texthl = sign.name, text = "", numhl = ""})
  end
end
local lspconfig = require("lspconfig")
local util = require("lspconfig.util")
local windows = require("lspconfig.ui.windows")
local climb = require("climbdir")
local marker = require("climbdir.marker")
windows.default_options.border = {"\226\148\143", "\226\148\129", "\226\148\147", "\226\148\131", "\226\148\155", "\226\148\129", "\226\148\151", "\226\148\131"}
lspconfig.lua_ls.setup({on_attach = on_attach, capabilities = capabilities, settings = {Lua = {runtime = {version = "LuaJIT"}, diagnostics = {globals = {"vim"}}}, workspace = {}, telemetry = {enable = false}}})
lspconfig.fennel_ls.setup({on_attach = on_attach, capabilities = capabilities, settings = {["fennel-ls"] = {["extra-globals"] = "vim"}}})
lspconfig.nil_ls.setup({on_attach = on_attach, capabilities = capabilities, autostart = true, settings = {["nil"] = {formatting = {command = {"nixpkgs-fmt"}}}}})
lspconfig.bashls.setup({on_attach = on_attach, capabilities = capabilities})
lspconfig.csharp_ls.setup({on_attach = on_attach, capabilities = capabilities})
lspconfig.pyright.setup({on_attach = on_attach, capabilities = capabilities})
lspconfig.solargraph.setup({on_attach = on_attach, capabilities = capabilities})
lspconfig.taplo.setup({on_attach = on_attach, capabilities = capabilities})
lspconfig.gopls.setup({on_attach = on_attach, capabilities = capabilities, settings = {gopls = {analyses = {unusedparams = true}}}, staticcheck = true})
lspconfig.dartls.setup({on_attach = on_attach, capabilities = capabilities})
lspconfig.dhall_lsp_server.setup({on_attach = on_attach, capabilities = capabilities})
lspconfig.yamlls.setup({on_attach = on_attach, capabilities = capabilities, settings = {yaml = {keyOrdering = false}}})
lspconfig.html.setup({on_attach = on_attach, capabilities = capabilities})
lspconfig.cssls.setup({on_attach = on_attach, capabilities = capabilities})
local function _1_(path)
  return climb.climb(path, marker.one_of(marker.has_readable_file("package.json"), marker.has_directory("node_modules")), {halt = marker.one_of(marker.has_readable_file("deno.json"))})
end
lspconfig.vtsls.setup({on_attach = on_attach, capabilities = capabilities, settings = {separate_diagnostic_server = true, publish_diagnostic_on = "insert_leave", typescript = {suggest = {completeFunctionCalls = true}, preferences = {importModuleSpecifier = "relative"}}}, root_dir = _1_, vtsls = {experimental = {completion = {enableServerSideFuzzyMatch = true}}}, single_file_support = false})
local function _2_(path)
  local found = climb.climb(path, marker.one_of(marker.has_readable_file("deno.json"), marker.has_readable_file("deno.jsonc"), marker.has_directory("denops")), {halt = marker.one_of(marker.has_readable_file("package.json"), marker.has_directory("node_modules"))})
  local buf = vim.b[vim.fn.bufnr()]
  if found then
    buf.deno_deps_candidate = (found .. "/deps.ts")
  else
  end
  return found
end
lspconfig.denols.setup({on_attach = on_attach, capabilities = capabilities, root_dir = _2_, init_options = {lint = true, suggest = {completeFunctionCalls = true, names = true, paths = true, autoImports = true, imports = {autoDiscover = true, hosts = vim.empty_dict()}}, unstable = false}, settings = {deno = {enable = true}}, single_file_support = false})
return lspconfig.marksman.setup({on_attach = on_attach, capabilities = capabilities})
