-- [nfnl] Compiled from neovim/fnl/rustaceanvim.fnl by https://github.com/Olical/nfnl, do not edit.
local server = {on_attach = dofile(args.on_attach_path)}
local tools
do
  local executors = require("rustaceanvim.executors")
  local code_actions = {ui_select_fallback = true}
  local float_win_config = {border = {"\226\148\143", "\226\148\129", "\226\148\147", "\226\148\131", "\226\148\155", "\226\148\129", "\226\148\151", "\226\148\131"}}
  tools = {executors = executors, code_actions = code_actions, float_win_config = float_win_config}
end
vim.g.rustaceanvim = {server = server, tools = tools}
return nil
