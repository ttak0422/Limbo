-- [nfnl] Compiled from neovim/fnl/global-note.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("global-note")
local get_project_name
local function _1_()
  local result = vim.system({"git", "rev-parse", "--show-toplevel"}, {text = true}):wait()
  if (result.stderr ~= "") then
    return vim.notify(result.stderr, vim.log.levels.WARN)
  else
    local project_directory = (result.stdout):gsub("\n", "")
    local project_name = vim.fs.basename(project_directory)
    if (project_name == nil) then
      return vim.notify("Unable to get the project name", vim.log.levels.WARN)
    else
      return project_name
    end
  end
end
get_project_name = _1_
local additional_presets
local function _4_()
  return (get_project_name() .. ".md")
end
additional_presets = {project_local = {command_name = "ProjectNote", filename = _4_, title = "Project note"}}
return M.setup({filename = "global.md", directory = "~/notes/", additional_presets = additional_presets})
