-- [nfnl] Compiled from neovim/fnl/legendary.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("legendary")
local keymaps = {}
local commands = {{":UpdateRemotePlugins", description = "[REQUIRE] every time a remote plugin is installed updated or deleted"}, {":write | edit | TSBufEnable highlight", description = "reload file"}, {":so $VIMRUNTIME/syntax/hitest.vim", description = "enumerate highlight"}, {":call denops#plugin#reload('ddc')", description = "[WIP] reload ddc"}}
local functions = {}
local autocmds = {}
return M.setup({col_separator_char = "", keymaps = keymaps, commands = commands, functions = functions, autocmds = autocmds, include_builtin = false, include_legendary_cmds = false})
