-- [nfnl] Compiled from neovim/fnl/piccolo-pomodoro.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("piccolo-pomodoro")
local T = require("piccolo-pomodoro.type")
local prefix = {}
local focus = {}
local _break = {}
local long_break = {}
local on_update
local function _1_()
  return vim.cmd("redrawstatus")
end
on_update = _1_
local focus_format
local function _2_(ctx)
  return string.format("%s%02d:%02d", prefix[ctx.timer_mode][ctx.timer_state], ctx.m, ctx.s)
end
focus_format = _2_
local break_format
local function _3_(ctx)
  return string.format("%s%02d %02d", prefix[ctx.timer_mode][ctx.timer_state], ctx.m, ctx.s)
end
break_format = _3_
local on_start
local function _4_()
  if (vim.fn.has("mac") == 1) then
    vim.fn.system("osascript -e 'display notification \"Start!\" with title \"pomodoro\" sound name \"Bell\"'")
  else
    vim.notify("Start!")
  end
  return vim.cmd("redrawstatus")
end
on_start = _4_
local on_pause
local function _6_()
  if (vim.fn.has("mac") == 1) then
    vim.fn.system("osascript -e 'display notification \"Pause!\" with title \"pomodoro\" sound name \"Bell\"'")
  else
    vim.notify("Pause!")
  end
  return vim.cmd("redrawstatus")
end
on_pause = _6_
local on_complete_focus_time
local function _8_()
  if (vim.fn.has("mac") == 1) then
    return vim.fn.system("osascript -e 'display notification \"Focus time is over!\" with title \"pomodoro\" sound name \"Bell\"'")
  else
    return vim.notify("Focus time is over!")
  end
end
on_complete_focus_time = _8_
local on_complete_break_time
local function _10_()
  if (vim.fn.has("mac") == 1) then
    return vim.fn.system("osascript -e 'display notification \"Focus time is over!\" with title \"pomodoro\" sound name \"Bell\"'")
  else
    return vim.notify("Focus time is over!")
  end
end
on_complete_break_time = _10_
focus[T.TIMER_STATE.IDLE] = "\239\134\146 "
focus[T.TIMER_STATE.ACTIVE] = "\239\138\139 "
focus[T.TIMER_STATE.PAUSE] = "\239\133\132 "
_break[T.TIMER_STATE.IDLE] = "\239\134\146 BREAK "
_break[T.TIMER_STATE.ACTIVE] = "\239\138\139 BREAK "
_break[T.TIMER_STATE.PAUSE] = "\239\133\132 BREAK "
long_break[T.TIMER_STATE.IDLE] = "\239\134\146 BREAK "
long_break[T.TIMER_STATE.ACTIVE] = "\239\138\139 BREAK "
long_break[T.TIMER_STATE.PAUSE] = "\239\133\132 BREAK "
prefix[T.TIMER_MODE.FOCUS] = focus
prefix[T.TIMER_MODE.BREAK] = _break
prefix[T.TIMER_MODE.LONG_BREAK] = long_break
return M.setup({on_update = on_update, focus_format = focus_format, break_format = break_format, on_start = on_start, on_pause = on_pause, on_complete_focus_time = on_complete_focus_time, on_complete_break_time = on_complete_break_time})
