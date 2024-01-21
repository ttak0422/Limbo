(let [config (require :config-local)]
  (config.setup {:config_files [:.vimrc.lua] :silent true}))
