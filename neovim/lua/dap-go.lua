-- [nfnl] Compiled from neovim/fnl/dap-go.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("dap-go")
local dap_configurations = {{type = "go", name = "Attach remote", mode = "remote", request = "attach"}}
local delve = {initialize_timeout_sec = 20, port = "${port}"}
return M.setup({dap_configurations = dap_configurations, delve = delve})
