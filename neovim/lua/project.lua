-- [nfnl] Compiled from neovim/fnl/project.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("project_nvim")
local detection_methods = {"pattern"}
local patterns = {".git"}
return M.setup({scope_chdir = "tab", detection_methods = detection_methods, patterns = patterns, manual_mode = false})
