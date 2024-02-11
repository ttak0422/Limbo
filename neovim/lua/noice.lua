-- [nfnl] Compiled from neovim/fnl/noice.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("noice")
local U = require("noice.util")
local L = require("noice.lsp")
local cmdline
do
  local opts = {zindex = 95}
  local format = {cmdline = {pattern = "^:", icon = "\239\146\181", lang = "vim", title = ""}, search_down = {kind = "search", pattern = "^/", icon = "\239\128\130 \239\132\131", lang = "regex", title = ""}, search_up = {kind = "search", pattern = "^%?", icon = "\239\128\130 \239\132\130", lang = "regex", title = ""}, filter = {pattern = "^:%s*!", icon = "$", lang = "bash", title = ""}, lua = {pattern = "^:%s*lua%s+", icon = "\238\152\160", lang = "lua", title = ""}, help = {pattern = "^:%s*he?l?p?%s+", icon = "?", title = ""}, input = {}}
  cmdline = {enabled = true, view = "cmdline", opts = opts, format = format}
end
local messages = {enabled = true, view = "notify", view_error = "notify", view_warn = "notify", view_history = "messages", view_search = "virtualtext"}
local popupmenu = {enabled = true, backend = "nui", kind_icons = {}}
local redirect = {view = "popup", filter = {event = "msg_show"}}
local commands
do
  local history = {view = "split", opts = {enter = true, format = "details"}, filter = {any = {{event = "notify"}, {error = true}, {warning = true}, {event = "msg_show", kind = {""}}, {event = "lsp", kind = "message"}}}}
  local last = {view = "popup", opts = {enter = true, format = "details"}, filter = {any = {{event = "notify"}, {error = true}, {warning = true}, {event = "msg_show", kind = {""}}, {event = "lsp", kind = "message"}}}, filter_opts = {count = 1}}
  local errors = {view = "popup", opts = {enter = true, format = "details"}, filter = {error = true}, filter_opts = {reverse = true}}
  commands = {history = history, last = last, errors = errors}
end
local notify = {enabled = true, view = "notify"}
local lsp
do
  local progress = {enabled = false}
  local override = {"vim.lsp.util.convert_input_to_markdown_lines", true, "vim.lsp.util.stylize_markdown", true}
  local hover = {enabled = true, silent = true, view = "hover", opts = {}}
  local signature = {enabled = false}
  local message = {enabled = true, view = "notify", opts = {}}
  local documentation = {view = "hover", opts = {lang = "markdown", replace = true, render = "plain", format = {"{message}"}, win_options = {concealcursor = "n", conceallevel = 3}}}
  lsp = {progress = progress, override = override, hover = hover, signature = signature, message = message, documentation = documentation}
end
local markdown = {hover = {"|(%S-)|", vim.cmd.help, "%[.-%]%((%S-)%)", U.open}, highlights = {"|%S-|", "@text.reference", "@%S+", "@parameter", "^%s*(Parameters:)", "@text.title", "^%s*(Return:)", "@text.title", "^%s*(See also:)", "@text.title", "{%S-}", "@parameter"}}
local health = {checker = true}
local smart_move = {excluded_filetypes = dofile(args.exclude_ft_path)}
local presets = {bottom_search = true, long_message_to_split = true, lsp_doc_border = true, inc_rename = false, command_palette = false}
local throttle = (1000 / 30)
local views
do
  local border = {"\226\148\143", "\226\148\129", "\226\148\147", "\226\148\131", "\226\148\155", "\226\148\129", "\226\148\151", "\226\148\131"}
  local cmdline_popup = {border = {style = border}, filter_options = {}, win_options = {winhighlight = {Normal = "NormalFloat", FloatBorder = "FloatBorder"}}}
  local hover = {border = {style = border}}
  views = {cmdline_popup = cmdline_popup, hover = hover}
end
local routes = {{filter = {event = "msg_show", any = {{find = "%d+L %d+B"}, {find = "; after #%d+"}, {find = "; before #%d+"}, {find = "; \229\137\141\230\150\185 #%d+"}, {find = "; \229\190\140\230\150\185 #%d+"}, {find = "%d fewer lines"}, {find = "%d more lines"}, {find = "\230\155\184\232\190\188\227\129\191$"}}}, opts = {skip = true}}}
M.setup({cmdline = cmdline, messages = messages, popupmenu = popupmenu, redirect = redirect, commands = commands, notify = notify, lsp = lsp, markdown = markdown, health = health, smart_move = smart_move, presets = presets, throttle = throttle, views = views, routes = routes})
local function _1_()
  if L.scroll(4) then
    return "<C-f>"
  else
    return nil
  end
end
vim.keymap.set({"n", "i", "s"}, "<C-f>", _1_, {silent = true, expr = true})
local function _3_()
  if L.scroll(4) then
    return "<C-b>"
  else
    return nil
  end
end
return vim.keymap.set({"n", "i", "s"}, "<C-b>", _3_, {silent = true, expr = true})
