-- [nfnl] Compiled from neovim/fnl/nvim-tree.fnl by https://github.com/Olical/nfnl, do not edit.
local tree = require("nvim-tree")
local api = require("nvim-tree.api")
local on_attach
local function _1_(bufnr)
  local f
  local function _2_(desc)
    return {desc = desc, buffer = bufnr, noremap = true, silent = true, nowait = true}
  end
  f = _2_
  local keys = {{"K", api.node.show_info_popup, "Info"}, {"t", api.node.open.tab, "Open: New Tab"}, {"v", api.node.open.vertical, "Open: Vertical"}, {"s", api.node.open.horizontal, "Open: Horizontal"}, {"<BS>", api.node.navigate.parent_close, "Close Directory"}, {"<CR>", api.node.open.edit, "Open"}, {"a", api.fs.create, "Create File Or Directory"}, {"[c", api.node.navigate.git.prev, "Prev Git"}, {"]c", api.node.navigate.git.next, "Next Git"}, {"[d", api.node.navigate.diagnostics.prev, "Prev Diagnostic"}, {"]d", api.node.navigate.diagnostics.next, "Next Diagnostic"}, {"d", api.fs.remove, "Delete"}, {"D", api.fs.trash, "Trash"}, {"f", api.live_filter.start, "Start Filter"}, {"F", api.live_filter.clear, "Clear Filter"}, {"g?", api.tree.toggle_help, "Help"}, {"H", api.tree.toggle_hidden_filter, "Toggle Hidden"}, {"I", api.tree.toggle_hidden_filter, "Toggle Ignore"}, {".", api.node.run.cmd, "Run Command"}, {"o", api.node.open.edit, "Open"}, {"r", api.fs.rename, "Rename"}, {"R", api.tree.reload, "Reload"}}
  for _, k in ipairs(keys) do
    vim.keymap.set("n", k[1], k[2], f(k[3]))
  end
  return nil
end
on_attach = _1_
local root_dirs = {}
local sort = {sorter = "name", folders_first = true, files_first = false}
local view = {cursorline = true, debounce_delay = 50, side = "left", signcolumn = "yes", width = {min = 30, max = -1, padding = 1}, float = {quit_on_focus_loss = true, enable = false}, number = false, centralize_selection = false, preserve_window_proportions = false, relativenumber = false}
local renderer
do
  local indent_markers = {enable = true, icons = {corner = " ", edge = " ", item = " ", bottom = " ", none = " "}}
  local web_devicons = {file = {enable = true, color = false}, folder = {enable = true, color = false}}
  local show = {file = true, folder = true, folder_arrow = true, git = true, modified = true, diagnostics = true, bookmarks = true}
  local glyphs = {default = "\239\146\165", symlink = "\239\146\129", modified = "\226\151\143", folder = {arrow_closed = "\239\145\160", arrow_open = "\239\145\188", default = "\238\151\191", open = "\238\151\190", empty = "\239\132\148", empty_open = "\239\132\149", symlink = "\239\146\130", symlink_open = "\239\146\130"}, git = {unstaged = "\226\156\151", staged = "\226\156\147", unmerged = "\238\156\167", renamed = "\226\158\156", untracked = "\226\152\133", deleted = "\239\145\152", ignored = "\226\151\140"}}
  local icons = {git_placement = "before", diagnostics_placement = "signcolumn", modified_placement = "after", bookmarks_placement = "signcolumn", padding = " ", symlink_arrow = " \226\158\155 ", web_devicons = web_devicons, show = show, glyphs = glyphs}
  renderer = {group_empty = true, indent_width = 1, special_files = {"README.md", "LICENSE"}, symlink_destination = true, highlight_git = "name", highlight_diagnostics = "name", highlight_opened_files = "none", highlight_modified = "none", highlight_bookmarks = "none", highlight_clipboard = "none", indent_markers = indent_markers, icons = icons, full_name = false, add_trailing = false, root_folder_label = false}
end
local hijack_directories = {enable = true, auto_open = true}
local update_focused_file = {enable = true, update_root = false}
local git = {enable = true, show_on_dirs = true, show_on_open_dirs = true, disable_for_dirs = {}, timeout = 500, cygwin_support = false}
local diagnostics = {enable = true, debounce_delay = 100, show_on_open_dirs = true, severity = {min = vim.diagnostic.severity.INFO, max = vim.diagnostic.severity.ERROR}, icons = {hint = "", info = "", warning = "", error = ""}, show_on_dirs = false}
local modified = {enable = true, show_on_dirs = true, show_on_open_dirs = true}
local filters = {custom = {".DS_Store"}, exclude = {}, no_buffer = false, dotfiles = false, git_clean = false, git_ignored = false}
local live_filter = {prefix = "[FILTER]: ", always_show_folders = true}
local actions
do
  local change_dir = {enable = true, restrict_above_cwd = false, global = false}
  local expand_all = {max_folder_discovery = 300, exclude = {}}
  local file_popup = {open_win_config = {col = 1, row = 1, relative = "cursor", border = "single", style = "minimal"}}
  local open_file = {eject = true, resize_window = true, window_picker = {enable = true, picker = "default", chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890", exclude = {filetype = {"notify", "qf"}, buftype = {"nofile", "terminal", "help"}}}, quit_on_open = false}
  local remove_file = {close_window = true}
  actions = {change_dir = change_dir, expand_all = expand_all, file_popup = file_popup, open_file = open_file, remove_file = remove_file}
end
local tab = {sync = {ignore = {}, open = false, close = false}}
local notify = {threshold = vim.log.levels.INFO, absolute_path = true}
local help = {sort_by = "key"}
local ui = {confirm = {remove = true, trash = true, default_yes = false}}
local log = {enable = false}
local default_cursor = vim.opt.guicursor
tree.setup({hijack_cursor = true, auto_reload_on_write = true, disable_netrw = true, hijack_netrw = true, sync_root_with_cwd = true, select_prompts = true, on_attach = on_attach, root_dirs = root_dirs, sort = sort, view = view, renderer = renderer, hijack_directories = hijack_directories, update_focused_file = update_focused_file, git = git, diagnostics = diagnostics, modified = modified, filters = filters, live_filter = live_filter, actions = actions, tab = tab, notify = notify, help = help, ui = ui, log = log, hijack_unnamed_buffer_when_opening = false, prefer_startup_root = false, reload_on_bufenter = false, respect_buf_cwd = false})
local function _3_()
  local def = vim.api.nvim_get_hl_by_name("Cursor", true)
  vim.api.nvim_set_hl(0, "Cursor", vim.tbl_extend("force", def, {blend = 100}))
  return (vim.opt.guicursor):append("a:Cursor/lCursor")
end
vim.api.nvim_create_autocmd({"WinEnter", "BufWinEnter"}, {pattern = "NvimTree*", callback = _3_})
local function _4_()
  local def = vim.api.nvim_get_hl_by_name("Cursor", true)
  vim.api.nvim_set_hl(0, "Cursor", vim.tbl_extend("force", def, {blend = 0}))
  vim.opt.guicursor = default_cursor
  return nil
end
return vim.api.nvim_create_autocmd({"BufLeave", "WinClosed"}, {pattern = "NvimTree*", callback = _4_})
