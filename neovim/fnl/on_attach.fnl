(fn [client bufnr]
  (let [map vim.keymap.set
        desc (fn [d] {:noremap true :silent true :buffer bufnr :desc d})
        inlayhints (require :lsp-inlayhints)]
    ;; jump
    (map :n :gd vim.lsp.buf.definition (desc "go to definition"))
    (map :n :gsd "<cmd>split<bar>lua vim.lsp.buf.definition()<cr>"
         (desc "go to definition (split)"))
    (map :n :gvd "<cmd>vsplit<bar>lua vim.lsp.buf.definition()<cr>"
         (desc "go to definition (vsplit)"))
    (map :n :gi vim.lsp.buf.implementation (desc "go to impl"))
    (map :n :gsi "<cmd>split<bar>lua vim.lsp.buf.implementation<cr>"
         (desc "go to impl (split)"))
    (map :n :gvi "<cmd>vsplit<bar>lua vim.lsp.buf.implementation<cr>"
         (desc "go to impl (vsplit)"))
    (map :n :gr vim.lsp.buf.references (desc "go to references"))
    (map :n :gsr "<cmd>split<bar>lua vim.lsp.buf.references<cr>"
         (desc "go to references (split)"))
    (map :n :gvr "<cmd>vsplit<bar>lua vim.lsp.buf.references<cr>"
         (desc "go to references (vsplit)"))
    (map :n :gD "<cmd>Glance definitions<cr>" (desc "go to definition"))
    (map :n :gI "<cmd>Glance implementations<cr>" (desc "go to impl"))
    (map :n :gR "<cmd>Glance references<cr>" (desc "go to references"))
    ;; action
    (map :n :K vim.lsp.buf.hover (desc "show doc"))
    ;; map("n" "K" require("hover").hover (desc "show doc"))
    ;; map("n" "K" require("pretty_hover").hover (desc "show doc"))
    (map :n :<leader>K vim.lsp.buf.signature_help (desc "show signature"))
    (map :n :<leader>D vim.lsp.buf.type_definition (desc "show type"))
    (map :n :<leader>rn vim.lsp.buf.rename (desc :rename))
    ;; map("n" "<leader>ca" require("actions-preview").code_actions (desc "code action"))
    (map :n :<leader>ca vim.lsp.buf.code_action (desc "code action"))
    (map :n :<leader>cc "<cmd>Neogen class<cr>" (desc "class comment"))
    (map :n :<leader>cj
         "<cmd>lua require('treesj').toggle({ split = { recursive = false }})<cr>"
         (desc "toggle split/join"))
    (map :n :<leader>cJ
         "<cmd>lua require('treesj').toggle({ split = { recursive = true }})<cr>"
         (desc "toggle split/join rec"))
    (map :n :<leader>cf "<cmd>Neogen func<cr>" (desc "fn comment"))
    (if (client.supports_method :textDocument/formatting)
        (map :n :<leader>cF :<cmd>Format<cr> (desc :format)))
    ;; info
    (if (client.supports_method :textDocument/inlayHint)
        (inlayhints.on_attach client bufnr false))
    (if (client.supports_method :textDocument/publishDiagnostics)
        ;; delay update diagnostics
        (set vim.lsp.handlers.textDocument/publishDiagnostics
             (vim.lsp.with vim.lsp.diagnostic.on_publish_diagnostics
               {:update_in_insert false})))))
