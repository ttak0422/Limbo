-- [nfnl] Compiled from neovim/fnl/haskell-tools.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("haskell-tools")
return M.setup({on_attach = dofile(args.on_attach_path), capabilities = dofile(args.capabilities_path)})
