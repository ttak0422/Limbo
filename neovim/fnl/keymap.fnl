(set vim.g.mapleader " ")
(set vim.g.maplocalleader ",")

(let [os {:noremap true :silent true}
      d (fn [d] {:noremap true :silent true :desc d})
      m vim.keymap.set
      cmd (fn [c] (.. :<cmd> c :<cr>))
      lcmd (fn [c] (cmd (.. "lua " c)))
      ns [;; utils
              [:q :<nop>]
              [:<esc><esc> (cmd :nohl)]
              [:j :gj]
              [:k :gk]
              ;; split/join
              [:<leader>m
               (lcmd "require('treesj').toggle()")
               (d "toggle split/join")]
              [:<leader>M
               (lcmd "require('treesj').toggle({ split = { recursive = true } })")
               (d "toggle split/join rec")]
              [:gpd
               (lcmd "require('goto-preview').goto_preview_definition()")
               (d "preview definition")]
              [:gpi
               (lcmd "require('goto-preview').goto_preview_implementation()")
               (d "preview implementation")]
              [:gpr
               (lcmd "require('goto-preview').goto_preview_references()")
               (d "preview references")]
              [:gP
               (lcmd "require('goto-preview').close_all_win()")
               (d "close all preview")]
              ;; git
              [:<leader>gg
               (fn []
                 (vim.cmd (.. "Gin " (vim.fn.input "git command: "))))
               (d "git command (echo)")]
              [:<leader>gG
               (fn []
                 (vim.cmd (.. "GinBuffer " (vim.fn.input "git command: "))))
               (d "git command (buffer)")]
              [:<leader>gb
               (cmd "execute printf('Gina blame --width=%d', &columns / 3)")
               (d "git blame")]
              [:<leader>gs (cmd :GinStatus) (d "git status")]
              [:<leader>gl (cmd :GinLog) (d "git log")]
              ; [:<leader>G (cmd :Neogit) (desc "magit for vim")]
              ;; tools
              [:<leader>q (cmd :BufDel)]
              [:<leader>Q (cmd :BufDel!)]
              [:<leader>A (cmd :tabclose)]
              [:<leader>E (cmd :FeMco) (d "edit code block")]
              ;; buffer
              [:<leader>br
               (lcmd "require('harpoon.mark').add_file()")
               (d "register buffer (harpoon)")]
              ;; toggle
              [:<leader>tc (cmd :ColorizerToggle) (d "toggle colorize")]
              [:<leader>tb (cmd :NvimTreeToggle)]
              [:<leader>tB (cmd "Neotree toggle")]
              [:<leader>to (cmd :SidebarNvimToggle)]
              [:<leader>tm
               (lcmd "require('codewindow').toggle_minimap()")
               (d "toggle minimap")]
              [:<leader>tr
               (lcmd "require('harpoon.ui').toggle_quick_menu()")
               (d "toggle registered buffer menu")]
              [:<leader>tg (cmd :TigTermToggle) (d "toggle tig terminal")]
              ;; finder
              [:<leader>ff
               (cmd "Telescope live_grep_args")
               (d "search by content")]
              [:<leader>fp
               (cmd "Ddu -name=fd file_fd")
               (d "search by file name")]
              [:<leader>fP
               (cmd "Ddu -name=ghq ghq")
               (d "search repo (ghq)")]
              [:<leader>fb (cmd "Telescope buffers") (d "search buffer")]
              [:<leader>fh (cmd :Legendary) (d "search legendary")]
              [:<leader>ft
               (cmd "Telescope sonictemplate templates")
               (d "search templates")]
              [:<leader>fru
               (cmd "Ddu -name=mru mru")
               (d "MRU (Most Recently Used files)")]
              [:<leader>frw
               (cmd "Ddu -name=mrw mrw")
               (d "MRW (Most Recently Written files)")]
              [:<leader>frr
               (cmd "Ddu -name=mrr mrr")
               (d "MRR (Most Recent git Repositories)")]
              [:<leader>fF
               (lcmd "require('spectre').open()")
               (d "find and replace with dark power")]] ;;
      ;;
      ]
  (do
    (each [_ keymap (ipairs ns)]
      (m :n (. keymap 1) (. keymap 2) (or (. keymap 3) os)))
    (for [i 0 9]
      (m [:n :t :i] (.. :<C- i ">") (cmd (.. "TermToggle " i))
           (d (.. "toggle terminal " i))))
    ;; reacher
    (m [:n :x] :gs (lcmd "require('reacher').start()")
         (d "search displayed"))
    (m [:n :x] :gS (lcmd "require('reacher').start_multiple()")
         (d "search displayed"))))
