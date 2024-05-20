-- [nfnl] Compiled from neovim/fnl/neorg.fnl by https://github.com/Olical/nfnl, do not edit.
local neorg = require("neorg")
local callbacks = require("neorg.core.callbacks")
local completion = {engine = "nvim-cmp"}
local defaults = {disable = {}}
local dirman = {workspaces = {notes = "~/neorg"}, default_workspace = "notes"}
local leader = "<LocalLeader>"
local cmd
local function _1_(c)
  return ("<Cmd>" .. c .. "<CR>")
end
cmd = _1_
local normal_keys = {["<LocalLeader>to"] = cmd("Neorg journal toc open"), ["<LocalLeader>tO"] = cmd("Neorg toc")}
local normal_events = {{"<C-Space>", "core.qol.todo_items.todo.task_cycle"}, {"<CR>", "core.esupports.hop.hop-link"}, {"<M-CR>", "core.esupports.hop.hop-link", "vsplit", opts = {desc = "\238\152\179 Jump to Link (Vertical Split)"}}, {(leader .. "e"), "core.looking-glass.magnify-code-block", opts = {desc = "\238\152\179 Edit Code Block"}}, {(leader .. "lt"), "core.pivot.toggle-list-type", opts = {desc = "\238\152\179 Toggle List Type"}}, {(leader .. "li"), "core.pivot.invert-list-type", opts = {desc = "\238\152\179 Invert List Type"}}}
local insert_events = {{"<C-i>", "core.integrations.telescope.insert_link"}}
local key_opts = {silent = true}
local keybinds
local function _2_(kb)
  for key, cmd0 in pairs(normal_keys) do
    kb.map("norg", "n", key, cmd0)
  end
  return nil
end
keybinds = {neorg_leader = "<LocalLeader>", hook = _2_, default_keybinds = false}
local journal = {journal_folder = "journal", strategy = "nested"}
local metagen = {type = "auto"}
local templates = {templates_dir = {}, default_subcommand = "fload"}
local load = {["core.autocommands"] = {}, ["core.completion"] = {config = completion}, ["core.defaults"] = {config = defaults}, ["core.dirman"] = {config = dirman}, ["core.integrations.nvim-cmp"] = {}, ["core.integrations.treesitter"] = {}, ["core.keybinds"] = {config = keybinds}, ["core.storage"] = {}, ["core.summary"] = {}, ["core.ui"] = {}, ["core.journal"] = {config = journal}, ["core.esupports.metagen"] = {config = metagen}, ["core.integrations.telescope"] = {}, ["external.jupyter"] = {}, ["external.templates"] = {config = templates}}
local cmp = require("cmp")
local sources = cmp.config.sources({{name = "neorg"}}, {{name = "buffer"}})
neorg.setup({load = load})
local function _3_(_, kb)
  return kb.map_event_to_mode("norg", {n = normal_events, i = insert_events}, key_opts)
end
callbacks.on_event("core.keybinds.events.enable_keybinds", _3_)
return cmp.setup.filetype("norg", {sources = sources})
