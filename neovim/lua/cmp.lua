-- [nfnl] Compiled from neovim/fnl/cmp.fnl by https://github.com/Olical/nfnl, do not edit.
local cmp = require("cmp")
local types = require("cmp.types")
local compare = require("cmp.config.compare")
local luasnip = require("luasnip")
local snippet
local function _1_(args)
  return luasnip.lsp_expand(args.body)
end
snippet = {expand = _1_}
local performance = {debounce = 100, throttle = 100, fetching_timeout = 500, confirm_resolve_timeout = 80, async_budget = 1, max_view_entries = 100}
local preselect = types.cmp.PreselectMode.Item
local mapping
do
  local m = cmp.mapping
  mapping = {["<C-d>"] = m.scroll_docs(-4), ["<C-f>"] = m.scroll_docs(4), ["<C-n>"] = m.select_next_item(), ["<C-p>"] = m.select_prev_item(), ["<C-y>"] = m.confirm({select = true}), ["<C-e>"] = m.abort(), ["<C-x>"] = m.complete(), ["<C-x><C-x>"] = m.complete(), ["<C-x><C-f>"] = m.complete({config = {sources = {{name = "path"}}}}), ["<C-x><C-b>"] = m.complete({config = {sources = {{name = "buffer"}}}}), ["<C-x><C-l>"] = m.complete({config = {sources = {{name = "nvim_lsp"}}}})}
end
local completion = {autocomplete = {types.cmp.TriggerEvent.TextChanged}, completeopt = "menu,menuone,noselect", keyword_length = 2}
local formatting
local function _2_(_, item)
  return item
end
formatting = {expandable_indicator = true, fields = {"abbr", "kind", "menu"}, format = _2_}
local matching = {disallow_partial_fuzzy_matching = true, disallow_symbol_nonprefix_matching = true, disallow_partial_matching = false, disallow_fuzzy_matching = false, disallow_fullfuzzy_matching = false, disallow_prefix_unmatching = false}
local sorting = {priority_weight = 2, comparators = {compare.offset, compare.exact, compare.score, compare.recently_used, compare.locality, compare.kind, compare.length, compare.order}}
local sources = {{name = "nvim_lsp"}, {name = "luasnip"}, {name = "buffer"}}
local confirmation
local function _3_(commit_cs)
  return commit_cs
end
confirmation = {default_behavior = types.cmp.ConfirmBehavior.Insert, get_commit_characters = _3_}
local event = {}
local experimental = {ghost_text = false}
local view
do
  local entries = {name = "custom", selection_order = "top_down", follow_cursor = false}
  local docs = {auto_open = true}
  view = {entries = entries, docs = docs}
end
local window
do
  local border = {"\226\148\143", "\226\148\129", "\226\148\147", "\226\148\131", "\226\148\155", "\226\148\129", "\226\148\151", "\226\148\131"}
  local completion0 = cmp.config.window.bordered({border = border})
  local documentation = cmp.config.window.bordered({border = border})
  window = {completion = completion0, documentation = documentation}
end
return cmp.setup({snippet = snippet, performance = performance, preselect = preselect, mapping = mapping, completion = completion, formatting = formatting, matching = matching, sorting = sorting, sources = sources, confirmation = confirmation, event = event, experimental = experimental, view = view, window = window})
