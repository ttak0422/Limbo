-- [nfnl] Compiled from neovim/fnl/nap.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("nap")
local diagnostic_wrn_options = {severity = {min = vim.diagnostic.severity.WARN}, float = false}
local diagnostic_err_options = {severity = {min = vim.diagnostic.severity.ERROR}, float = false}
local cmd
local function _1_(c)
  return ("<cmd>" .. c .. "<cr>")
end
cmd = _1_
local lua_cmd
local function _2_(c)
  return ("<cmd>" .. "lua " .. c .. "<cr>")
end
lua_cmd = _2_
local get_qflist_nr
local function _3_(nr)
  return (vim.fn.getqflist({nr = nr})).nr
end
get_qflist_nr = _3_
local safe_qf_colder
local function _4_()
  local idx = get_qflist_nr(0)
  if (1 < idx) then
    return vim.cmd("silent colder")
  else
    return vim.notify("reached start of quickfix list")
  end
end
safe_qf_colder = _4_
local safe_qf_cnewer
local function _6_()
  local idx = get_qflist_nr(0)
  local last_idx = get_qflist_nr("$")
  if (idx < last_idx) then
    return vim.cmd("silent cnewer")
  else
    return vim.notify("reached end of quickfix list")
  end
end
safe_qf_cnewer = _6_
local operators
local function _8_()
  return vim.diagnostic.goto_prev(diagnostic_wrn_options)
end
local function _9_()
  return vim.diagnostic.goto_next(diagnostic_wrn_options)
end
local function _10_()
  return vim.diagnostic.goto_prev(diagnostic_err_options)
end
local function _11_()
  return vim.diagnostic.goto_next(diagnostic_err_options)
end
operators = {m = {prev = {rhs = "<Plug>(Marks-prev)", opts = {desc = "prev mark"}}, next = {rhs = "<Plug>(Marks-next)", opts = {desc = "next mark"}}}, b = {prev = {rhs = cmd("bprevious"), opts = {desc = "prev buffer"}}, next = {rhs = cmd("bnext"), opts = {desc = "next buffer"}}}, B = {prev = {rhs = lua_cmd("require('buffer_browser').prev()"), opts = {desc = "prev buffer (history)"}}, next = {rhs = lua_cmd("require('buffer_browser').next()"), opts = {desc = "next buffer (history)"}}}, r = {prev = {rhs = lua_cmd("require('harpoon.ui').nav_prev()"), opts = {desc = "prev registered buffer"}}, next = {rhs = lua_cmd("require('harpoon.ui').nav_next()"), opts = {desc = "next registered buffer"}}}, e = {prev = {rhs = "g,", opts = {desc = "prev edit"}}, next = {rhs = "g;", opts = {desc = "next edit"}}}, d = {prev = {rhs = _8_, opts = {desc = "prev diagnostic warning"}}, next = {rhs = _9_, opts = {desc = "next diagnostic warning"}}, mode = {"n", "v", "o"}}, D = {prev = {rhs = _10_, opts = {desc = "prev diagnostic error"}}, next = {rhs = _11_, opts = {desc = "next diagnostic error"}}, mode = {"n", "v", "o"}}, q = {prev = {rhs = cmd("Qprev"), opts = {desc = "prev quickfix"}}, next = {rhs = cmd("Qnext"), opts = {desc = "next quickfix"}}}, Q = {prev = {rhs = cmd("qfirst"), opts = {desc = "first quickfix"}}, next = {rhs = cmd("qlast"), opts = {desc = "last quickfix"}}}, ["<C-q>"] = {prev = {rhs = cmd("cpfile"), opts = {desc = "prev quickfix file"}}, next = {rhs = cmd("cnfile"), opts = {desc = "next quickfix file"}}}, ["<M-q>"] = {prev = {rhs = safe_qf_colder, opts = {desc = "prev quickfix list"}}, next = {rhs = safe_qf_cnewer, opts = {desc = "next quickfix list"}}}, l = {prev = {rhs = cmd("Lprev"), opts = {desc = "prev location"}}, next = {rhs = cmd("Lnext"), opts = {desc = "next location"}}}, L = {prev = {rhs = cmd("lfirst"), opts = {desc = "first location"}}, next = {rhs = cmd("llast"), opts = {desc = "last location"}}}, ["<C-l>"] = {prev = {rhs = cmd("lpfile"), opts = {desc = "prev location file"}}, next = {rhs = cmd("lnfile"), opts = {desc = "next location file"}}}, ["<M-l>"] = {prev = {rhs = cmd("lolder"), opts = {desc = "prev location list"}}, next = {rhs = cmd("lnewer"), opts = {desc = "next location list"}}}}
return M.setup({next_prefix = "]", prev_prefix = "[", next_repeat = "<c-n>", prev_repeat = "<c-p>", operators = operators})
