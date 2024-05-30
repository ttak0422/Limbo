-- [nfnl] Compiled from neovim/fnl/none-ls.fnl by https://github.com/Olical/nfnl, do not edit.
if (vim.fn.filereadable("~/.local/share/cspell/user.txt") ~= 1) then
  io.popen("mkdir -p ~/.local/share/cspell")
  io.popen("touch ~/.local/share/cspell/user.txt")
else
end
local function cspell_append(opts)
  local dict_path = "~/.local/share/cspell/user.txt"
  local word
  if (not opts.word or (opts.word == "")) then
    word = vim.call("expand", "<cword>"):lower()
  else
    word = opts.word
  end
  io.popen(("echo " .. word .. " >> " .. dict_path))
  vim.notify(("`" .. word .. "`" .. " is appended to user dictionary."), vim.log.levels.INFO, {})
  if vim.api.nvim_get_option_value("modifiable", {}) then
    vim.api.nvim_set_current_line(vim.api.nvim_get_current_line())
    return vim.api.nvim_command("silent! undo")
  else
    return nil
  end
end
local function is_active_lsp(lsp_name)
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.buf_get_clients(bufnr)
  local acc = false
  for _, client in ipairs(clients) do
    acc = (acc or (lsp_name == client.name))
  end
  return acc
end
local null = require("null-ls")
local utils = require("null-ls.utils")
local helpers = require("null-ls.helpers")
local formatter_factory = require("null-ls.helpers.formatter_factory")
local methods = require("null-ls.methods")
local CODE_ACTION = methods.internal.CODE_ACTION
local cspell_append_action
local function _4_(...)
  local lnum = (vim.fn.getcurpos()[2] - 1)
  local col = vim.fn.getcurpos()[3]
  local diagnostics = vim.diagnostic.get(0, {lnum = lnum})
  local regex = "^Unknown word %((%w+)%)$"
  local word
  do
    local acc = ""
    for _, d in ipairs(diagnostics) do
      if ((d.source == "cspell") and (d.col < col) and (col <= d.end_col) and string.match(d.message, regex)) then
        acc = string.gsub(d.message, regex, "%1"):lower()
      else
        acc = acc
      end
    end
    word = acc
  end
  if (word ~= "") then
    local function _6_()
      return cspell_append({args = word})
    end
    return {{title = ("Append " .. word .. " to user dictionary"), action = _6_}}
  else
    return nil
  end
end
cspell_append_action = {name = "cspell-append", method = CODE_ACTION, filetypes = {}, generator = {fn = _4_}}
local FORMATTING = methods.internal.FORMATTING
local dhall_format = {name = "dhall-format", method = {FORMATTING}, filetypes = {"dhall"}, generator = null.formatter({command = "dhall", args = {"format", "$FILENAME"}, to_stdin = true})}
local fnlfmt = {name = "fnlfmt", method = {FORMATTING}, filetypes = {"fennel"}, generator = null.formatter({command = "fnlfmt", args = {"$FILENAME"}, to_stdin = true})}
local sources
local function _8_(utils0)
  return utils0.root_has_file({"eslint.config.js", ".eslintrc", ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.yaml", ".eslintrc.yml", ".eslintrc.json"})
end
local function _9_(...)
  return is_active_lsp("vtsls")
end
local function _10_(...)
  return is_active_lsp("denols")
end
sources = {null.builtins.diagnostics.eslint.with({prefer_local = "node_modules/.bin", condition = _8_}), null.builtins.formatting.tidy, null.builtins.formatting.fixjson, null.builtins.formatting.taplo, null.builtins.formatting.shfmt, null.builtins.formatting.stylua, null.builtins.formatting.yapf, null.builtins.formatting.google_java_format, null.builtins.formatting.nixfmt, null.builtins.formatting.dart_format, null.builtins.formatting.gofmt, null.builtins.formatting.rustfmt, null.builtins.formatting.yamlfmt, null.builtins.formatting.prettier.with({prefer_local = "node_modules/.bin", runtime_condition = _9_}), null.builtins.formatting.deno_fmt.with({runtime_condition = _10_}), dhall_format, fnlfmt}
null.setup({border = "none", cmd = {"nvim"}, debounce = 250, default_timeout = 5000, diagnostic_config = {}, diagnostics_format = "#{m}", fallback_severity = vim.diagnostic.severity.ERROR, log_level = "warn", notify_format = "[null-ls] %s", on_attach = nil, on_init = nil, on_exit = nil, root_dir = utils.root_pattern({".null-ls-root", ".git"}), should_attach = nil, temp_dir = nil, sources = sources, update_in_insert = false, debug = false})
vim.api.nvim_create_user_command("Format", "lua vim.lsp.buf.format()", {})
return nil
