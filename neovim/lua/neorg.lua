-- [nfnl] Compiled from neovim/fnl/neorg.fnl by https://github.com/Olical/nfnl, do not edit.
local neorg = require("neorg")
local completion = {engine = "nvim-cmp"}
local defaults = {disable = {}}
local dirman = {workspaces = {notes = "~/neorg"}, default_workspace = "notes"}
local keybinds
local function _1_(keybinds0)
  local leader = keybinds0.leader
  local norg_keymap_n = {}
  local norg_keymap_i = {}
  local norg_event_n = {{(leader .. "e"), "core.looking-glass.magnify-code-block"}, {(leader .. "tu"), "core.qol.todo_items.todo.task_undone"}, {(leader .. "tp"), "core.qol.todo_items.todo.task_pending"}, {(leader .. "td"), "core.qol.todo_items.todo.task_done"}, {(leader .. "th"), "core.qol.todo_items.todo.task_on_hold"}, {(leader .. "tc"), "core.qol.todo_items.todo.task_cancelled"}, {(leader .. "tr"), "core.qol.todo_items.todo.task_recurring"}, {(leader .. "ti"), "core.qol.todo_items.todo.task_important"}, {(leader .. "ta"), "core.qol.todo_items.todo.task_ambiguous"}, {"<C-Space>", "core.qol.todo_items.todo.task_cycle"}, {(leader .. "nn"), "core.dirman.new.note"}, {"<CR>", "core.esupports.hop.hop-link"}, {"gd", "core.esupports.hop.hop-link"}, {"gf", "core.esupports.hop.hop-link"}, {"gF", "core.esupports.hop.hop-link"}, {">>", "core.promo.promote"}, {"<<", "core.promo.demote"}, {"lt", "core.pivot.toggle-list-type"}, {"li", "core.pivot.invert-list-type"}}
  local norg_event_i = {{"<C-t>", "core.promo.promote"}, {"<C-d>", "core.promo.demote"}}
  for _, _2_ in ipairs(norg_keymap_n) do
    local _each_3_ = _2_
    local key = _each_3_[1]
    local cmd = _each_3_[2]
    keybinds0.map("norg", "n", key, cmd)
  end
  for _, _4_ in ipairs(norg_keymap_i) do
    local _each_5_ = _4_
    local key = _each_5_[1]
    local cmd = _each_5_[2]
    keybinds0.map("norg", "i", key, cmd)
  end
  for _, _6_ in ipairs(norg_event_n) do
    local _each_7_ = _6_
    local key = _each_7_[1]
    local ev = _each_7_[2]
    keybinds0.remap_event("norg", "n", key, ev)
  end
  for _, _8_ in ipairs(norg_event_i) do
    local _each_9_ = _8_
    local key = _each_9_[1]
    local ev = _each_9_[2]
    keybinds0.remap_event("norg", "i", key, ev)
  end
  return nil
end
keybinds = {neorg_leader = "<LocalLeader>", hook = _1_, default_keybinds = false}
local journal = {journal_folder = "journal", strategy = "nested"}
local load = {["core.autocommands"] = {}, ["core.completion"] = {config = completion}, ["core.defaults"] = {config = defaults}, ["core.dirman"] = {config = dirman}, ["core.integrations.nvim-cmp"] = {}, ["core.integrations.treesitter"] = {}, ["core.keybinds"] = {config = keybinds}, ["core.storage"] = {}, ["core.summary"] = {}, ["core.ui"] = {}, ["core.journal"] = {config = journal}}
local cmp = require("cmp")
local sources = cmp.config.sources({{name = "neorg"}}, {{name = "buffer"}})
neorg.setup({load = load})
return cmp.setup.filetype("norg", {sources = sources})
