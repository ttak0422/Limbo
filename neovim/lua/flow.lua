-- [nfnl] Compiled from neovim/fnl/flow.fnl by https://github.com/Olical/nfnl, do not edit.
local flow = require("flow")
local output = {buffer = true, size = 80, focused = true, window_override = {border = "none", title = "Output", title_pos = "center", style = "minimal"}, modifiable = false}
local filetype_cmd_map = {python = "python3 <<-EOF\n%s\nEOF"}
local sql_configs = nil
return flow.setup({output = output, filetype_cmd_map = filetype_cmd_map, sql_configs = sql_configs})
