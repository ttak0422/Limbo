{ pkgs }:
let
  inherit (builtins) readFile;
  startup = with pkgs.vimPlugins; {
    btw = {
      plugin = btw-nvim;
      startupConfig = {
        language = "lua";
        code = readFile ./lua/btw.lua;
      };
    };
    kanagawa = {
      plugin = kanagawa-nvim;
      startupConfig = {
        language = "lua";
        code = readFile ./lua/kanagawa.lua;
      };
    };
    config-local = {
      plugin = nvim-config-local;
      startupConfig = {
        language = "lua";
        code = readFile ./lua/config-local.lua;
      };
    };
  };
  lsp = with pkgs.vimPlugins; {
    rustaceanvim = {
      plugin = rustaceanvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/rustaceanvim.lua;
        args = { on_attach_path = ./lua/on_attach.lua; };
      };
      extraPackages = with pkgs; [ graphviz ];
      dependPlugins = [ toggleterm-nvim ];
      dependGroups = [ "lsp" ];
      # loaded by ftplugin
      # onFiletypes = [ "rust" ];
      onModules = [ "rustaceanvim" ];
    };
    haskell-tools = {
      # Supercharge your Haskell experience in neovim!
      plugin = haskell-tools-nvim;
      dependPlugins = [ plenary-nvim ];
      dependGroups = [ "lsp" ];
      extraPackages = with pkgs; [
        ghc
        haskellPackages.fourmolu
        haskellPackages.haskell-language-server
      ];
      postConfig = {
        language = "lua";
        code = readFile ./lua/haskell-tools.lua;
        args = {
          on_attach_path = ./lua/on_attach.lua;
          capabilities_path = ./lua/capabilities.lua;
        };
      };
      onModules = [ "haskell-tools" ];
    };
    trouble = {
      # A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.
      plugin = trouble-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/trouble.lua;
      };
      dependGroups = [ "lsp" ];
      onModules = [ "trouble" ];
      onCommands = [ "TroubleToggle" ];
    };
    null-ls = {
      plugin = none-ls-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/null-ls.lua;
      };
      dependPlugins = [ plenary-nvim ];
      extraPackages = with pkgs; [
        # for go #
        gofumpt
        go-tools
        # ------ #
      ];
      useTimer = true;
    };
    # DEPRICATED:
    # todo add cspell
    none-ls = {
      plugin = none-ls-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/none-ls.lua;
      };
      dependPlugins = [ plenary-nvim ];
      extraPackages = with pkgs; [
        nodePackages.eslint
        nodePackages.cspell
        # TODO: add rules
        nodePackages.textlint
        # formatter
        google-java-format
        html-tidy
        nixfmt-rfc-style
        nodePackages.fixjson
        nodePackages.prettier
        rustfmt
        shfmt
        stylua
        taplo
        yamlfmt
        yapf
        dhall
        fnlfmt
      ];
      useTimer = true;
    };
  };
  filetype = with pkgs.vimPlugins; {
    jdtls = {
      # Extensions for the built-in LSP support in Neovim for eclipse.jdt.ls
      plugin = nvim-jdtls;
      dependPlugins = [ ];
      dependGroups = [ "lsp" "dap" ];
      onModules = [ "jdtls" ];
    };
    gopher = {
      plugin = gopher-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/gopher.lua;
      };
      extraPackages = with pkgs; [ gomodifytags impl gotests iferr delve ];
      dependPlugins = [ plenary-nvim ];
      dependGroups = [ "lsp" "dap" "treesitter" ];
      onFiletypes = [ "go" "gomod" ];
    };
    go = {
      plugin = go-nvim;
      extraPackages = with pkgs; [
        gofumpt
        golines
        golangci-lint
        gotools # goimports gorename callgraph guru staticcheck
        gomodifytags
        gopls
        gotests
        iferr
        impl
        reftools # fillstruct fillswitch
        delve # dlv
        ginkgo
        richgo
        gotestsum
        mockgen
        govulncheck
      ];
      postConfig = {
        language = "lua";
        code = readFile ./lua/go.lua;
        args = {
          on_attach_path = ./lua/on_attach.lua;
          capabilities_path = ./lua/capabilities.lua;
        };
      };
      dependPlugins = [ none-ls-nvim ];
      dependGroups = [ "lsp" "dap" "treesitter" ];
      onFiletypes = [ "go" "gomod" ];
    };
    vtsls = {
      # Plugin to help utilize capabilities of vtsls.
      plugin = nvim-vtsls;
      postConfig = {
        language = "lua";
        code = readFile ./lua/vtsls.lua;
      };
      dependGroups = [ "lsp" ];
      onFiletypes = [ "typescript" "javascript" ];
    };
    flutter-tools = {
      # Tools to help create flutter apps in neovim using the native lsp
      plugin = flutter-tools-nvim;
      dependPlugins = [ plenary-nvim dressing-nvim ];
      dependGroups = [ "lsp" ];
      postConfig = {
        language = "lua";
        code = readFile ./lua/flutter-tools.lua;
      };
      onFiletypes = [ "dart" ];
    };
    # WIP...
    rust-tools = {
      plugin = rust-tools-nvim;
      dependPlugins = [ plenary-nvim toggleterm-nvim ];
      dependGroups = [ "lsp" "dap" ];
      postConfig = {
        language = "lua";
        code = readFile ./lua/rust-tools.lua;
        args = {
          on_attach_path = ./lua/on_attach.lua;
          capabilities_path = ./lua/capabilities.lua;
        };
      };
      onFiletypes = [ "rust" ];
    };
    ionide = {
      # FSharp
      # [WIP] dotnet
      # dotnet tool install -g fsautocomplete
      # dotnet tool install -g dotnet-fsharplint
      # dotnet tool install --global fantomas-tool
      plugin = Ionide-vim;
      dependGroups = [ "lsp" ];
      preConfig = {
        language = "lua";
        code = readFile ./lua/ionide-pre.lua;
      };
      postConfig = {
        language = "lua";
        code = readFile ./lua/ionide.lua;
        args = {
          on_attach_path = ./lua/on_attach.lua;
          capabilities_path = ./lua/capabilities.lua;
        };
      };
      onFiletypes = [ "fsharp" ];
    };
    mkdnflow = {
      plugin = mkdnflow-nvim;
      dependPlugins = [ plenary-nvim ];
      onFiletypes = [ "markdown" ];
      postConfig = {
        language = "lua";
        code = readFile ./lua/mkdnflow.lua;
      };
    };
    # paredit = {
    #   plugin = nvim-paredit-fennel;
    #   onFiletypes = [ "fennel" ];
    #   dependPlugins = [ nvim-paredit ];
    #   postConfig = readFile ./../../../nvim/lua/paredit-fennel.lua;
    # };
    # paredit-fennel = {
    #   # A fennel language extension for nvim-paredit
    #   plugin = nvim-paredit-fennel;
    #   onFiletypes = [ "fennel" ];
    #   dependPlugins = [ nvim-paredit ];
    #   postConfig = readFile ./../../../nvim/lua/paredit-fennel.lua;
    # };
    # conjure = {
    #   # Interactive evaluation for Neovim (Clojure, Fennel, Janet, Racket, Hy, MIT Scheme, Guile, Python and more!)
    #   plugin = conjure;
    #   prpostConfig = readFile ./../../../nvim/lua/conjure-pre.lua;
    #   postConfig = readFile ./../../../nvim/lua/conjure.lua;
    #   dependPlugins = [{ plugin = aniseed; }];
    #   dependGroups = [ "treesitter" ];
    #   onFiletypes = [ "clojure" "fennel" "scheme" ];
    # };
    qf = {
      # Extends the default quickfix and location lists for neovim
      plugin = qf-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/qf.lua;
      };
      onFiletypes = [ "qf" ];
      onCommands = [ "Qnext" "Qprev" "Lnext" "Lprev" ];
    };
    ts-autotag = {
      # Use treesitter to auto close and auto rename html tag
      plugin = nvim-ts-autotag;
      dependGroups = [ "treesitter" ];
      postConfig = {
        language = "lua";
        code = readFile ./lua/ts-autotag.lua;
      };
      onFiletypes = [ "javascript" "typescript" "jsx" "tsx" "vue" "html" ];
    };
    vim-nix = {
      plugin = vim-nix;
      onFiletypes = [ "nix" ];
    };
    vim-markdown = {
      plugin = vim-markdown;
      preConfig = {
        language = "lua";
        code = readFile ./lua/vim-markdown-pre.lua;
      };
      onFiletypes = [ "markdown" ];
    };
    nfnl = with pkgs.vimPlugins; {
      plugin = nfnl;
      onFiletypes = [ "fennel" ];
      extraPackages = with pkgs; [ sd fd ];
    };
  };
  git = with pkgs.vimPlugins; {
    octo = {
      plugin = octo-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/octo.lua;
      };
      dependPlugins = [ plenary-nvim nvim-web-devicons ];
      dependGroups = [ "telescope" ];
      onCommands = [ "Octo" ];
    };
    neogit = {
      plugin = neogit;
      postConfig = {
        language = "lua";
        code = readFile ./lua/neogit.lua;
      };
      dependPlugins = [ plenary-nvim diffview-nvim ];
      dependGroups = [ "telescope" ];
      onCommands = [ "Neogit" ];
      extraPackages = with pkgs; [ gh ];
    };
    git-conflict = {
      plugin = git-conflict-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/git-conflict.lua;
      };
      useTimer = true;
    };
    git-signs = {
      plugin = gitsigns-nvim;
      dependPlugins = [ plenary-nvim ];
      postConfig = {
        language = "lua";
        code = ''
          require("morimo").load("gitsigns")
        '' + readFile ./lua/gitsigns.lua;
      };
      onEvents = [ "CursorMoved" ];
    };
    gina = {
      plugin = gina-vim;
      postConfig = {
        language = "vim";
        code = readFile ./vim/gina.vim;
      };
      onCommands = [ "Gina" ];
    };
    gin = {
      plugin = gin-vim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/gin.lua;
      };
      dependPlugins = [ denops-vim ];
      onCommands = [
        "Gin"
        "GinBuffer"
        "GinLog"
        "GinStatus"
        "GinDiff"
        "GinBrowse"
        "GinBranch"
      ];
      useDenops = true;
    };
    diffview = {
      plugin = diffview-nvim;
      dependPlugins = [ nvim-web-devicons ];
      onCommands = [ "DiffviewOpen" "DiffviewToggleFiles" ];
    };
  };
  dap = with pkgs.vimPlugins; {
    dap-go = {
      # An extension for nvim-dap providing configurations for launching go debugger (delve) and debugging individual tests
      plugin = nvim-dap-go;
      postConfig = {
        language = "lua";
        code = readFile ./lua/dap-go.lua;
      };
      dependGroups = [ "dap" ];
      onFiletypes = [ "go" ];
      extraPackages = with pkgs; [ delve ];
    };
  };
  style = with pkgs.vimPlugins; {
    morimo = {
      plugin = morimo;
      startupConfig = ''
        colorscheme morimo
      '';
    };
    bufferline = {
      plugin = bufferline-nvim;
      dependPlugins = [ scope-nvim ];
      postConfig = {
        language = "lua";
        code = readFile ./lua/bufferline.lua;
      };
      useTimer = true;
    };
    numb = {
      # Peek lines just when you intend
      plugin = numb-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/numb.lua;
      };
      onEvents = [ "CmdlineEnter" ];
    };
    indent-blankline = {
      plugin = indent-blankline-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/indent-blankline.lua;
      };
      dependPlugins = [ rainbow-delimiters-nvim ];
    };
    hlchunk = {
      # This is the lua implementation of nvim-hlchunk, you can use this neovim plugin to highlight your indent line and the current chunk (context) your cursor stayed
      plugin = hlchunk-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/hlchunk.lua;
      };
      dependGroups = [ "treesitter" ];
      onEvents = [ "CursorMoved" ];
    };
    ufo = {
      # Not UFO in the sky, but an ultra fold in Neovim.
      plugin = nvim-ufo;
      dependPlugins = [ promise-async statuscol-nvim indent-blankline-nvim ];
      dependGroups = [ "treesitter" ];
      postConfig = {
        language = "lua";
        code = readFile ./lua/ufo.lua;
      };
      useTimer = true;
    };
    statuscol = {
      # Status column plugin that provides a configurable 'statuscolumn' and click handlers.
      plugin = statuscol-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/statuscol.lua;
      };
      useTimer = true;
    };
    bqf = {
      # Better quickfix window in Neovim, polish old quickfix window.
      plugin = nvim-bqf;
      postConfig = {
        language = "lua";
        code = readFile ./lua/bqf.lua;
      };
      onModules = [ "bqf" ];
      # loaded by ftplugin
      # onEvents = [ "QuickFixCmdPre" ];
      dependGroups = [ "fzf" "treesitter" ];
      dependPlugins = [{
        plugin = nvim-pqf;
        postConfig = {
          language = "lua";
          code = readFile ./lua/pqf.lua;
        };
        # onEvents = [ "QuickFixCmdPre" ];
      }];
      extraPackages = with pkgs; [ fzf ];
    };
    qfview = {
      # Pretty quickfix/location view for Neovim
      plugin = qfview-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/qfview.lua;
      };
      onEvents = [ "QuickFixCmdPre" ];
      useTimer = true;
    };
    noice = {
      plugin = noice-nvim;
      dependPlugins = [ nui-nvim nvim-notify ];
      dependGroups = [ "treesitter" ];
      postConfig = {
        language = "lua";
        code = readFile ./lua/noice.lua;
        args = { exclude_ft_path = ./lua/exclude_ft.lua; };
      };
      useTimer = true;
    };
    context-vt = {
      # Virtual text context for neovim treesitter
      plugin = nvim_context_vt;
      dependGroups = [ "treesitter" ];
      postConfig = {
        language = "lua";
        code = readFile ./lua/context-vt.lua;
      };
      useTimer = true;
    };
    glance = {
      plugin = glance-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/glance.lua;
      };
      onCommands = [ "Glance" ];
    };
    heirline = {
      plugin = heirline-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/heirline.lua;
      };
      dependPlugins = [
        plenary-nvim
        nvim-web-devicons
        {
          plugin = lsp-progress-nvim;
          postConfig = {
            language = "lua";
            code = readFile ./lua/lsp-progress.lua;
          };
        }
        {
          plugin = harpoonline;
          postConfig = {
            language = "lua";
            code = readFile ./lua/harpoonline.lua;
          };
          dependPlugins = [ harpoon-2 ];
        }
        # {
        #   plugin = piccolo-pomodoro-nvim;
        #   postConfig = {
        #     language = "lua";
        #     code = readFile ./lua/piccolo-pomodoro.lua;
        #   };
        #   onModules = [ "piccolo-pomodoro" ];
        # }
        hydra-nvim
        scope-nvim
      ];
      useTimer = true;
    };
    satellite = {
      plugin = satellite-nvim;
      dependPlugins = [ gitsigns-nvim ];
      postConfig = {
        language = "lua";
        code = readFile ./lua/satellite.lua;
        args = { exclude_ft_path = ./lua/exclude_ft.lua; };
      };
      onEvents = [ "CursorMoved" ];
    };
    winsep = {
      plugin = colorful-winsep-nvim;
      onEvents = [ "WinNew" ];
      postConfig = {
        language = "lua";
        code = readFile ./lua/winsep.lua;
        args = { exclude_ft_path = ./lua/exclude_ft.lua; };
      };
    };
    dropbar = {
      plugin = dropbar-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/dropbar.lua;
      };
      dependPlugins = [ nvim-web-devicons ];
      dependGroups = [ "telescope" "treesitter" ];
      onModules = [ "dropbar.api" ];
      useTimer = true;
    };
    notify = {
      plugin = nvim-notify;
      postConfig = {
        language = "lua";
        code = readFile ./lua/notify.lua;
      };
      useTimer = true;
    };
    tint = {
      plugin = tint-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/tint.lua;
      };
      onEvents = [ "WinNew" ];
    };
    devicons = {
      plugin = nvim-web-devicons;
      postConfig = {
        language = "lua";
        code = readFile ./lua/devicons.lua;
      };
    };
    registers = {
      plugin = registers-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/registers.lua;
      };
      onEvents = [ "CursorMoved" ];
    };
    codewindow = {
      plugin = codewindow-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/codewindow.lua;
        args = { exclude_ft_path = ./lua/exclude_ft.lua; };

      };
      dependGroups = [ "treesitter" ];
      # onEvents = [ "CursorHold" ];
      onModules = [ "codewindow" ];
    };
  };
  override = with pkgs.vimPlugins; {
    hydra = {
      plugin = hydra-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/hydra.lua;
      };
      onEvents = [ "CmdlineEnter" "CursorMoved" ];
    };
    hlslens = {
      plugin = nvim-hlslens;
      postConfig = {
        language = "lua";
        code = readFile ./lua/hlslens.lua;
      };
      onEvents = [ "CmdlineEnter" ];
    };
    asterisk = {
      # *-Improved
      plugin = vim-asterisk;
      postConfig = {
        language = "vim";
        code = readFile ./vim/asterisk.vim;
      };
      onEvents = [ "CursorMoved" ];
    };
    mkdir = {
      # This neovim plugin creates missing folders on save.
      plugin = mkdir-nvim;
      onEvents = [ "CmdlineEnter" ];
    };
    indent-o-matic = {
      # Dumb automatic fast indentation detection for Neovim written in Lua
      plugin = indent-o-matic;
      postConfig = {
        language = "lua";
        code = readFile ./lua/indent-o-matic.lua;
      };
      onEvents = [ "CursorMoved" ];
    };
    toolwindow = {
      # Easy management of a toolwindow.
      plugin = toolwindow-nvim;
      onModules = [ "toolwindow" ];
    };
    open = {
      # Open the current word with custom openers, GitHub shorthands for example.
      plugin = open-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/open.lua;
      };
      onModules = [ "open" ];
    };
    fundo = {
      # Forever undo in Neovim
      plugin = nvim-fundo;
      dependPlugins = [ promise-async ];
      postConfig = {
        language = "lua";
        code = readFile ./lua/fundo.lua;
      };
      useTimer = true;
    };
    waitevent = {
      # Neovim plugin to avoid nested nvim
      plugin = waitevent-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/waitevent.lua;
      };
      useTimer = true;
    };
    ambiwidth = {
      # This plugin provides a set of setcellwidths() for Vim that the ambiwidth is single.
      plugin = vim-ambiwidth;
      useTimer = true;
    };
    scope = {
      plugin = scope-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/scope.lua;
      };
    };
    smart-splits = {
      # Smart, seamless, directional navigation and resizing of Neovim
      plugin = smart-splits-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/smart-splits.lua;
      };
      dependPlugins = [{
        plugin = bufresize-nvim;
        postConfig = {
          language = "lua";
          code = readFile ./lua/bufresize.lua;
        };
      }];
      onModules = [ "smart-splits" ];
      onEvents = [ "WinNew" ];
    };
    tabout = {
      # tabout plugin for neovim
      plugin = tabout-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/tabout.lua;
      };
      dependGroups = [ "treesitter" ];
      onEvents = [ "InsertEnter" ];
    };
    marks = {
      # A better user experience for viewing and interacting with Vim marks.
      plugin = marks-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/marks.lua;
      };
      onCommands = [ "MarksQFListBuf" "MarksQFListGlobal" ];
      onEvents = [ "CursorMoved" ];
    };
  };
  helper = with pkgs.vimPlugins; {
    autopairs = {
      plugin = nvim-autopairs;
      dependGroups = [ "treesitter" ];
      postConfig = {
        language = "lua";
        code = readFile ./lua/autopairs.lua;
      };
      onEvents = [ "InsertEnter" ];
    };
    img-clip-nvim = {
      plugin = img-clip-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/img-clip.lua;
      };
      onFiletypes = [ "markdown" ];
    };
    lastplace = {
      plugin = nvim-lastplace;
      preConfig = {
        language = "lua";
        code = readFile ./lua/lastplace-pre.lua;
        args = {
          exclude_ft_path = ./lua/exclude_ft.lua;
          exclude_buf_ft_path = ./lua/exclude_buf_ft.lua;
        };
      };
      onCommands = [ "BufNew" "BufAdd" ];
    };
    direnv = {
      plugin = direnv-vim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/direnv.lua;
      };
      onEvents = [ "DirChangedPre" ];
    };
    stickybuf = {
      plugin = stickybuf-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/stickybuf.lua;
      };
    };
    early-retirement = {
      plugin = nvim-early-retirement;
      postConfig = {
        language = "lua";
        code = readFile ./lua/early-retirement.lua;
      };
      useTimer = true;
    };
    safe-close-window = {
      plugin = safe-close-window-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/safe-close-window.lua;
      };
      onCommands = [ "SafeCloseWindow" ];
    };
    dd = {
      # Deferring of NeoVim diagnostics
      plugin = nvim-dd;
      postConfig = {
        language = "lua";
        code = readFile ./lua/dd.lua;
      };
      onEvents = [ "InsertEnter" ];
    };
    trim = {
      # This plugin trims trailing whitespace and lines.
      plugin = trim-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/trim.lua;
      };
      onEvents = [ "BufWritePre" ];
    };
    project = {
      # The superior project management solution for neovim.
      plugin = project-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/project.lua;
      };
      useTimer = true;
    };
    qfheight = {
      plugin = qfheight-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/qfheight.lua;
      };
      onFiletypes = [ "qf" ];
      onEvents = [ "QuickFixCmdPre" ];
    };
    history-ignore = {
      # Configure commands not to be registered in the command-line history
      plugin = history-ignore-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/history-ignore.lua;
      };
      onEvents = [ "CmdlineEnter" ];
    };
    auto-indent = {
      # Auto indent like VSCode when cursor at the first column and press <TAB> key
      plugin = auto-indent-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/auto-indent.lua;
      };
      dependGroups = [ "treesitter" ];
    };
  };
  tool = with pkgs.vimPlugins; {
    venn = {
      plugin = venn-nvim;
      onCommands = [ "VBox" ];
    };
    undotree = {
      plugin = undotree;
      onCommands = [ "UndotreeToggle" ];
      preConfig = readFile ./vim/undotree-pre.vim;
    };
    qfreplace = {
      plugin = vim-qfreplace;
      onCommands = [ "Qfreplace" ];
    };
    global-note = {
      plugin = global-note-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/global-note.lua;
      };
      onCommands = [ "GlobalNote" "ProjectNote" ];
    };
    dotfyle = {
      plugin = dotfyle-metadata-nvim;
      onCommands = [ "DotfyleGenerate" ];
    };
    sqlite = {
      plugin = sqlite-lua;
      preConfig = ''
        if has('mac')
          let g:sqlite_clib_path = '${pkgs.sqlite.out}/lib/libsqlite3.dylib'
        else
          let g:sqlite_clib_path = '${pkgs.sqlite.out}/lib/libsqlite3.so'
        endif
      '';
    };
    markdown-preview = {
      plugin = markdown-preview-nvim;
      onFiletypes = [ "markdown" ];
    };
    translate = {
      # Translate languages
      plugin = denops-translate-vim;
      preConfig = {
        language = "lua";
        code = readFile ./lua/denops-translate-pre.lua;
      };
      dependPlugins = [ denops-vim ];
      useDenops = true;
      onCommands = [ "Translate" ];
    };
    toggleterm = {
      # A neovim lua plugin to help easily manage multiple terminal windows
      plugin = toggleterm-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/toggleterm.lua;
      };
      dependPlugins = [ term-gf-nvim ];
      onCommands = [ "ToggleTerm" "TermToggle" ];
    };
    vimdoc-ja = {
      # A project which translate Vim documents into Japanese.
      plugin = vimdoc-ja;
      onEvents = [ "CmdlineEnter" ];
    };
    legendary = {
      # A legend for your keymaps, commands, and autocmds, integrates with which-key.nvim, lazy.nvim, and more.
      plugin = legendary-nvim;
      dependGroups = [ "telescope" ];
      postConfig = {
        language = "lua";
        code = readFile ./lua/legendary.lua;
      };
      dependPlugins = [ sqlite-lua ];
      onCommands = [ "Legendary" ];
    };
    window-picker = {
      plugin = nvim-window-picker;
      postConfig = {
        language = "lua";
        code = readFile ./lua/window-picker.lua;
        args = {
          exclude_ft_path = ./lua/exclude_ft.lua;
          exclude_buf_ft_path = ./lua/exclude_buf_ft.lua;
        };
      };
      onModules = [ "window-picker" ];
    };
    nnn = {
      plugin = nnn-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/nnn.lua;
      };
      extraPackages = with pkgs; [ nnn ];
    };
    nvim-tree = {
      plugin = nvim-tree-lua;
      postConfig = {
        language = "lua";
        code = readFile ./lua/nvim-tree.lua;
      };
      dependPlugins = [ nvim-web-devicons dressing-nvim stickybuf-nvim ];
      onCommands = [ "NvimTreeFocus" "NvimTreeToggle" ];
    };
    neotree = {
      plugin = neotree-nvim-3;
      dependPlugins = [ plenary-nvim nvim-web-devicons nui-nvim ];
      postConfig = {
        language = "lua";
        code = readFile ./lua/neotree.lua;
      };
      onCommands = [ "Neotree" ];
    };
    bufdel = {
      plugin = nvim-bufdel;
      postConfig = {
        language = "lua";
        code = readFile ./lua/bufdel.lua;
      };
      onCommands = [ "BufDel" "BufDel!" "BufDelAll" "BufDelOthers" ];
    };
    neozoom = {
      # A simple usecase of floating window to help you focus.
      plugin = NeoZoom-lua;
      postConfig = {
        language = "lua";
        code = readFile ./lua/neozoom.lua;
      };
      onCommands = [ "NeoZoomToggle" ];
    };
    femaco = {
      # Catalyze your Fenced Markdown Code-block editing!
      plugin = nvim-FeMaco-lua;
      postConfig = {
        language = "lua";
        code = readFile ./lua/femaco.lua;
      };
      dependGroups = [ "treesitter" ];
      onCommands = [ "FeMaco" ];
    };
    winshift = {
      # Rearrange your windows with ease.
      plugin = winshift-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/winshift.lua;
      };
      onCommands = [ "WinShift" ];
    };
    jukit = {
      # Jupyter-Notebook inspired Neovim/Vim Plugin
      plugin = vim-jukit;
    };
    overseer = {
      # A task runner and job management plugin for Neovim
      plugin = overseer-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/overseer.lua;
      };
      dependPlugins = [ toggleterm-nvim ];
      onCommands = [ "OverseerRun" ];
    };
    colorizer = {
      # The fastest Neovim colorizer.
      plugin = nvim-colorizer-lua;
      postConfig = {
        language = "lua";
        code = readFile ./lua/colorizer.lua;
      };
      onCommands = [ "ColorizerToggle" ];
    };
    detour = {
      # Use popup windows to navigate files/buffer and to contain shells/TUIs
      plugin = detour-nvim;
      postConfig = {
        code = readFile ./lua/detour.lua;
        language = "lua";
      };
      onCommands = [ "Detour" "DetourCurrentWindow" ];
      onModules = [ "detour" ];
    };
    flow = {
      # A neovim plugin that lets you build custom commands to automate parts of your development workflow
      plugin = flow-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/flow.lua;
      };
      onCommands = [ "FlowRunSelected" "FlowRunFile" "FlowLauncher" ];
    };
    startuptime = {
      # vim-startup
      plugin = vim-startuptime;
      onCommands = [ "StartupTime" ];
    };
    harpoon = {
      plugin = harpoon-2;
      postConfig = {
        language = "lua";
        code = readFile ./lua/harpoon.lua;
      };
      dependPlugins = [ plenary-nvim ];
      onModules = [ "harpoon" ];
    };
    nvim-window = {
      # Easily jump between NeoVim windows.
      plugin = nvim-window;
      postConfig = {
        language = "lua";
        code = readFile ./lua/window.lua;
      };
      onModules = [ "nvim-window" ];
    };
    jabs = {
      # Just Another Buffer Switcher for Neovim
      plugin = JABS-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/jabs.lua;
      };
      onCommands = [ "JABSOpen" ];
    };
  };
  search = with pkgs.vimPlugins; {
    which-key = {
      # Create key bindings that stick. WhichKey is a lua plugin for Neovim 0.5 that displays a popup with possible keybindings of the command you started typing.
      plugin = which-key-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/whichkey.lua;
      };
      useTimer = true;
    };
    goto-preview = {
      # A small Neovim plugin for previewing definitions using floating windows.
      plugin = goto-preview;
      dependPlugins = [ tint-nvim ];
      postConfig = {
        language = "lua";
        code = readFile ./lua/goto-preview.lua;
      };
      onModules = [ "goto-preview" ];
    };
    spectre = {
      # Find the enemy and replace them with dark power.
      plugin = nvim-spectre;
      postConfig = {
        language = "lua";
        code = readFile ./lua/spectre.lua;
      };
      dependPlugins = [ plenary-nvim nvim-web-devicons ];
      extraPackages = with pkgs; [ gnused ripgrep ];
      onModules = [ "spectre" ];
    };
    kensaku = {
      plugin = kensaku-command-vim;
      dependPlugins = [{
        plugin = kensaku-vim;
        useDenops = true;
        dependPlugins = [ denops-vim ];
      }];
      onCommands = [ "Kensaku" ];
    };
    reacher = {
      # Displayed range search buffer
      plugin = reacher-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/reacher.lua;
      };
      onModules = [ "reacher" ];
    };
  };
  motion = with pkgs.vimPlugins; {
    better-escape = {
      # Escape from insert mode without delay when typing
      plugin = better-escape-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/better-escape.lua;
      };
      onEvents = [ "InsertEnter" ];
    };
    nap = {
      plugin = nap-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/nap.lua;
      };
      onEvents = [ "CursorMoved" ];
      dependPlugins = [{
        plugin = BufferBrowser;
        postConfig = {
          language = "lua";
          code = readFile ./lua/BufferBrowser.lua;
          args = { exclude_ft_path = ./lua/exclude_ft.lua; };
        };
      }];
      useTimer = true;
    };
    leap = {
      # Neovim's answer to the mouse
      plugin = leap-nvim;
      dependPlugins = [ vim-repeat ];
      postConfig = {
        language = "lua";
        code = readFile ./lua/leap.lua;
      };
      onEvents = [ "CursorMoved" ];
    };
    flit = {
      # Enhanced f/t motions for Leap
      plugin = flit-nvim;
      dependPlugins = [ leap-nvim ];
      postConfig = {
        language = "lua";
        code = readFile ./lua/flit.lua;
      };
      onEvents = [ "CursorMoved" ];
    };
  };

in with pkgs.vimPlugins;
{
  tshjkl = {
    # Tree-sitter hjkl movement for neovim
    plugin = tshjkl-nvim;
    postConfig = {
      language = "lua";
      code = readFile ./lua/tshjkl.lua;
    };
    onEvents = [ "CursorMoved" ];
  };
  comment = {
    # Smart and powerful comment plugin for neovim. Supports treesitter, dot repeat, left-right/up-down motions, hooks, and more
    plugin = Comment-nvim;
    postConfig = {
      language = "lua";
      code = readFile ./lua/comment.lua;
    };
    onEvents = [ "InsertEnter" "CursorMoved" ];
  };
  todo-comments = {
    # Highlight, list and search todo comments in your projects
    plugin = todo-comments-nvim;
    dependPlugins = [ plenary-nvim trouble-nvim ];
    postConfig = {
      language = "lua";
      code = readFile ./lua/todo-comments.lua;
    };
    onCommands = [ "TodoQuickFix" "TodoLocList" "TodoTrouble" "TodoTelescope" ];
    extraPackages = [ pkgs.ripgrep ];
    useTimer = true;
  };
  treesj = {
    # Neovim plugin for splitting/joining blocks of code
    plugin = treesj;
    postConfig = {
      language = "lua";
      code = readFile ./lua/treesj.lua;
    };
    onModules = [ "treesj" ];
  };
  neogen = {
    # A better annotation generator. Supports multiple languages and annotation conventions.
    plugin = neogen;
    dependPlugins = [ vim-vsnip ];
    dependGroups = [ "treesitter" ];
    postConfig = {
      language = "lua";
      code = readFile ./lua/neogen.lua;
    };
    onCommands = [ "Neogen" ];
  };
  denops = {
    plugin = denops-vim;
    preConfig = ''
      " use latest
      let g:denops#deno = '${pkgs.pkgs-unstable.deno}/bin/deno'
      let g:denops#server#deno_args = ['-q', '--no-lock', '-A', '--unstable-kv']
    '';
  };
  skk = {
    plugin = skkeleton;
    dependPlugins = [ denops-vim ];
    dependGroups = [
      # "ddc"
      # "ddu"
    ];
    useDenops = true;
    postConfig = {
      language = "vim";
      code = readFile ./vim/skk.vim;
      args = { jisyo = "${pkgs.skk-dicts}/share/SKK-JISYO.L"; };
    };
    onEvents = [ "InsertEnter" "CmdlineEnter" ];
  };
} // startup // lsp // dap // filetype // git // style // override // helper
// tool // search // motion
