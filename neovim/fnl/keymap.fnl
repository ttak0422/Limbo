(set vim.g.mapleader " ")
(set vim.g.maplocalleader ",")

(let [os {:noremap true :silent true}
      mk_desc (fn [d] {:noremap true :silent true :desc d})
      map vim.keymap.set
      cmd (fn [c] (.. :<cmd> c :<cr>))
      lua_cmd (fn [c] (cmd (.. "lua " c)))
      mk_toggle ((fn []
                   (let [state {:is_open false :pre_id nil}]
                     (fn [id mod opt]
                       (fn []
                         (let [T (require :toolwindow)]
                           (if (not= state.pre_id id)
                               (do
                                 (T.open_window mod opt)
                                 (tset state :is_open true))
                               (if state.is_open
                                   (do
                                     (T.close)
                                     (tset state :is_open false))
                                   (do
                                     (T.open_window mod opt)
                                     (tset state :is_open true))))
                           (tset state :pre_id id)))))))
      ns [;; utils
          [:q :<nop>]
          [:<esc><esc> (cmd :nohl)]
          [:j :gj]
          [:k :gk]
          ;; split/join
          ; [:<leader>m
          ;  (lcmd "require('treesj').toggle()")
          ;  (d "toggle split/join")]
          ; [:<leader>M
          ;  (lcmd "require('treesj').toggle({ split = { recursive = true } })")
          ;  (d "toggle split/join rec")]
          ;; toggle
          ; [:gb (cmd :NvimTreeFocus)]
          ;; [:<leader>tb (cmd :NvimTreeToggle)]
          [:<leader>tb (lua_cmd "require('lir.float').toggle()")]
          [:<leader>tB (lua_cmd "require('oil').open_float()")]
          ; [:<leader>tB (cmd "Neotree toggle")]
          [:<leader>to (cmd :SidebarNvimToggle)]
          [:<leader>tm
           (lua_cmd "require('codewindow').toggle_minimap()")
           (mk_desc "toggle minimap")]
          ; [:<leader>tg (cmd :TigTermToggle) (mk_desc "toggle tig terminal")]
          ;; harpoon
          [:<leader>H
           (lua_cmd "require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())")
           (mk_desc "registered file menu")]
          [:<leader>ha
           (lua_cmd "require('harpoon'):list():add()")
           (mk_desc "register file")]
          ;; note
          [:<leader>nn (cmd :GlobalNote) (mk_desc "open global note")]
          [:<leader>N (cmd :Neorg) (mk_desc "Enter Neorg")]
          [:<leader>np (cmd :ProjectNote) (mk_desc "open project local note")]
          ;; git
          [:<leader>G (cmd :Neogit)]
          [:<leader>gg
           (fn []
             (vim.cmd (.. "Gin " (vim.fn.input "git command: "))))
           (mk_desc "git command (echo)")]
          [:<leader>gG
           (fn []
             (vim.cmd (.. "GinBuffer " (vim.fn.input "git command: "))))
           (mk_desc "git command (buffer)")]
          [:<leader>gb
           (cmd "execute printf('Gina blame --width=%d', &columns / 3)")
           (mk_desc "git blame")]
          [:<leader>gs (cmd :GinStatus) (mk_desc "git status")]
          [:<leader>gl (cmd :GinLog) (mk_desc "git log")]
          ; [:<leader>G (cmd :Neogit) (mk_desc "magit for vim")]
          ;; finder
          [:<leader>ff
           (cmd "Telescope live_grep_args")
           (mk_desc "search by content")]
          [:<leader>fF
           (cmd "Telescope ast_grep")
           (mk_desc "search by structure")]
          [:<leader>fp
           (cmd "Ddu -name=fd file_fd")
           (mk_desc "search by file name")]
          [:<leader>fP (cmd "Ddu -name=ghq ghq") (mk_desc "search repo (ghq)")]
          [:<leader>fb (cmd "Telescope buffers") (mk_desc "search buffer")]
          [:<leader>fh (cmd :Legendary) (mk_desc "search legendary")]
          [:<leader>ft
           (cmd "Telescope sonictemplate templates")
           (mk_desc "search templates")]
          [:<leader>fru
           (cmd "Ddu -name=mru mru")
           (mk_desc "MRU (Most Recently Used files)")]
          [:<leader>frw
           (cmd "Ddu -name=mrw mrw")
           (mk_desc "MRW (Most Recently Written files)")]
          [:<leader>frr
           (cmd "Ddu -name=mrr mrr")
           (mk_desc "MRR (Most Recent git Repositories)")]
          [:<leader>F
           (lua_cmd "require('spectre').open()")
           (mk_desc "find and replace with dark power")]]]
  (each [_ keymap (ipairs ns)]
    (map :n (. keymap 1) (. keymap 2) (or (. keymap 3) os)))
  (for [i 0 9]
    (map [:n :t :i] (.. :<C- i ">") (cmd (.. "TermToggle " i))
         (mk_desc (.. "toggle terminal " i))))
  ;; toggle
  (map :n :<leader>tq (mk_toggle 1 :quickfix nil) (mk_desc "toggle quickfix"))
  (map :n :<leader>td (mk_toggle 2 :trouble {:mode :document_diagnostics})
       (mk_desc "toggle diagnostics (document)"))
  (map :n :<leader>tD (mk_toggle 3 :trouble {:mode :workspace_diagnostics})
       (mk_desc "toggle diagnostics (workspace)")))
