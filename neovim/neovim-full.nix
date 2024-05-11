{ inputs, pkgs, loaded-nvim }:
let
  inherit (builtins) readFile;
  inherit (pkgs) callPackage;
  plugins = callPackage ./plugins.nix { };
  groups = callPackage ./groups.nix { inherit inputs; };
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
      # dropbar
      # flutter-tools
      # ionide
      autopairs
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
      denops
      detour
      devicons
      diffview
      direnv
      dotfyle
      femaco
      flit
      flow
      fundo
      gin
      gina
      git-conflict
      git-signs
      glance
      global-note
      gopher
      goto-preview
      harpoon
      haskell-tools
      heirline
      history-ignore
      hlchunk
      hlslens
      hydra
      img-clip-nvim
      indent-o-matic
      jabs
      jdtls
      lastplace
      leap
      legendary
      markdown-preview
      marks
      mkdir
      mkdnflow
      nap
      neogen
      neogit
      neozoom
      nfnl
      noice
      notify
      null-ls
      numb
      nvim-window
      octo
      open
      overseer
      project
      qf
      qfheight
      qfreplace
      reacher
      registers
      rustaceanvim
      scope
      skk
      smart-splits
      spectre
      sqlite
      startuptime
      statuscol
      stickybuf
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
      undotree
      venn
      vim-markdown
      vim-nix
      vimdoc-ja
      vtsls
      waitevent
      which-key
      window-picker
      # winsep
      winshift
    ];
    lazyGroups = with groups; [
      # ddc
      bufferHook
      cmdlineHook
      cmp
      dap
      ddu
      editHook
      fzf
      lir
      lsp
      neorg
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
