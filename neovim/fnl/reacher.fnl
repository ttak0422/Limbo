(let [M (require :reacher)
      m vim.keymap.set
      o {:noremap true :silent true :buffer true}
      pattern [:reacher]
      callback (fn []
                 (m :i :<cr> reacher.finish o)
                 (m :i :<esc> reacher.cancel o)
                 (m :i :<Tab> reacher.next o)
                 (m :i :<S-Tab> reacher.previous o)
                 (m :i :<C-n> reacher.forward_history o)
                 (m :i :<C-p> reacher.backward_history o))]
  (vim.api.nvim_create_autocmd [:FileType] {: pattern : callback}))
