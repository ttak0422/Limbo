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
local sep_bar = {provider = seps.bar}
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
local harpoon
do
  local harpoonline = require("harpoonline")
  local function _12_()
    return harpoonline.format()
  end
  harpoon = {provider = _12_}
end
local lsp_progress
local function _13_()
  return vim.cmd("redrawstatus")
end
lsp_progress = {provider = (require("lsp-progress")).progress, update = {"User", pattern = "LspProgressStatusUpdated", callback = vim.schedule_wrap(_13_)}}
local ruler = {provider = "%7(%l,%c%)"}
local file_properties
do
  local encoding
  local function _14_(self)
    self.encoding = (((vim.bo.fileencoding ~= "") and vim.bo.fileencoding) or vim.o.encoding or nil)
    return self.encoding
  end
  local function _15_(self)
    return (self.encoding_label[self.encoding] or self.encoding)
  end
  encoding = {condition = _14_, provider = _15_, static = {encoding_label = {["utf-"] = "UTF-"}}}
  local format
  local function _16_(self)
    self.format = vim.bo.fileformat
    return self.format
  end
  local function _17_(self)
    return (self.format_label[self.format] or self.format)
  end
  format = {condition = _16_, provider = _17_, static = {format_label = {dos = "CRLF", mac = "CR", unix = "LF"}}}
  file_properties = {encoding, space, format, update = {"WinNew", "WinClosed", "BufEnter"}}
end
local root
do
  local function _18_(self)
    local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    self.root = (self.alias[cwd] or cwd)
    return nil
  end
  local function _19_(self)
    return (" \239\132\161  %4(" .. self.root .. "%) ")
  end
  root = {init = _18_, provider = _19_, update = {"DirChanged"}, hl = {fg = colors.bg, bg = colors.orange}, static = {alias = {[""] = "ROOT"}}}
end
local help_name
local function _20_()
  return (vim.bo.filetype == "help")
end
local function _21_()
  return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
end
help_name = {condition = _20_, provider = _21_, hl = {fg = colors.fg}}
local terminal_name
local function _22_()
  local name, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
  return name
end
terminal_name = {provider = _22_, hl = {fg = colors.fg}}
local tabline
do
  local align0 = {provider = "%="}
  local offset
  local function _23_(self)
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
  local function _25_(self)
    local title = self.title
    local width = vim.api.nvim_win_get_width(self.win)
    local pad_size = math.ceil(((width - #title) / 2))
    local pad = string.rep(" ", pad_size)
    return (pad .. title .. pad)
  end
  local function _26_(self)
    if (vim.api.nvim_get_current_win() == self.win) then
      return "TablineSel"
    else
      return "Tabline"
    end
  end
  offset = {condition = _23_, provider = _25_, hl = _26_}
  local buffer_line
  do
    local get_bg
    local function _28_(hl)
      return utils.get_highlight(hl).bg
    end
    get_bg = _28_
    local label
    local function _29_(self)
      local bufname = vim.api.nvim_buf_get_name(self.bufnr)
      local buf_label
      if ((bufname == "") or (bufname == nil)) then
        buf_label = "[No Name]"
      else
        buf_label = vim.fn.fnamemodify(bufname, ":t")
      end
      return buf_label
    end
    local function _31_(self)
      local _32_
      if self.is_active then
        _32_ = colors.bg
      else
        _32_ = colors.fg
      end
      local _34_
      if self.is_active then
        _34_ = colors.orange
      else
        _34_ = colors.bg
      end
      return {bold = (self.is_active or self.is_visible), fg = _32_, bg = _34_}
    end
    label = {provider = _29_, hl = _31_}
    local file_flags
    local function _36_(self)
      return vim.api.nvim_buf_get_option(self.bufnr, "modified")
    end
    local _37_
    do
      _37_ = " [+]"
    end
    local function _38_(self)
      local _39_
      if self.is_active then
        _39_ = colors.bg
      else
        _39_ = colors.green
      end
      local _41_
      if self.is_active then
        _41_ = colors.orange
      else
        _41_ = colors.bg
      end
      return {fg = _39_, bg = _41_}
    end
    file_flags = {condition = _36_, provider = _37_, hl = _38_}
    local file_block
    local function _43_(self)
      self.filename = vim.api.nvim_buf_get_name(self.bufnr)
      return nil
    end
    local function _44_(self)
      if self.is_active then
        return "TabLineSel"
      else
        return "TabLine"
      end
    end
    file_block = {label, file_flags, init = _43_, hl = _44_}
    local buffer_block
    local function _46_(self)
      if self.is_active then
        return colors.orange
      else
        return colors.bg
      end
    end
    buffer_block = utils.surround({icons.fill, icons.fill}, _46_, {file_block})
    buffer_line = utils.make_buflist(buffer_block, {provider = "<", hl = {fg = colors.grey}}, {provider = ">", hl = {fg = colors.grey}})
  end
  local tabpage
  local function _48_(self)
    return (" %" .. self.tabnr .. "T" .. self.tabpage .. " %T")
  end
  local function _49_(self)
    if not self.is_active then
      return "TabLine"
    else
      return "TabLineSel"
    end
  end
  tabpage = {provider = _48_, hl = _49_}
  local tabpages
  local function _51_()
    return (#vim.api.nvim_list_tabpages() >= 2)
  end
  tabpages = {align0, utils.make_tablist(tabpage), condition = _51_}
  tabline = {offset, buffer_line, tabpages}
end
local hydra_status
do
  local name
  local function _52_()
    return (hydra.get_name() or "HYDRA")
  end
  name = {provider = _52_}
  local hint = {condition = hydra.get_hint, provider = hydra.get_hint}
  local function _53_()
    return colors.cyan
  end
  local function _54_(self)
    return (hydra.is_active() and not self.hydra_ignore[hydra.get_name()])
  end
  hydra_status = {utils.surround({icons.fill, icons.fill}, _53_, {name}), align, hint, align, condition = _54_, static = {hydra_ignore = {BarBar = true}}}
end
local special_status
local function _55_()
  return (" " .. icons.document .. " " .. string.upper(vim.bo.filetype) .. " ")
end
local function _56_()
  return conditions.buffer_matches({buftype = {"nofile", "prompt", "help", "quickfix"}, filetype = {"^git.*", "fugative"}})
end
special_status = {mode, align, help_name, align, {provider = _55_, hl = {fg = colors.bg, bg = colors.blue}, update = {"WinNew", "WinClosed", "BufEnter"}}, condition = _56_}
local terminal_status
local function _57_()
  return (" " .. icons.terminal .. " TERMINAL ")
end
local function _58_()
  return conditions.buffer_matches({buftype = {"terminal"}})
end
terminal_status = {mode, align, terminal_name, align, {provider = _57_, hl = {fg = colors.bg, bg = colors.red}, update = {"WinNew", "WinClosed", "BufEnter"}}, condition = _58_}
local default_status_line = {mode, space, git, sep_bar, diagnostics, sep_bar, harpoon, space, lsp_progress, align, align, ruler, bar, file_properties, space, root}
local statusline = {hydra_status, special_status, terminal_status, default_status_line, hl = {fg = colors.fg, bg = colors.bg, bold = true}, fallthrough = false}
vim.o.showtabline = 2
vim.o.laststatus = 3
return heirline.setup({statusline = statusline, tabline = tabline, opts = opts})
