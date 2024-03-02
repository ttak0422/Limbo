-- [nfnl] Compiled from neovim/fnl/hover.fnl by https://github.com/Olical/nfnl, do not edit.
local hover = require("hover")
local init
local function _1_()
  return require("hover.providers.lsp")
end
init = _1_
local preview_opts = {border = "single"}
local mouse_providers = {"LSP"}
return hover.setup({init = init, preview_opts = preview_opts, mouse_providers = mouse_providers, mouse_dely = 1000, preview_window = false})
