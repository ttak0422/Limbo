-- [nfnl] Compiled from neovim/fnl/toggleterm.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("toggleterm")
local T = require("toggleterm.terminal")
local Terminal = T.Terminal
local create_cmd = vim.api.nvim_create_user_command
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
    local term
    if terms.idx then
      term = terms.idx
    else
      terms.idx = Terminal:new({direction = "float"})
      term = terms.idx
    end
    local is_open = term:is_open()
    local is_focused = term:is_focused()
    if is_open then
      if is_focused then
        return term:toggle()
      else
        term:focus()
        return vim.cmd("startinsert")
      end
    else
      term:toggle()
      return vim.cmd("startinsert")
    end
  end
  return _4_
end
toggle_term = _3_()
local toggle_tig
local function _8_()
  local tig = Terminal:new({cmd = "tig", dir = "git_dir", direction = "float"})
  local function _9_()
    return tig:toggle()
  end
  return _9_
end
toggle_tig = _8_()
M.setup({size = size, start_in_insert = true, winbar = {enabled = true}, shade_terminals = false, auto_scroll = false})
local function _10_(opts)
  return toggle_term(opts.args)
end
create_cmd("TermToggle", _10_, {nargs = 1})
return create_cmd("TigTermToggle", toggle_tig, {})
