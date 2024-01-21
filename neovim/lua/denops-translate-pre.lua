-- [nfnl] Compiled from neovim/fnl/denops-translate-pre.fnl by https://github.com/Olical/nfnl, do not edit.
local configs = {translate_source = "en", translate_target = "ja", translate_endpoint = "https://api-free.deepl.com/v2/translate", translate_ui = "popup", translate_sentence_break = {en = ".", ja = "."}, translate_border_chars = {"\226\148\143", "\226\148\129", "\226\148\147", "\226\148\131", "\226\148\155", "\226\148\129", "\226\148\151", "\226\148\131"}}
for k, v in pairs(configs) do
  vim.g[k] = v
end
return nil
