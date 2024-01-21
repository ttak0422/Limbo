-- [nfnl] Compiled from neovim/fnl/ionide.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("ionide")
M.setup({autostart = true, on_attach = dofile(args.on_attach_path), capabilities = dofile(args.capabilities_path)})
return vim.cmd("LspStart")
