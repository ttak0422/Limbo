(set vim.g.mapleader " ")
(set vim.g.maplocalleader ",")

(let [os {:noremap true :silent true}
      desc (fn [d] {:noremap true :silent true :desc d})
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
          ;; marks
          [:<leader>mq (cmd :MarksQFListBuf) (desc "marks in current buffer")]
          [:<leader>mQ (cmd :MarksQFListGlobal) (desc "marks in all buffer")]
          ;; split/join
          ; [:<leader>m
          ;  (lcmd "require('treesj').toggle()")
          ;  (d "toggle split/join")]
          ; [:<leader>M
          ;  (lcmd "require('treesj').toggle({ split = { recursive = true } })")
          ;  (d "toggle split/join rec")]
          [:gpd
           (lua_cmd "require('goto-preview').goto_preview_definition()")
           (desc "preview definition")]
          [:gpi
           (lua_cmd "require('goto-preview').goto_preview_implementation()")
           (desc "preview implementation")]
          [:gpr
           (lua_cmd "require('goto-preview').goto_preview_references()")
           (desc "preview references")]
          [:gP
           (lua_cmd "require('goto-preview').close_all_win()")
           (desc "close all preview")]
          [:gh
           (lua_cmd "require('dropbar.api').pick()")
           (desc "pick hierarchy")]
          ;; git
          [:<leader>gg
           (fn []
             (vim.cmd (.. "Gin " (vim.fn.input "git command: "))))
           (desc "git command (echo)")]
          [:<leader>gG
           (fn []
             (vim.cmd (.. "GinBuffer " (vim.fn.input "git command: "))))
           (desc "git command (buffer)")]
          [:<leader>gb
           (cmd "execute printf('Gina blame --width=%d', &columns / 3)")
           (desc "git blame")]
          [:<leader>gs (cmd :GinStatus) (desc "git status")]
          [:<leader>gl (cmd :GinLog) (desc "git log")]
          ; [:<leader>G (cmd :Neogit) (desc "magit for vim")]
          ;; tools
          [:<leader>q (cmd :BufDel)]
          [:<leader>Q (cmd :BufDel!)]
          [:<leader>A (cmd :tabclose)]
          [:<leader>E (cmd :FeMco) (desc "edit code block")]
          ;; buffer
          [:<leader>br
           (lua_cmd "require('harpoon.mark').add_file()")
           (desc "register buffer (harpoon)")]
          ;; toggle
          [:<leader>tc (cmd :ColorizerToggle) (desc "toggle colorize")]
          [:<leader>tb (cmd :NvimTreeToggle)]
          ; [:<leader>tB (cmd "Neotree toggle")]
          [:<leader>to (cmd :SidebarNvimToggle)]
          [:<leader>tm
           (lua_cmd "require('codewindow').toggle_minimap()")
           (desc "toggle minimap")]
          [:<leader>tr
           (lua_cmd "require('harpoon.ui').toggle_quick_menu()")
           (desc "toggle registered buffer menu")]
          [:<leader>tg (cmd :TigTermToggle) (desc "toggle tig terminal")]
          ;; finder
          [:<leader>ff
           (cmd "Telescope live_grep_args")
           (desc "search by content")]
          [:<leader>fp
           (cmd "Ddu -name=fd file_fd")
           (desc "search by file name")]
          [:<leader>fP (cmd "Ddu -name=ghq ghq") (desc "search repo (ghq)")]
          [:<leader>fb (cmd "Telescope buffers") (desc "search buffer")]
          [:<leader>fh (cmd :Legendary) (desc "search legendary")]
          [:<leader>ft
           (cmd "Telescope sonictemplate templates")
           (desc "search templates")]
          [:<leader>fru
           (cmd "Ddu -name=mru mru")
           (desc "MRU (Most Recently Used files)")]
          [:<leader>frw
           (cmd "Ddu -name=mrw mrw")
           (desc "MRW (Most Recently Written files)")]
          [:<leader>frr
           (cmd "Ddu -name=mrr mrr")
           (desc "MRR (Most Recent git Repositories)")]
          [:<leader>fF
           (lua_cmd "require('spectre').open()")
           (desc "find and replace with dark power")]
          ;; runner
          [:<leader>rr (cmd :FlowRunFile)]]
      vs [;; runner
          [:<leader>r (cmd :FlowRunSelected)]]
      is [; [:<C-t>
          ;  (lua_cmd "require('treesj').toggle()")
          ;  (desc "toggle split/join")]
          ]]
  (each [_ keymap (ipairs ns)]
    (map :n (. keymap 1) (. keymap 2) (or (. keymap 3) os)))
  (each [_ keymap (ipairs vs)]
    (map :v (. keymap 1) (. keymap 2) (or (. keymap 3) os)))
  (each [_ keymap (ipairs is)]
    (map :v (. keymap 1) (. keymap 2) (or (. keymap 3) os)))
  (for [i 0 9]
    (map [:n :t :i] (.. :<C- i ">") (cmd (.. "TermToggle " i))
         (desc (.. "toggle terminal " i))))
  ;; toggle
  (map :n :<leader>tq (mk_toggle 1 :quickfix nil (desc "toggle quickfix")))
  (map :n :<leader>td (mk_toggle 2 :trouble {:mode :document_diagnostics})
       (desc "toggle diagnostics (document)"))
  (map :n :<leader>tD (mk_toggle 3 :trouble {:mode :workspace_diagnostics})
       (desc "toggle diagnostics (workspace)"))
  ;; reacher
  (map [:n :x] :gs (lua_cmd "require('reacher').start()")
       (desc "search displayed"))
  (map [:n :x] :gS (lua_cmd "require('reacher').start_multiple()")
       (desc "search displayed"))
  (map [:n :i :c :t] "¥" "\\"))
