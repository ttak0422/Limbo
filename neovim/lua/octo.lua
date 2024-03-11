-- [nfnl] Compiled from neovim/fnl/octo.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("octo")
local f
local function _1_(key, desc)
  return {lhs = key, desc = desc}
end
f = _1_
local picker_mappings = {open_in_browser = {["<C-b>"] = "open issue in browser"}, copy_url = {["<C-y>"] = "copy url to system clipboard"}, checkout_pr = {["<C-o>"] = "checkout pull request"}}
local picker_config = {mappings = picker_mappings, use_emojis = false}
local ui = {use_signcolumn = true}
local issues = {order_by = {field = "CREATED_AT", direction = "DESC"}}
local pull_requests = {order_by = {field = "CREATED_AT", direction = "DESC"}, always_select_remote_on_create = false}
local file_panel = {size = 10, use_icons = true}
local colors = {white = "#ffffff", grey = "#2A354C", black = "#000000", red = "#fdb8c0", dark_red = "#fa4343", green = "#acf2bd", dark_green = "#238636", yellow = "#d3c846", dark_yellow = "#735c0f", blue = "#58A6FF", dark_blue = "#0366d6", purple = "#6f42c1"}
return M.setup({default_remote = {"upstream", "origin"}, default_merge_method = "commit", ssh_aliases = {}, picker = "telescope", picker_config = picker_config, comment_icon = "\226\150\142", outdated_icon = "\243\176\133\146 ", resolved_icon = "\239\128\140 ", reaction_viewer_hint_icon = "\239\145\132 ", user_icon = "\239\138\189 ", timeline_marker = "\239\145\160 ", timeline_indent = "2", right_bubble_delimiter = "", left_bubble_delimiter = "", github_hostname = "", snippet_context_lines = 4, gh_cmd = "gh", gh_env = {}, timeout = 5000, ui = ui, issues = issues, pull_requests = pull_requests, file_panel = file_panel, colors = colors, mappings = mappings, default_to_projects_v2 = false, use_local_fs = false, enable_builtin = false})
