-- [nfnl] Compiled from neovim/fnl/cmp.fnl by https://github.com/Olical/nfnl, do not edit.
local cmp = require("cmp")
local types = require("cmp.types")
local compare = require("cmp.config.compare")
local luasnip = require("luasnip")
local ignore_ft = {["ddu-ff-filter"] = true}
local enabled
local function _1_()
  local disabled = (false or (vim.api.nvim_buf_get_option(0, "buftype") == "prompt") or ignore_ft[vim.bo.filetype] or (vim.fn.reg_recording() ~= "") or (vim.fn.reg_executing() ~= ""))
  return not disabled
end
enabled = _1_
local snippet
local function _2_(args)
  return luasnip.lsp_expand(args.body)
end
snippet = {expand = _2_}
local performance = {debounce = 100, throttle = 100, fetching_timeout = 500, confirm_resolve_timeout = 80, async_budget = 1, max_view_entries = 100}
local preselect = types.cmp.PreselectMode.Item
local mapping
do
  local m = cmp.mapping
  local behavior = cmp.SelectBehavior.Select
  local function _3_(fallback)
    if luasnip.expand_or_jumpable() then
      return luasnip.expand_or_jump()
    else
      return fallback()
    end
  end
  local function _5_(fallback)
    if luasnip.expand_or_jumpable() then
      return luasnip.expand_or_jump()
    else
      return fallback()
    end
  end
  mapping = {["<C-d>"] = m.scroll_docs(-4), ["<C-f>"] = m.scroll_docs(4), ["<C-n>"] = m.select_next_item({behavior = behavior}), ["<C-p>"] = m.select_prev_item({behavior = behavior}), ["<C-y>"] = m.confirm({select = true}), ["<C-e>"] = m.abort(), ["<C-k>"] = m(_3_, {"i", "s"}), ["<C-l>"] = m(_5_, {"i", "s"}), ["<C-x>"] = m.complete(), ["<C-x><C-x>"] = m.complete(), ["<C-x><C-f>"] = m.complete({config = {sources = {{name = "path"}}}}), ["<C-x><C-b>"] = m.complete({config = {sources = {{name = "buffer"}}}}), ["<C-x><C-l>"] = m.complete({config = {sources = {{name = "nvim_lsp"}}}})}
end
local completion = {autocomplete = {types.cmp.TriggerEvent.TextChanged}, completeopt = "menu,menuone,noselect", keyword_length = 1}
local formatting
local function _7_(_, item)
  return item
end
formatting = {expandable_indicator = true, fields = {"abbr", "kind", "menu"}, format = _7_}
local matching = {disallow_partial_fuzzy_matching = true, disallow_symbol_nonprefix_matching = true, disallow_fullfuzzy_matching = false, disallow_fuzzy_matching = false, disallow_partial_matching = false, disallow_prefix_unmatching = false}
local sorting = {priority_weight = 2, comparators = {compare.offset, compare.exact, compare.scopes, compare.score, compare.recently_used, compare.locality, compare.kind, compare.sort_text, compare.length, compare.order}}
local sources = {{name = "nvim_lsp", priority = 100, group_index = 1}, {name = "luasnip", priority = 95, group_index = 1}, {name = "buffer", option = {keyword_length = 2}, priority = 90, group_index = 1}}
local confirmation
local function _8_(commit_cs)
  return commit_cs
end
confirmation = {default_behavior = types.cmp.ConfirmBehavior.Insert, get_commit_characters = _8_}
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
cmp.setup({enabled = enabled, snippet = snippet, performance = performance, preselect = preselect, mapping = mapping, completion = completion, formatting = formatting, matching = matching, sorting = sorting, sources = sources, confirmation = confirmation, event = event, experimental = experimental, view = view, window = window})
vim.cmd("inoremap <expr> <C-Space> '<C-n>'")
cmp.setup.cmdline("/", {mapping = cmp.mapping.preset.cmdline(), sources = {{name = "buffer"}}})
cmp.setup.cmdline("?", {mapping = cmp.mapping.preset.cmdline(), sources = {{name = "buffer"}}})
return cmp.setup.cmdline(":", {mapping = cmp.mapping.preset.cmdline(), sources = {{name = "cmdline", priority = 100, group_index = 1}, {name = "cmdline_history", priority = 95, group_index = 1}, {name = "buffer", group_index = 2}}})
