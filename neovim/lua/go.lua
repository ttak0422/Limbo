-- [nfnl] Compiled from neovim/fnl/go.fnl by https://github.com/Olical/nfnl, do not edit.
local go = require("go")
local format = require("go.format")
local icons = {breakpoint = "\240\159\167\152", currentpos = "\240\159\143\131"}
local diagnostic = {underline = true, virtual_text = {spacing = 0, prefix = "\226\150\160"}, signs = true, hdlr = false, update_in_insert = false}
local lsp_inlay_hints = {enable = true, style = "inlay", only_current_line_autocmd = "CursorHold", show_variable_name = true, parameter_hints_prefix = "\243\176\138\149 ", show_parameter_hints = true, other_hints_prefix = "> ", max_len_align_padding = 1, right_align_padding = 6, highlight = "Comment", max_len_align = false, right_align = false, only_current_line = false}
local floaterm = {posititon = "auto", width = 0.45, height = 0.98, title_colors = "nord"}
local dap_debug_gui = {}
local dap_debug_vt = {enabled_commands = true, all_frames = true}
local on_attach
local function _1_(client, bufnr)
  local mk_opts
  local function _2_(desc)
    return {silent = true, buffer = bufnr, desc = desc}
  end
  mk_opts = _2_
  local n_keys
  local _3_
  do
    vim.cmd("GoVet")
    _3_ = vim.cmd("GoBuild")
  end
  n_keys = {{"<LocalLeader>r", vim.cmd("GoRun"), mk_opts("Run")}, {"<LocalLeader>f", vim.cmd("GoFmt"), mk_opts("Format")}, {"<LocalLeader>l", vim.cmd("GoLint", mk_opts("Lint"))}, {"<LocalLeader>b", _3_, mk_opts("Build")}}
  dofile(args.on_attach_path)(client, bufnr)
  for _, k in ipairs(n_keys) do
    vim.keymap.set("n", k[1], k[2], k[3])
  end
  return nil
end
on_attach = _1_
go.setup({go = "go", goimports = "gopls", gofmt = "gopls", fillstruct = "gopls", max_line_len = 0, tag_options = "json=omitempty", gotests_template = "", gotests_template_dir = "", comment_placeholder = "", icons = icons, lsp_cfg = {capabilities = dofile(args.capabilities_path)}, lsp_gofumpt = true, lsp_on_attach = on_attach, lsp_codelens = true, diagnostic = diagnostic, lsp_document_formatting = true, lsp_inlay_hints = lsp_inlay_hints, gopls_cmd = nil, gopls_remote_auto = true, gocoverage_sign = "\226\150\136", sign_priority = 5, dap_debug = true, dap_debug_gui = dap_debug_gui, dap_debug_vt = dap_debug_vt, dap_port = 38697, dap_timeout = 15, dap_retries = 20, build_tags = "tag1,tag2", textobjects = true, test_runner = "go", verbose_tests = true, floaterm = floaterm, iferr_vertical_shift = 4, disable_defaults = false, tag_transform = false, luasnip = false, dap_debug_keymap = false, trouble = false, run_in_floaterm = false, lsp_keymaps = false, verbose = false, test_efm = false})
local function _4_()
  return format.gofmt()
end
vim.api.nvim_create_autocmd({"BufWritePre"}, {pattern = "*.go", callback = _4_})
return vim.cmd("LspStart")
