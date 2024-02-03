-- [nfnl] Compiled from neovim/fnl/heirline.fnl by https://github.com/Olical/nfnl, do not edit.
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
local mode_colors = {n = "red", no = "red", nov = "red", noV = "red", ["no\22"] = "red", niI = "red", niR = "red", niV = "red", nt = "red", v = "blue", vs = "blue", V = "blue", Vs = "blue", ["\22"] = "blue", ["\22s"] = "blue", s = "purple", S = "purple", ["\19"] = "purple", i = "green", ic = "green", ix = "green", R = "orange", Rc = "orange", Rx = "orange", Rv = "orange", Rvc = "orange", Rvx = "orange", c = "red", ct = "red", cv = "red", ce = "red", r = "red", rm = "red", ["r?"] = "red", ["!"] = "red", t = "red"}
local skk_mode_labels = {[""] = "\232\139\177\230\149\176", hira = "\227\129\178\227\130\137", kata = "\227\130\171\227\131\138", hankata = "\229\141\138\227\130\171", zenkaku = "\229\133\168\232\139\177", abbrev = "abbr"}
local align = {provider = "%="}
local left_cap = {provider = "\226\150\140"}
local space = {provider = " "}
local bar = {provider = seps.bar}
local round_right = {provider = seps.bar}
local mode
do
  local readonly_symbol
  local function _1_()
    return (not vim.bo.modifiable or vim.bo.readonly)
  end
  readonly_symbol = {condition = _1_, provider = icons.lock, hl = {fg = colors.bg}}
  local vim_symbol = {provider = icons.vim, hl = {fg = colors.bg}}
  local symbol = {readonly_symbol, vim_symbol, fallthrough = false}
  local function _2_(self)
    return mode_colors[(self.mode):sub(1, 1)]
  end
  local function _3_(self)
    self.mode = vim.fn.mode(1)
    return nil
  end
  mode = {utils.surround({icons.fill, icons.fill}, _2_, {symbol}), init = _3_, update = {"ModeChanged"}}
end
local git
do
  local active
  local function _4_(self)
    return ("\239\144\152 " .. self.git_status.head)
  end
  local function _5_(self)
    return (" \239\145\151 " .. (self.git_status.added or 0))
  end
  local function _6_(self)
    return (" \239\145\153 " .. (self.git_status.changed or 0))
  end
  local function _7_(self)
    return (" \239\145\152 " .. (self.git_status.removed or 0))
  end
  local function _8_(self)
    self.git_status = vim.b.gitsigns_status_dict
    return nil
  end
  active = {{provider = _4_}, {{provider = _5_, hl = {fg = colors.git_add}}, {provider = _6_, hl = {fg = colors.git_change}}, {provider = _7_, hl = {fg = colors.git_del}}}, condition = conditions.is_git_repo, init = _8_}
  local inactive = {{provider = "\239\144\152 ------"}, {{provider = " \239\145\151 - \239\145\153 - \239\145\152 -"}}}
  git = {active, inactive, fallthrough = false}
end
local diagnostics
do
  local active
  local function _9_(self)
    self.errors = #vim.diagnostic.get(0, {severity = vim.diagnostic.severity.ERROR})
    self.warns = #vim.diagnostic.get(0, {severity = vim.diagnostic.severity.WARN})
    return nil
  end
  local function _10_()
    return (require("trouble")).toggle({mode = "document_diagnostics"})
  end
  local function _11_(self)
    return (icons.error .. " " .. self.errors .. " " .. icons.warn .. " " .. self.warns)
  end
  active = {condition = conditions.has_diagnostics, init = _9_, on_click = {callback = _10_, name = "heirline_diagnostics"}, provider = _11_}
  local inactive = {provider = (icons.error .. " - " .. icons.warn .. " -")}
  diagnostics = {active, inactive, fallthrough = false}
end
local pomodoro
local function _12_()
  return (require("piccolo-pomodoro")).status()
end
local function _13_()
  return (require("piccolo-pomodoro")).toggle()
end
pomodoro = {provider = _12_, on_click = {callback = _13_, name = "toggle_pomodoro"}}
local search_count
local function _14_()
  return ((vim.v.hlsearch ~= 0) and (vim.o.cmdheight == 0))
end
local function _15_(self)
  local ok, search = pcall(vim.fn.searchcount)
  if (ok and search.total) then
    self.search = search
    return nil
  else
    return nil
  end
end
local function _17_(self)
  return string.format("[%d/%d]", self.search.current, math.min(self.search.total, self.search.maxcount))
end
search_count = {condition = _14_, init = _15_, provider = _17_}
local ruler = {provider = "%7(%l,%c%)"}
local file_properties
do
  local encoding
  local function _18_(self)
    self.encoding = (((vim.bo.fileencoding ~= "") and vim.bo.fileencoding) or vim.o.encoding or nil)
    return self.encoding
  end
  local function _19_(self)
    return (self.encoding_label[self.encoding] or self.encoding)
  end
  encoding = {condition = _18_, provider = _19_, static = {encoding_label = {["utf-"] = "UTF-"}}}
  local format
  local function _20_(self)
    self.format = vim.bo.fileformat
    return self.format
  end
  local function _21_(self)
    return (self.format_label[self.format] or self.format)
  end
  format = {condition = _20_, provider = _21_, static = {format_label = {dos = "CRLF", mac = "CR", unix = "LF"}}}
  file_properties = {encoding, space, format, update = {"WinNew", "WinClosed", "BufEnter"}}
end
local root
do
  local function _22_(self)
    local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    self.root = (self.alias[cwd] or cwd)
    return nil
  end
  local function _23_(self)
    return (" \239\132\161  %4(" .. self.root .. "%) ")
  end
  root = {init = _22_, provider = _23_, update = {"DirChanged"}, hl = {fg = colors.bg, bg = colors.orange}, static = {alias = {[""] = "ROOT"}}}
end
local help_name
local function _24_()
  return (vim.bo.filetype == "help")
end
local function _25_()
  return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
end
help_name = {condition = _24_, provider = _25_, hl = {fg = colors.fg}}
local terminal_name
local function _26_()
  local name, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
  return name
end
terminal_name = {provider = _26_, hl = {fg = colors.fg}}
local tabline
do
  local align0 = {provider = "%="}
  local offset
  local function _27_(self)
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
  local function _29_(self)
    local title = self.title
    local width = vim.api.nvim_win_get_width(self.win)
    local pad_size = math.ceil(((width - #title) / 2))
    local pad = string.rep(" ", pad_size)
    return (pad .. title .. pad)
  end
  local function _30_(self)
    if (vim.api.nvim_get_current_win() == self.win) then
      return "TablineSel"
    else
      return "Tabline"
    end
  end
  offset = {condition = _27_, provider = _29_, hl = _30_}
  local buffer_line
  do
    local get_bg
    local function _32_(hl)
      return utils.get_highlight(hl).bg
    end
    get_bg = _32_
    local file_name
    local function _33_(self)
      local name = self.filename
      if ((name == "") or (name == nil)) then
        return "[No Name]"
      else
        return vim.fn.fnamemodify(name, ":t")
      end
    end
    local function _35_(self)
      return {bold = (self.is_active or self.is_visible)}
    end
    file_name = {provider = _33_, hl = _35_}
    local file_flags
    local function _36_(self)
      return vim.api.nvim_buf_get_option(self.bufnr, "modified")
    end
    file_flags = {condition = _36_, provider = " [+]", hl = {fg = colors.green}}
    local file_block
    local function _37_(self)
      self.filename = vim.api.nvim_buf_get_name(self.bufnr)
      return nil
    end
    local function _38_(self)
      if self.is_active then
        return "TabLineSel"
      else
        return "TabLine"
      end
    end
    file_block = {file_name, file_flags, init = _37_, hl = _38_}
    local buffer_block
    local function _40_(self)
      if self.is_active then
        return get_bg("TabLineSel")
      else
        return get_bg("TabLine")
      end
    end
    buffer_block = utils.surround({icons.fill, icons.fill}, _40_, {file_block})
    buffer_line = utils.make_buflist(buffer_block, {provider = "<", hl = {fg = colors.grey}}, {provider = ">", hl = {fg = colors.grey}})
  end
  local tabpage
  local function _42_(self)
    return (" %" .. self.tabnr .. "T" .. self.tabpage .. " %T")
  end
  local function _43_(self)
    if not self.is_active then
      return "TabLine"
    else
      return "TabLineSel"
    end
  end
  tabpage = {provider = _42_, hl = _43_}
  local tabpages
  local function _45_()
    return (#vim.api.nvim_list_tabpages() >= 2)
  end
  tabpages = {align0, utils.make_tablist(tabpage), condition = _45_}
  tabline = {offset, buffer_line, tabpages}
end
local hydra_status
do
  local name
  local function _46_()
    return (hydra.get_name() or "HYDRA")
  end
  name = {provider = _46_}
  local hint = {condition = hydra.get_hint, provider = hydra.get_hint}
  local function _47_()
    return colors.cyan
  end
  local function _48_(self)
    return (hydra.is_active() and not self.hydra_ignore[hydra.get_name()])
  end
  hydra_status = {utils.surround({icons.left_rounded, icons.right_rounded}, _47_, {name}), align, hint, align, condition = _48_, static = {hydra_ignore = {BarBar = true}}}
end
local special_status
local function _49_()
  return (" " .. icons.document .. " " .. string.upper(vim.bo.filetype) .. " ")
end
local function _50_()
  return conditions.buffer_matches({buftype = {"nofile", "prompt", "help", "quickfix"}, filetype = {"^git.*", "fugative"}})
end
special_status = {mode, align, help_name, align, {provider = _49_, hl = {fg = colors.bg, bg = colors.blue}, update = {"WinNew", "WinClosed", "BufEnter"}}, condition = _50_}
local terminal_status
local function _51_()
  return (" " .. icons.terminal .. " TERMINAL ")
end
local function _52_()
  return conditions.buffer_matches({buftype = {"terminal"}})
end
terminal_status = {mode, align, terminal_name, align, {provider = _51_, hl = {fg = colors.bg, bg = colors.red}, update = {"WinNew", "WinClosed", "BufEnter"}}, condition = _52_}
local default_status_line = {mode, space, git, round_right, diagnostics, round_right, pomodoro, align, search_count, align, ruler, bar, file_properties, space, root}
local statusline = {hydra_status, special_status, terminal_status, default_status_line, hl = {fg = colors.fg, bg = colors.bg, bold = true}, fallthrough = false}
return heirline.setup({statusline = statusline, tabline = tabline, opts = opts})
