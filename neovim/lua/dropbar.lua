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
  local kinds = {use_devicons = true, symbols = {Array = "\243\176\133\170 ", Boolean = "\238\170\143 ", BreakStatement = "\243\176\153\167 ", Call = "\243\176\131\183 ", CaseStatement = "\243\177\131\153 ", Class = "\238\173\155 ", Color = "\243\176\143\152 ", Constant = "\243\176\143\191 ", Constructor = "\239\128\147 ", ContinueStatement = "\226\134\146 ", Copilot = "\239\132\147 ", Declaration = "\243\176\153\160 ", Delete = "\243\176\169\186 ", DoStatement = "\243\176\145\150 ", Enum = "\238\170\149 ", EnumMember = "\238\173\158 ", Event = "\239\131\167 ", Field = "\238\173\159 ", File = "\243\176\136\148 ", Folder = "\243\176\137\139 ", ForStatement = "\243\176\145\150 ", Function = "\243\176\138\149 ", H1Marker = "\243\176\137\171 ", H2Marker = "\243\176\137\172 ", H3Marker = "\243\176\137\173 ", H4Marker = "\243\176\137\174 ", H5Marker = "\243\176\137\175 ", H6Marker = "\243\176\137\176 ", Identifier = "\243\176\128\171 ", IfStatement = "\243\176\135\137 ", Interface = "\238\173\161 ", Keyword = "\243\176\140\139 ", List = "\243\176\133\170 ", Log = "\243\176\166\170 ", Lsp = "\238\171\144 ", Macro = "\243\176\129\140 ", MarkdownH1 = "\243\176\137\171 ", MarkdownH2 = "\243\176\137\172 ", MarkdownH3 = "\243\176\137\173 ", MarkdownH4 = "\243\176\137\174 ", MarkdownH5 = "\243\176\137\175 ", MarkdownH6 = "\243\176\137\176 ", Method = "\243\176\134\167 ", Module = "\243\176\143\151 ", Namespace = "\243\176\133\169 ", Null = "\243\176\162\164 ", Number = "\243\176\142\160 ", Object = "\243\176\133\169 ", Operator = "\243\176\134\149 ", Package = "\243\176\134\166 ", Pair = "\243\176\133\170 ", Property = "\239\128\171 ", Reference = "\243\176\166\190 ", Regex = "\238\172\184 ", Repeat = "\243\176\145\150 ", Scope = "\243\176\133\169 ", Snippet = "\243\176\169\171 ", Specifier = "\243\176\166\170 ", Statement = "\243\176\133\169 ", String = "\243\176\137\190 ", Struct = "\238\173\155 ", SwitchStatement = "\243\176\186\159 ", Terminal = "\238\158\149 ", Text = "\238\173\169 ", Type = "\238\173\163 ", TypeParameter = "\243\176\134\169 ", Unit = "\238\136\159 ", Value = "\243\176\142\160 ", Variable = "\243\176\128\171 ", WhileStatement = "\243\176\145\150 "}}
  local ui = {bar = {separator = "\239\145\160 ", extends = "\226\128\166"}, menu = {separator = " ", indicator = "\239\145\160 "}}
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
      return {sources.path, utils.source.fallback({sources.lsp, sources.treesitter})}
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
  local win_configs = {border = "single", style = "minimal"}
  menu = {preview = true, quick_navigation = true, entry = {padding = {left = 1, right = 1}}, scrollbar = {enable = true, background = true}, keymaps = keymaps, win_configs = win_configs}
end
local fzf
do
  local keymaps = {["<C-p>"] = api.fuzzy_find_prev, ["<C-n>"] = api.fuzzy_find_next, ["<CR>"] = api.fuzzy_find_click}
  fzf = {keymaps = keymaps}
end
return dropbar.setup({general = general, icons = icons, bar = bar, menu = menu, fzf = fzf})
