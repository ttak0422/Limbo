-- [nfnl] Compiled from neovim/fnl/dropbar.fnl by https://github.com/Olical/nfnl, do not edit.
local dropbar = require("dropbar")
local utils = require("dropbar.utils")
local api = require("dropbar.api")
local sources = require("dropbar.sources")
local general
do
  local attach_events = {"OptionSet", "BufWinEnter", "BufWritePost"}
  local update_events = {win = {"CursorMoved", "InsertLeave", "WinEnter", "WinResized"}, buf = {"BufModifiedSet", "FileChangedShellPost", "TextChanged", "TextChangedI"}, global = {"DirChanged", "VimResized"}}
  general = {attach_events = attach_events, update_events = update_events, update_interval = 100}
end
local icons
do
  local kinds = {use_devicons = true, symbols = {Array = "", Boolean = "", BreakStatement = "", Call = "", CaseStatement = "", Class = "", Color = "", Constant = "", Constructor = "", ContinueStatement = "", Copilot = "", Declaration = "", Delete = "", DoStatement = "", Enum = "", EnumMember = "", Event = "", Field = "", File = "", Folder = "", ForStatement = "", Function = "", H1Marker = "", H2Marker = "", H3Marker = "", H4Marker = "", H5Marker = "", H6Marker = "", Identifier = "", IfStatement = "", Interface = "", Keyword = "", List = "", Log = "", Lsp = "", Macro = "", MarkdownH1 = "", MarkdownH2 = "", MarkdownH3 = "", MarkdownH4 = "", MarkdownH5 = "", MarkdownH6 = "", Method = "", Module = "", Namespace = "", Null = "", Number = "", Object = "", Operator = "", Package = "", Pair = "", Property = "", Reference = "", Regex = "", Repeat = "", Scope = "", Snippet = "", Specifier = "", Statement = "", String = "", Struct = "", SwitchStatement = "", Terminal = "", Text = "", Type = "", TypeParameter = "", Unit = "", Value = "", Variable = "", WhileStatement = ""}}
  local ui = {bar = {separator = " \239\145\160 ", extends = "\226\128\166"}, menu = {separator = " ", indicator = " \239\145\160 "}}
  icons = {enable = true, kinds = kinds, ui = ui}
end
local bar
local function _1_(buf, _)
  local ft = vim.bo[buf].filetype
  local buftype = vim.bo[buf].buftype
  if (ft == "markdown") then
    return {sources.path, sources.markdown}
  else
    if (buftype == "terminal") then
      return {sources.terminal}
    else
      return {sources.path, sources.treesitter}
    end
  end
end
bar = {hover = true, sources = _1_, padding = {left = 1, right = 1}, pick = {pivots = "abcdefghijklmnopqrstuvwxyz"}, truncate = true}
local menu
do
  local select
  local function _4_()
    local menu0 = utils.menu.get_current()
    if menu0 then
      local cursor = vim.api.nvim_win_get_cursor(menu0.win)
      local c1 = cursor[1]
      local c2 = cursor[2]
      local component = ((menu0.entries)[c1]):first_clickable(c2)
      if component then
        return menu0:click_on(component, nil, 1, "l")
      else
        return nil
      end
    else
      return nil
    end
  end
  select = _4_
  local keymaps
  local function _7_()
    local menu0 = utils.menu.get_current()
    if menu0 then
      return menu0:fuzzy_find_open()
    else
      return nil
    end
  end
  keymaps = {["<CR>"] = select, o = select, zf = _7_}
  local win_configs = {border = "none", style = "minimal"}
  menu = {preview = true, quick_navigation = true, entry = {padding = {left = 1, right = 1}}, scrollbar = {enable = true, background = true}, keymaps = keymaps, win_configs = win_configs}
end
local fzf
do
  local keymaps = {["<C-p>"] = api.fuzzy_find_prev, ["<C-n>"] = api.fuzzy_find_next, ["<CR>"] = api.fuzzy_find_click}
  fzf = {keymaps = keymaps}
end
return dropbar.setup({general = general, icons = icons, bar = bar, menu = menu, fzf = fzf})
