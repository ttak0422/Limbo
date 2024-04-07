-- [nfnl] Compiled from neovim/fnl/go.fnl by https://github.com/Olical/nfnl, do not edit.
local go = require("go")
local format = require("go.format")
local icons = {breakpoint = "\240\159\167\152", currentpos = "\240\159\143\131"}
local diagnostic = {underline = true, virtual_text = {spacing = 0, prefix = "\226\150\160"}, signs = true, hdlr = false, update_in_insert = false}
local lsp_inlay_hints = {enable = true, style = "inlay", only_current_line_autocmd = "CursorHold", show_variable_name = true, parameter_hints_prefix = "\243\176\138\149 ", show_parameter_hints = true, other_hints_prefix = "> ", max_len_align_padding = 1, right_align_padding = 6, highlight = "Comment", only_current_line = false, max_len_align = false, right_align = false}
local floaterm = {posititon = "auto", width = 0.45, height = 0.98, title_colors = "nord"}
local dap_debug_gui = {}
local dap_debug_vt = {enabled_commands = true, all_frames = true}
go.setup({go = "go", goimports = "gopls", gofmt = "gopls", fillstruct = "gopls", max_line_len = 0, tag_options = "json=omitempty", gotests_template = "", gotests_template_dir = "", comment_placeholder = "", icons = icons, lsp_cfg = true, lsp_gofumpt = true, lsp_on_attach = dofile(args.on_attach_path), lsp_keymaps = true, lsp_codelens = true, diagnostic = diagnostic, lsp_document_formatting = true, lsp_inlay_hints = lsp_inlay_hints, gopls_cmd = nil, gopls_remote_auto = true, gocoverage_sign = "\226\150\136", sign_priority = 5, dap_debug = true, dap_debug_gui = dap_debug_gui, dap_debug_vt = dap_debug_vt, dap_port = 38697, dap_timeout = 15, dap_retries = 20, build_tags = "tag1,tag2", textobjects = true, test_runner = "go", verbose_tests = true, floaterm = floaterm, iferr_vertical_shift = 4, dap_debug_keymap = false, run_in_floaterm = false, test_efm = false, luasnip = false, trouble = false, disable_defaults = false, verbose = false, tag_transform = false})
local function _1_()
  return format.goimports()
end
vim.api.nvim_create_autocmd({"BufWritePre"}, {pattern = "*.go", callback = _1_})
return vim.cmd("LspStart")
