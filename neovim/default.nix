{ self, inputs, system, ... }: {
  imports =
    [ inputs.bundler.flakeModules.neovim inputs.loaded-nvim.flakeModule ];
  perSystem = { inputs', system, config, pkgs, lib, ... }:
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

      loaded-nvim = {
        package = pkgs.neovim-nightly;
        # did_load_ftplugin = true;
        # did_indent_on = true;
        did_install_default_menus = true;
        skip_loading_mswin = true;
        loaded_gzip = true;
        loaded_man = true;
        loaded_matchit = true;
        loaded_matchparen = true;
        loaded_netrwPlugin = true;
        loaded_remote_plugins = true;
        loaded_shada_plugin = true;
        loaded_spellfile_plugin = true;
        loaded_tarPlugin = true;
        loaded_2html_plugin = true;
        loaded_tutor_mode_plugin = true;
        loaded_zipPlugin = true;
      };

      bundler-nvim = {
        inherit (callPackage ./neovim-ci.nix {}) ci-nightly-latest;
        default = {
          inherit extraConfig extraLuaConfig;
          # logLevel = "debug";
          # package = pkgs.neovim-nightly;
          package = self.packages.${system}.loaded-nvim;
          eagerPlugins = with plugins; [ config-local kanagawa ];
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
            # hlchunk
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
            # noice
            # none-ls
            notify
            numb
            nvim-tree
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
            dotfyle
            lastplace
            indent-blankline
            global-note
          ];
          lazyGroups = with groups; [
            oil
            dap
            ddc
            ddu
            fzf
            lsp
            neotest
            skk
            telescope
            treesitter
            cmdlineHook
            bufferHook
            editHook
          ];
          after.ftplugin = with ftplugins; {
            inherit ddu-ff ddu-ff-filter qf gina-blame rust;
          };
        };
      };
    };
}
