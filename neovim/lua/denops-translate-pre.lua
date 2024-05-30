-- [nfnl] Compiled from neovim/fnl/denops-translate-pre.fnl by https://github.com/Olical/nfnl, do not edit.
local translate_border_chars = "none"
local translate_sentence_break = {en = ".", ja = "."}
local configs = {translate_source = "en", translate_target = "ja", translate_endpoint = "https://api-free.deepl.com/v2/translate", translate_ui = "popup", translate_sentence_break = translate_sentence_break, translate_border_chars = translate_border_chars}
for k, v in pairs(configs) do
  vim.g[k] = v
end
return nil
