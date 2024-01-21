-- [nfnl] Compiled from neovim/fnl/window-picker.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("window-picker")
local selection_display
local function _1_(char, _windowid)
  return ("%" .. char .. "%")
end
selection_display = _1_
local picker_config = {statusline_winbar_picker = {selection_display = selection_display, use_winbar = "never"}, floating_big_letter = {font = "ansi-shadow"}}
local filter_rules = {autoselect_one = true, bo = {filetype = dofile(args.exclude_ft_path), buftype = dofile(args.exclude_buf_ft_path)}, wo = {}, file_path_contains = {}, file_name_contains = {}, include_current_win = false}
local statusline = {focused = {fg = "#ededed", bg = "#e35e4f", bold = true}, unfocused = {fg = "#ededed", bg = "#44cc41", bold = true}}
local winbar = {focused = {fg = "#ededed", bg = "#e35e4f", bold = true}, unfocused = {fg = "#ededed", bg = "#44cc41", bold = true}}
local highlights = {statusline = statusline, winbar = winbar}
return M.setup({hint = "floating-big-letter", selection_chars = "FJDKSLA;CMRUEIWOQP", prompt_message = "Pick window: ", filter_func = nil, picker_config = picker_config, filter_rules = filter_rules, highlights = highlights, show_prompt = false})
