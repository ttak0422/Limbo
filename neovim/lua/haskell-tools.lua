-- [nfnl] Compiled from neovim/fnl/haskell-tools.fnl by https://github.com/Olical/nfnl, do not edit.
local ht = require("haskell-tools")
local tools = {log = {level = vim.log.levels.ERROR}}
local hls = {on_attach = dofile(args.on_attach_path), capabilities = dofile(args.capabilities_path)}
local dap = {}
vim.g.haskell_tools = {tools = tools, hls = hls, dap = dap}
return nil
