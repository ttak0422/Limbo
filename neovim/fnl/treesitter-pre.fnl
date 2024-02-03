(local parser_install_dir (.. (vim.fn.stdpath :state) :/parser))
(: vim.opt.runtimepath :prepend parser_install_dir)
