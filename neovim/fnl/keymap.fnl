(set vim.g.mapleader " ")
(set vim.g.maplocalleader ",")

(let [os {:noremap true :silent true}
      d (fn [d] {:noremap true :silent true :desc d})
      m vim.keymap.set
      c (fn [c] (.. :<cmd> c :<cr>))
      lc (fn [c] (c (.. "lua " c)))
      ns [;; utils
              [:q :<nop>]
              [:<esc><esc> (c :nohl)]
              [:j :gj]
              [:k :gk]
              ;; split/join
              [:<leader>m
               (lc "require('treesj').toggle()")
               (d "toggle split/join")]
              [:<leader>M
               (lc "require('treesj').toggle({ split = { recursive = true } })")
               (d "toggle split/join rec")]
              [:gpd
               (lc "require('goto-preview').goto_preview_definition()")
               (d "preview definition")]
              [:gpi
               (lc "require('goto-preview').goto_preview_implementation()")
               (d "preview implementation")]
              [:gpr
               (lc "require('goto-preview').goto_preview_references()")
               (d "preview references")]
              [:gP
               (lc "require('goto-preview').close_all_win()")
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
               (c "execute printf('Gina blame --width=%d', &columns / 3)")
               (d "git blame")]
              [:<leader>gs (c :GinStatus) (d "git status")]
              [:<leader>gl (c :GinLog) (d "git log")]
              ; [:<leader>G (cmd :Neogit) (desc "magit for vim")]
              ;; tools
              [:<leader>q (c :BufDel)]
              [:<leader>Q (c :BufDel!)]
              [:<leader>A (c :tabclose)]
              [:<leader>E (c :FeMco) (d "edit code block")]
              ;; buffer
              [:<leader>br
               (lc "require('harpoon.mark').add_file()")
               (d "register buffer (harpoon)")]
              ;; toggle
              [:<leader>tc (c :ColorizerToggle) (d "toggle colorize")]
              [:<leader>tb (c :NvimTreeToggle)]
              [:<leader>tB (c "Neotree toggle")]
              [:<leader>to (c :SidebarNvimToggle)]
              [:<leader>tm
               (lc "require('codewindow').toggle_minimap()")
               (d "toggle minimap")]
              [:<leader>tr
               (lc "require('harpoon.ui').toggle_quick_menu()")
               (d "toggle registered buffer menu")]
              [:<leader>tg (c :TigTermToggle) (d "toggle tig terminal")]
              ;; finder
              [:<leader>ff
               (c "Telescope live_grep_args")
               (d "search by content")]
              [:<leader>fp
               (c "Ddu -name=fd file_fd")
               (d "search by file name")]
              [:<leader>fP
               (c "Ddu -name=ghq ghq")
               (d "search repo (ghq)")]
              [:<leader>fb (c "Telescope buffers") (d "search buffer")]
              [:<leader>fh (c :Legendary) (d "search legendary")]
              [:<leader>ft
               (c "Telescope sonictemplate templates")
               (d "search templates")]
              [:<leader>fru
               (c "Ddu -name=mru mru")
               (d "MRU (Most Recently Used files)")]
              [:<leader>frw
               (c "Ddu -name=mrw mrw")
               (d "MRW (Most Recently Written files)")]
              [:<leader>frr
               (c "Ddu -name=mrr mrr")
               (d "MRR (Most Recent git Repositories)")]
              [:<leader>fF
               (lc "require('spectre').open()")
               (d "find and replace with dark power")]] ;;
      ;;
      ]
  (do
    (each [_ keymap (ipairs ns)]
      (m :n (. keymap 1) (. keymap 2) (or (. keymap 3) os)))
    (for [i 0 9]
      (m [:n :t :i] (.. :<C- i ">") (c (.. "TermToggle " i))
           (d (.. "toggle terminal " i))))
    ;; reacher
    (m [:n :x] :gs (lc "require('reacher').start()")
         (d "search displayed"))
    (m [:n :x] :gS (lc "require('reacher').start_multiple()")
         (d "search displayed"))))
