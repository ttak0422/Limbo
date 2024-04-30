-- [nfnl] Compiled from neovim/fnl/gopher.fnl by https://github.com/Olical/nfnl, do not edit.
local gopher = require("gopher")
local gopher_dap = require("gopher.dap")
gopher.setup()
return gopher_dap.setup()
