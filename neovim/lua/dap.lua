-- [nfnl] Compiled from neovim/fnl/dap.fnl by https://github.com/Olical/nfnl, do not edit.
local dap = require("dap")
local dap_vscode = require("dap.ext.vscode")
local dap_ui = require("dapui")
local dap_virt = require("nvim-dap-virtual-text")
local dap_hl = require("nvim-dap-repl-highlights")
local morimo_colors = require("morimo.colors")
local icons = {expanded = "\226\150\190", collapsed = "\226\150\184", current_frame = "\226\150\184"}
local controls = {element = "repl", enabled = true, icons = {disconnect = "\238\171\144", pause = "\238\171\145", play = "\238\171\147", run_last = "\238\172\183", step_back = "\238\174\143", step_into = "\238\171\148", step_out = "\238\171\149", step_over = "\238\171\150", terminate = "\238\171\151"}}
local floating = {border = "none", mappings = {close = {"q", "<Esc>"}}}
local layouts = {{elements = {{id = "scopes", size = 0.25}, {id = "breakpoints", size = 0.25}, {id = "stacks", size = 0.25}, {id = "watches", size = 0.25}}, position = "left", size = 40}, {elements = {{id = "repl", size = 0.5}, {id = "console", size = 0.5}}, position = "bottom", size = 10}}
local mappings = {edit = "e", expand = {"<CR>", "<2-LeftMouse>"}, open = "o", remove = "d", repl = "r", toggle = "t"}
local render = {indent = 1, max_value_lines = 100}
local display_callback
local function _1_(variable, _buf, _stackframe, _node, options)
  if (options.virt_text_pos == "inline") then
    return (" = " .. variable.value)
  else
    return (variable.name .. " = " .. variable.value)
  end
end
display_callback = _1_
local virt_text_pos
local function _3_()
  if (vim.fn.has("nvim-0.10") == 1) then
    return "inline"
  else
    return "eol"
  end
end
virt_text_pos = _3_()
local highlights = {{"dapblue", morimo_colors.lightBlue}, {"dapgreen", morimo_colors.lightGreen}, {"dapyellow", morimo_colors.lightYellow}, {"daporange", morimo_colors.orange}, {"dapred", morimo_colors.lightRed}}
local signs = {{"DapBreakpoint", "\239\128\164", "dapblue"}, {"DapBreakpointCondition", "\239\128\164", "dapblue"}, {"DapBreakpointRejected", "\239\134\146", "dapred"}, {"DapStopped", "\226\150\182", "dapgreen"}, {"DapLogPoint", "\239\134\146", "dapyellow"}}
local function _5_()
end
dap.listeners.before.event_terminated["dapui_config"] = _5_
local function _6_()
end
dap.listeners.before.event_exited["dapui_config"] = _6_
dap_vscode.load_launchjs()
dap_ui.setup({element_mappings = {}, expand_lines = true, force_buffers = true, icons = icons, controls = controls, floating = floating, layouts = layouts, mappings = mappings, render = render})
dap_virt.setup({enabled_commands = true, highlight_changed_variables = true, show_stop_reason = true, commented = true, only_first_definition = true, display_callback = display_callback, virt_text_pos = virt_text_pos, virt_text_win_col = nil, highlight_new_as_changed = false, all_references = false, enabled = false, all_frames = false, virt_lines = false, clear_on_continue = false})
dap_hl.setup({})
for _, h in ipairs(highlights) do
  vim.api.nvim_set_hl(0, h[1], {fg = h[2], bg = "#2a2a2e"})
end
for _, s in ipairs(signs) do
  vim.fn.sign_define(s[1], {text = s[2], texthl = s[3], linehl = "", numhl = ""})
end
return nil
