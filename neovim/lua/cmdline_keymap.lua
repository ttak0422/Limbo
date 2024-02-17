-- [nfnl] Compiled from neovim/fnl/cmdline_keymap.fnl by https://github.com/Olical/nfnl, do not edit.
local mk_cmd = vim.api.nvim_create_user_command
local function _1_(opts)
  local command
  if opts.bang then
    command = "vimgrepadd"
  else
    command = "vimgrep"
  end
  local pattern = "//gj %"
  return vim.cmd((command .. " " .. pattern))
end
return mk_cmd("SearchToQf", _1_, {bang = true})
