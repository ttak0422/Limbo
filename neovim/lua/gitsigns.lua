-- [nfnl] Compiled from neovim/fnl/gitsigns.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("gitsigns")
local status_formatter
local function _1_(status)
  local added = status.added
  local changed = status.changed
  local removed = status.removed
  local status_txt = {}
  if (added and (added > 0)) then
    table.insert(status_txt, ("\239\145\151 " .. added))
  else
    if (changed and (changed > 0)) then
      table.insert(status_txt, ("\239\145\153 " .. changed))
    else
      if (removed and (removed > 0)) then
        table.insert(status_txt, ("\239\145\152 " .. removed))
      else
      end
    end
  end
  return table.concat(status_txt, " ")
end
status_formatter = _1_
local current_line_blame_opts = {virt_text = true, virt_text_pos = "eol", delay = 1000, ignore_whitespace = false}
local preview_config = {border = {"\226\148\143", "\226\148\129", "\226\148\147", "\226\148\131", "\226\148\155", "\226\148\129", "\226\148\151", "\226\148\131"}, style = "minimal", relative = "cursor", row = 0, col = 1}
local yadm = {enable = false}
return M.setup({signcolumn = true, numhl = true, current_line_blame = true, current_line_blame_formatter = "<author> <author_time:%Y-%m-%d> - <summary>", sign_priority = 6, update_debounce = 1000, max_file_length = 40000, status_formatter = status_formatter, current_line_blame_opts = current_line_blame_opts, preview_config = preview_config, yadm = yadm})
