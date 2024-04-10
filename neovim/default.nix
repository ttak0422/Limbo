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

    in {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = import ./overlays.nix inputs;
      };

      loaded-nvim = {
        package = pkgs.neovim-v9;
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
        inherit (callPackage ./neovim-ci.nix { }) ci-nightly-latest;
        inherit (callPackage ./neovim-test.nix { })
          test-v9 skkeleton skkeleton-lazy skkeleton-with-ddc;
        inherit (callPackage ./neovim-full.nix {
          inherit (self.packages.${system}) loaded-nvim;
        })
          stable nightly;
      };
    };
}
