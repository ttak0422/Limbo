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
  if (ctx.timer_state ~= T.TIMER_STATE.IDLE) then
    return string.format("%s %02d:%02d", prefix[ctx.timer_mode][ctx.timer_state], ctx.m, ctx.s)
  else
    return string.format("%s", prefix[ctx.timer_mode][ctx.timer_state])
  end
end
focus_format = _2_
local break_format
local function _4_(ctx)
  return string.format("%s %02d %02d", prefix[ctx.timer_mode][ctx.timer_state], ctx.m, ctx.s)
end
break_format = _4_
local on_start
local function _5_()
  if (vim.fn.has("mac") == 1) then
    vim.fn.system("osascript -e 'display notification \"Start!\" with title \"pomodoro\" sound name \"Bell\"'")
  else
    vim.notify("Start!")
  end
  return vim.cmd("redrawstatus")
end
on_start = _5_
local on_pause
local function _7_()
  if (vim.fn.has("mac") == 1) then
    return vim.fn.system("osascript -e 'display notification \"Pause!\" with title \"pomodoro\" sound name \"Bell\"'")
  else
    return vim.notify("Pause!")
  end
end
on_pause = _7_
local on_complete_focus_time
local function _9_()
  if (vim.fn.has("mac") == 1) then
    return vim.fn.system("osascript -e 'display notification \"Focus time is over!\" with title \"pomodoro\" sound name \"Bell\"'")
  else
    return vim.notify("Focus time is over!")
  end
end
on_complete_focus_time = _9_
local on_complete_break_time
local function _11_()
  if (vim.fn.has("mac") == 1) then
    return vim.fn.system("osascript -e 'display notification \"Focus time is over!\" with title \"pomodoro\" sound name \"Bell\"'")
  else
    return vim.notify("Focus time is over!")
  end
end
on_complete_break_time = _11_
focus[T.TIMER_START.IDLE] = "\239\137\148"
focus[T.TIMER_STATE.ACTIVE] = "\239\129\140 focus"
focus[T.TIMER_STATE.PAUSE] = "\239\129\139 focus"
_break[T.TIMER_STATE.IDLE] = "\239\129\139 break"
_break[T.TIMER_STATE.ACTIVE] = "\239\129\140 break"
_break[T.TIMER_STATE.PAUSE] = "\239\129\139 break"
long_break[T.TIMER_STATE.IDLE] = "\239\129\139 break"
long_break[T.TIMER_STATE.ACTIVE] = "\239\129\140 break"
long_break[T.TIMER_STATE.PAUSE] = "\239\129\139 break"
prefix[T.TIMER_MODE.FOCUS] = focus
prefix[T.TIMER_MODE.BREAK] = _break
prefix[T.TIMER_MODE.LONG_BREAK] = long_break
return M.setup({on_update = on_update, focus_format = focus_format, break_format = break_format, on_start = on_start, on_pause = on_pause, on_complete_focus_time = on_complete_focus_time, on_complete_break_time = on_complete_break_time})
