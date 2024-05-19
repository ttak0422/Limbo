-- [nfnl] Compiled from neovim/fnl/neorg.fnl by https://github.com/Olical/nfnl, do not edit.
local neorg = require("neorg")
local callbacks = require("neorg.core.callbacks")
local completion = {engine = "nvim-cmp"}
local defaults = {disable = {}}
local dirman = {workspaces = {notes = "~/neorg"}, default_workspace = "notes"}
local leader = "<LocalLeader>"
local keybinds
local function _1_(_kb)
end
keybinds = {neorg_leader = "<LocalLeader>", hook = _1_, default_keybinds = false}
local journal = {journal_folder = "journal", strategy = "nested"}
local metagen = {type = "auto"}
local templates = {templates_dir = {}, default_subcommand = "fload"}
local load = {["core.autocommands"] = {}, ["core.completion"] = {config = completion}, ["core.defaults"] = {config = defaults}, ["core.dirman"] = {config = dirman}, ["core.integrations.nvim-cmp"] = {}, ["core.integrations.treesitter"] = {}, ["core.keybinds"] = {config = keybinds}, ["core.storage"] = {}, ["core.summary"] = {}, ["core.ui"] = {}, ["core.journal"] = {config = journal}, ["core.esupports.metagen"] = {config = metagen}, ["core.integrations.telescope"] = {}, ["external.jupyter"] = {}, ["external.templates"] = {config = templates}}
local cmp = require("cmp")
local sources = cmp.config.sources({{name = "neorg"}}, {{name = "buffer"}})
neorg.setup({load = load})
local function _2_(_, kb)
  return kb.map_event_to_mode("norg", {n = {{"<C-Space>", "core.qol.todo_items.todo.task_cycle"}, {"<CR>", "core.esupports.hop.hop-link"}, {"<C-s>", "core.integrations.telescope.find_linkable"}}, i = {{"<C-i>", "core.integrations.telescope.insert_link"}}}, {silent = true})
end
callbacks.on_event("core.keybinds.events.enable_keybinds", _2_)
return cmp.setup.filetype("norg", {sources = sources})
