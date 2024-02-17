{ inputs, ... }: {
  imports = [ inputs.bundler.flakeModules.neovim ];
  perSystem = { system, config, pkgs, lib, ... }:
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

    in
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = import ./overlays.nix inputs;
      };

      bundler-nvim = {
        default = {
          inherit extraConfig extraLuaConfig;
          # logLevel = "debug";
          package = pkgs.neovim-nightly;
          eagerPlugins = with plugins; [
            config-local
            direnv
            kanagawa
          ];
          lazyPlugins = with plugins; [
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
            copilot
            # dap-go
            dd
            detour
            devicons
            diffview
            dropbar
            early-retirement
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
            # haskell-tools
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
            none-ls
            notify
            numb
            nvim-tree
            nvim-window
            open
            overseer
            project
            qf
            qfheight
            pqf
            reacher
            registers
            # rust-tools
            sqlite
            smart-splits
            spectre
            startuptime
            statuscol
            surround
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
            winsep
            winshift
            hydra
            stickybuf
            rustaceanvim
          ];
          lazyGroups = with groups; [
            dap
            ddc
            ddu
            fzf
            lsp
            neotest
            skk
            telescope
            treesitter
          ];
          after.ftplugin = with ftplugins; {
            inherit ddu-ff ddu-ff-filter qf gina-blame;
          };
        };
      };
    };
}
