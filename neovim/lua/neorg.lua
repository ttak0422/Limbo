-- [nfnl] Compiled from neovim/fnl/neorg.fnl by https://github.com/Olical/nfnl, do not edit.
local neorg = require("neorg")
local completion = {engine = "nvim-cmp"}
local defaults = {disable = {}}
local dirman = {workspaces = {notes = "~/notes", default_workspace = "notes"}}
local keybinds = {default_keybinds = false}
local load = {["core.autocommands"] = {}, ["core.completion"] = {config = completion}, ["core.defaults"] = {config = defaults}, ["core.dirman"] = {config = dirman}, ["core.integrations.nvim-cmp"] = {}, ["core.integrations.treesitter"] = {}, ["core.keybinds"] = {config = keybinds}, ["core.storage"] = {}, ["core.summary"] = {}, ["core.ui"] = {}}
local cmp = require("cmp")
local sources = cmp.config.sources({{name = "neorg"}}, {{name = "buffer"}})
neorg.setup({load = load})
return cmp.setup.filetype("norg", {sources = sources})
