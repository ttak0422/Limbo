-- [nfnl] Compiled from neovim/fnl/heirline.fnl by https://github.com/Olical/nfnl, do not edit.
local is_direnv = false
local is_direnv_active = false
local check_direnv
local function _1_()
  local function _2_(handle)
    is_direnv = (handle == 0)
    return nil
  end
  return vim.loop.spawn("sh", {args = {"-c", "direnv status | grep --silent 'Found RC allowed'"}}, _2_)
end
check_direnv = _1_
local check_direnv_active
local function _3_()
  local function _4_(handle)
    is_direnv_active = (handle == 0)
    return nil
  end
  return vim.loop.spawn("sh", {args = {"-c", "direnv status | grep --silent 'Found RC allowed true'"}}, _4_)
end
check_direnv_active = _3_
local function _5_()
  check_direnv()
  return check_direnv_active()
end
vim.api.nvim_create_autocmd({"DirChanged"}, {pattern = "*", callback = _5_})
check_direnv()
check_direnv_active()
local function _6_()
  return vim.cmd("redrawstatus")
end
vim.defer_fn(_6_, 1000)
local ignore_lsp = {copilot = true}
local check_lsp_attach
local function _7_()
  local clients = vim.lsp.get_active_clients({bufnr = 0})
  local acc = false
  for _, client in pairs(clients) do
    acc = (acc or not ignore_lsp[client.name])
  end
  return acc
end
check_lsp_attach = _7_
local heirline = require("heirline")
local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local kanagawa = require("kanagawa.colors")
local hydra = require("hydra.statusline")
local kanagawa_palette = kanagawa.setup().palette
local kanagawa_colors = {bg = kanagawa_palette.sumiInk2, fg = kanagawa_palette.sumiInk6, red = kanagawa_palette.autumnRed, green = kanagawa_palette.autumnGreen, blue = kanagawa_palette.crystalBlue, grey = kanagawa_palette.fujiGray, orange = kanagawa_palette.surimiOrange, purple = kanagawa_palette.oniViolet, cyan = kanagawa_palette.lotusCyan, diag_warn = kanagawa_palette.roninYellow, diag_error = kanagawa_palette.samuraiRed, diag_hint = kanagawa_palette.dragonBlue, diag_info = kanagawa_palette.waveAqua1, git_del = kanagawa_palette.autumnRed, git_add = kanagawa_palette.autumnGreen, git_change = kanagawa_palette.autumnYellow}
local colors = kanagawa_colors
local opts = {colors = colors}
local icons = {terminal = "\239\146\137", keyboard = "\239\132\156 ", vim = "\238\152\171", circle = "\239\132\145", circle_o = "\226\173\152", circle_d = "\239\134\146", lock = "\239\128\163", left_rounded = "\238\130\182", left_rounded_thin = "\238\130\183", right_rounded = "\238\130\180", right_rounded_thin = "\238\130\181", bar = "|", warn = "\239\129\177", error = "\239\129\151", document = "\239\133\155", fill = "\226\150\136"}
local seps = {bar = (" " .. icons.bar .. " "), left_rounded_thin = (" " .. icons.left_rounded_thin .. " "), right_rounded_thin = (" " .. icons.right_rounded_thin .. " ")}
local mode_labels = {n = "N", no = "N", nov = "N", noV = "N", ["no\22"] = "N", niI = "N", niR = "N", niV = "N", nt = "N", v = "V", vs = "V", V = "V", Vs = "V", ["\22"] = "V", ["\22s"] = "V", s = "S", S = "S", ["\19"] = "S", i = "I", ic = "I", ix = "I", R = "R", Rc = "R", Rx = "R", Rv = "R", Rvc = "R", Rvx = "R", c = "C", ct = "C", cv = "Ex", ce = "C", r = "...", rm = "M", ["r?"] = "?", ["!"] = "!", t = "T"}
local mode_colors = {n = "red", no = "red", nov = "red", noV = "red", ["no\22"] = "red", niI = "red", niR = "red", niV = "red", nt = "red", v = "blue", vs = "blue", V = "blue", Vs = "blue", ["\22"] = "blue", ["\22s"] = "blue", s = "purple", S = "purple", ["\19"] = "purple", i = "green", ic = "green", ix = "green", R = "orange", Rc = "orange", Rx = "orange", Rv = "orange", Rvc = "orange", Rvx = "orange", c = "red", ct = "red", cv = "red", ce = "red", r = "red", rm = "red", ["r?"] = "red", ["!"] = "red", t = "red"}
local skk_mode_labels = {[""] = "\232\139\177\230\149\176", hira = "\227\129\178\227\130\137", kata = "\227\130\171\227\131\138", hankata = "\229\141\138\227\130\171", zenkaku = "\229\133\168\232\139\177", abbrev = "abbr"}
local align = {provider = "%="}
local left_cap = {provider = "\226\150\140"}
local space = {provider = " "}
local bar = {provider = seps.bar}
local round_right = {provider = seps.right_rounded_thin}
local mode
do
  local readonly_symbol
  local function _8_()
    return (not vim.bo.modifiable or vim.bo.readonly)
  end
  readonly_symbol = {condition = _8_, provider = (icons.lock .. " "), hl = {fg = colors.bg}}
  local vim_symbol = {provider = (icons.vim .. " "), hl = {fg = colors.bg}}
  local symbol = {readonly_symbol, vim_symbol, fallthrough = false}
  local mode_vim
  local function _9_(self)
    return ((mode_labels[(self.mode):sub(1, 1)] or (self.mode):sub(1, 1)) .. " | ")
  end
  local function _10_(self)
    return {fg = colors.bg, bg = mode_colors[self.mode]}
  end
  mode_vim = {provider = _9_, hl = _10_}
  local mode_skk
  local function _11_(self)
    self.skk_mode = (vim.fn["skkeleton#mode"]() or "")
    return nil
  end
  local function _12_(self)
    return (skk_mode_labels[self.skk_mode] or self.skk_mode)
  end
  mode_skk = {init = _11_, provider = _12_, hl = {fg = colors.bg}}
  local function _13_(self)
    return mode_colors[(self.mode):sub(1, 1)]
  end
  local function _14_(self)
    self.mode = vim.fn.mode(1)
    return nil
  end
  mode = {utils.surround({icons.fill, icons.fill}, _13_, {symbol, mode_vim, mode_skk}), init = _14_, update = {"ModeChanged"}}
end
local git
do
  local active
  local function _15_(self)
    return ("\239\144\152 " .. self.git_status.head)
  end
  local function _16_(self)
    return (" \239\145\151 " .. (self.git_status.added or 0))
  end
  local function _17_(self)
    return (" \239\145\153 " .. (self.git_status.changed or 0))
  end
  local function _18_(self)
    return (" \239\145\152 " .. (self.git_status.removed or 0))
  end
  local function _19_(self)
    self.git_status = vim.b.gitsigns_status_dict
    return nil
  end
  active = {{provider = _15_}, {{provider = _16_, hl = {fg = colors.git_add}}, {provider = _17_, hl = {fg = colors.git_change}}, {provider = _18_, hl = {fg = colors.git_del}}}, condition = conditions.is_git_repo, init = _19_}
  local inactive = {{provider = "\239\144\152 ------"}, {{provider = " \239\145\151 - \239\145\153 - \239\145\152 -"}}}
  git = {active, inactive, fallthrough = false}
end
local diagnostics
do
  local active
  local function _20_(self)
    self.errors = #vim.diagnostic.get(0, {severity = vim.diagnostic.severity.ERROR})
    self.warns = #vim.diagnostic.get(0, {severity = vim.diagnostic.severity.WARN})
    return nil
  end
  local function _21_()
    return (require("trouble")).toggle({mode = "document_diagnostics"})
  end
  local function _22_(self)
    return (icons.error .. " " .. self.errors .. " " .. icons.warn .. " " .. self.warns)
  end
  active = {condition = conditions.has_diagnostics, init = _20_, on_click = {callback = _21_, name = "heirline_diagnostics"}, provider = _22_}
  local inactive = {provider = (icons.error .. " - " .. icons.warn .. " -")}
  diagnostics = {active, inactive, fallthrough = false}
end
local pomodoro
local function _23_()
  return (require("piccolo-pomodoro")).status()
end
local function _24_()
  return (require("piccolo-pomodoro")).toggle()
end
pomodoro = {provider = _23_, on_click = {callback = _24_, name = "toggle_pomodoro"}}
local search_count
local function _25_()
  return ((vim.v.hlsearch ~= 0) and (vim.o.cmdheight == 0))
end
local function _26_(self)
  local ok, search = pcall(vim.fn.searchcount)
  if (ok and search.total) then
    self.search = search
    return nil
  else
    return nil
  end
end
local function _28_(self)
  return string.format("[%d/%d]", self.search.current, math.min(self.search.total, self.search.maxcount))
end
search_count = {condition = _25_, init = _26_, provider = _28_}
local ruler = {provider = "%7(%l,%c%)"}
local file_properties
do
  local encoding
  local function _29_(self)
    self.encoding = (((vim.bo.fileencoding ~= "") and vim.bo.fileencoding) or vim.o.encoding or nil)
    return self.encoding
  end
  local function _30_(self)
    return (self.encoding_label[self.encoding] or self.encoding)
  end
  encoding = {condition = _29_, provider = _30_, static = {encoding_label = {["utf-"] = "UTF-"}}}
  local format
  local function _31_(self)
    self.format = vim.bo.fileformat
    return self.format
  end
  local function _32_(self)
    return (self.format_label[self.format] or self.format)
  end
  format = {condition = _31_, provider = _32_, static = {format_label = {dos = "CRLF", mac = "CR", unix = "LF"}}}
  file_properties = {encoding, space, format, update = {"WinNew", "WinClosed", "BufEnter"}}
end
local indicator
do
  local direnv
  local function _33_()
    if is_direnv_active then
      return "\239\136\133  direnv "
    else
      return "\239\136\132  direnv "
    end
  end
  direnv = {provider = _33_}
  local lsp
  local function _35_(self)
    if self.lsp_active then
      return "\239\136\133  LSP "
    else
      return "\239\136\132  LSP "
    end
  end
  lsp = {provider = _35_, update = {"LspAttach", "LspDetach"}}
  local function _37_(self)
    self.lsp_active = check_lsp_attach()
    return (self.lsp_active or is_direnv)
  end
  local function _38_()
    local function _39_()
      return vim.cmd("LspInfo")
    end
    return vim.defer_fn(_39_, 100)
  end
  indicator = {lsp, direnv, condition = _37_, on_click = {callback = _38_, name = "heirline_lsp"}}
end
local root
do
  local function _40_(self)
    local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    self.root = (self.alias[cwd] or cwd)
    return nil
  end
  local function _41_(self)
    return (" \239\132\161  %4(" .. self.root .. "%) ")
  end
  root = {init = _40_, provider = _41_, update = {"DirChanged"}, hl = {fg = colors.bg, bg = colors.orange}, static = {alias = {[""] = "ROOT"}}}
end
local help_name
local function _42_()
  return (vim.bo.filetype == "help")
end
local function _43_()
  return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
end
help_name = {condition = _42_, provider = _43_, hl = {fg = colors.fg}}
local terminal_name
local function _44_()
  local name, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
  return name
end
terminal_name = {provider = _44_, hl = {fg = colors.fg}}
local tabline
do
  local align0 = {provider = "%="}
  local offset
  local function _45_(self)
    local win = (vim.api.nvim_tabpage_list_wins(0))[1]
    local bufnr = vim.api.nvim_win_get_buf(win)
    local ft = vim.bo[bufnr].filetype
    self.win = win
    if (ft == "NvimTree") then
      self.title = "NvimTree"
      return true
    else
      return false
    end
  end
  local function _47_(self)
    local title = self.title
    local width = vim.api.nvim_win_get_width(self.win)
    local pad_size = math.ceil(((width - #title) / 2))
    local pad = string.rep(" ", pad_size)
    return (pad .. title .. pad)
  end
  local function _48_(self)
    if (vim.api.nvim_get_current_win() == self.win) then
      return "TablineSel"
    else
      return "Tabline"
    end
  end
  offset = {condition = _45_, provider = _47_, hl = _48_}
  local buffer_line
  do
    local get_bg
    local function _50_(hl)
      return utils.get_highlight(hl).bg
    end
    get_bg = _50_
    local file_name
    local function _51_(self)
      local name = self.filename
      if ((name == "") or (name == nil)) then
        return "[No Name]"
      else
        return vim.fn.fnamemodify(name, ":t")
      end
    end
    local function _53_(self)
      return {bold = (self.is_active or self.is_visible)}
    end
    file_name = {provider = _51_, hl = _53_}
    local file_flags
    local function _54_(self)
      return vim.api.nvim_buf_get_option(self.bufnr, "modified")
    end
    file_flags = {condition = _54_, provider = " [+]", hl = {fg = colors.green}}
    local file_block
    local function _55_(self)
      self.filename = vim.api.nvim_buf_get_name(self.bufnr)
      return nil
    end
    local function _56_(self)
      if self.is_active then
        return "TabLineSel"
      else
        return "TabLine"
      end
    end
    file_block = {file_name, file_flags, init = _55_, hl = _56_}
    local buffer_block
    local function _58_(self)
      if self.is_active then
        return get_bg("TabLineSel")
      else
        return get_bg("TabLine")
      end
    end
    buffer_block = utils.surround({icons.fill, icons.fill}, _58_, {file_block})
    buffer_line = utils.make_buflist(buffer_block, {provider = "<", hl = {fg = colors.grey}}, {provider = ">", hl = {fg = colors.grey}})
  end
  local tabpage
  local function _60_(self)
    return ("%" .. self.tabnr .. "T" .. self.tabpage .. " %T")
  end
  local function _61_(self)
    if not self.is_active then
      return "TabLine"
    else
      return "TabLineSel"
    end
  end
  tabpage = {provider = _60_, hl = _61_}
  local tabpages
  local function _63_()
    return (#vim.api.nvim_list_tabpages() >= 2)
  end
  tabpages = {align0, utils.make_tablist(tabpage), condition = _63_}
  tabline = {offset, buffer_line, tabpages}
end
local hydra_status
do
  local name
  local function _64_()
    return (hydra.get_name() or "HYDRA")
  end
  name = {provider = _64_}
  local hint = {condition = hydra.get_hint, provider = hydra.get_hint}
  local function _65_()
    return colors.cyan
  end
  local function _66_(self)
    return (hydra.is_active() and not self.hydra_ignore[hydra.get_name()])
  end
  hydra_status = {left_cap, utils.surround({icons.left_rounded, icons.right_rounded}, _65_, {name}), align, hint, align, condition = _66_, static = {hydra_ignore = {BarBar = true}}}
end
local special_status
local function _67_()
  return (" " .. icons.document .. " " .. string.upper(vim.bo.filetype) .. " ")
end
local function _68_()
  return conditions.buffer_matches({buftype = {"nofile", "prompt", "help", "quickfix"}, filetype = {"^git.*", "fugative"}})
end
special_status = {left_cap, mode, align, help_name, align, {provider = _67_, hl = {fg = colors.bg, bg = colors.blue}, update = {"WinNew", "WinClosed", "BufEnter"}}, condition = _68_}
local terminal_status
local function _69_()
  return (" " .. icons.terminal .. " TERMINAL ")
end
local function _70_()
  return conditions.buffer_matches({buftype = {"terminal"}})
end
terminal_status = {left_cap, mode, align, terminal_name, align, {provider = _69_, hl = {fg = colors.bg, bg = colors.red}, update = {"WinNew", "WinClosed", "BufEnter"}}, condition = _70_}
local default_status_line = {left_cap, mode, space, git, round_right, diagnostics, round_right, pomodoro, align, search_count, align, ruler, bar, file_properties, bar, indicator, root}
local statusline = {hydra_status, special_status, terminal_status, default_status_line, hl = {fg = colors.fg, bg = colors.bg, bold = true}, fallthrough = false}
return heirline.setup({statusline = statusline, tabline = tabline, opts = opts})
