-- [nfnl] Compiled from neovim/fnl/toggleterm.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("toggleterm")
local T = (require("toggleterm.terminal")).Terminal
local cmd = vim.api.nvim_create_user_command
local size
local function _1_(term)
  if (term.direction == "horizontal") then
    return (vim.o.lines * 0.3)
  else
    return (vim.o.columns * 0.4)
  end
end
size = _1_
local toggle_term
local function _3_()
  local terms = {}
  local function _4_(idx)
    local _5_
    if not terms.idx then
      terms.idx = T:new({direction = "float"})
      _5_ = nil
    else
      if (terms[idx]):is_open() then
        if (terms[idx]):is_focused() then
          _5_ = (terms[idx]):toggle()
        else
          do end (terms[idx]):focus()
          _5_ = vim.cmd("startinsert")
        end
      else
        do end (terms[idx]):toggle()
        _5_ = vim.cmd("startinsert")
      end
    end
    return _5_()
  end
  return _4_
end
toggle_term = _3_()
local toggle_tig
local function _9_()
  local tig = T:new({cmd = "tig", dir = "git_dir", direction = "float"})
  local function _10_()
    return tig:toggle()
  end
  return _10_
end
toggle_tig = _9_()
M.setup({size = size, start_in_insert = true, winbar = {enabled = true}, shade_terminals = false, auto_scroll = false})
local function _11_(opts)
  return toggle_term(opts.args)
end
cmd("TermToggle", _11_, {nargs = 1})
return cmd("TigTermToggle", toggle_tig, {})
