{ pkgs, loaded-nvim }:
let
  inherit (builtins) readFile;
  inherit (pkgs) callPackage;
  plugins = callPackage ./plugins.nix { };
  groups = callPackage ./groups.nix { };
  ftplugins = callPackage ./ftplugins.nix { };
  extraConfig = "${readFile ./vim/prelude.vim}";
  extraLuaConfig = ''
    dofile("${./lua/prelude.lua}")
    dofile("${./lua/keymap.lua}")
    vim.cmd([[source ${./vim/keymap.vim}]])
    if vim.g.neovide then
      dofile("${./lua/neovide.lua}")
    end
  '';

  stable = {
    inherit extraConfig extraLuaConfig;
    package = loaded-nvim;
    eagerPlugins = with plugins; [
      config-local
      kanagawa
      # btw
    ];
    lazyPlugins = with plugins; [
      direnv
      ambiwidth
      asterisk
      auto-indent
      better-escape
      bqf
      bufdel
      codewindow
      colorizer
      comment
      context-vt
      dd
      detour
      devicons
      diffview
      # dropbar
      femaco
      flit
      flow
      # flutter-tools
      fundo
      gin
      gina
      git-conflict
      git-signs
      glance
      goto-preview
      harpoon
      haskell-tools
      heirline
      history-ignore
      hlchunk
      hlslens
      indent-o-matic
      # ionide
      jabs
      jdtls
      # jukit
      leap
      legendary
      markdown-preview
      marks
      mkdir
      mkdnflow
      nap
      neogen
      # neotree
      neozoom
      nfnl
      noice
      # none-ls
      notify
      numb
      # nvim-tree
      nvim-window
      open
      overseer
      project
      qf
      qfheight
      reacher
      registers
      # rust-tools
      sqlite
      smart-splits
      spectre
      startuptime
      statuscol
      tabout
      tint
      todo-comments
      toggleterm
      toolwindow
      translate
      treesj
      trim
      trouble
      ts-autotag
      tshjkl
      ufo
      vim-markdown
      vim-nix
      vimdoc-ja
      vtsls
      waitevent
      which-key
      window-picker
      # winsep
      winshift
      hydra
      stickybuf
      rustaceanvim
      dotfyle
      lastplace
      # indent-blankline
      global-note
      denops
      qfreplace
      undotree
      venn
      neogit
      scope
      octo
      skk
      go
      img-clip-nvim
    ];
    lazyGroups = with groups; [
      bufferHook
      cmdlineHook
      dap
      ddc
      ddu
      editHook
      fzf
      lir
      lsp
      neotest
      oil
      telescope
      treesitter
    ];
    after.ftplugin = with ftplugins; {
      inherit ddu-ff ddu-ff-filter qf gina-blame rust java haskell lhaskell
        cabal cabalproject;
    };
  };
  nightly = stable // { package = pkgs.neovim-nightly; };
in { inherit stable nightly; }
