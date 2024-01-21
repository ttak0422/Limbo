{ inputs, ... }: {
  imports = [ inputs.bundler.flakeModules.neovim ];
  perSystem = { system, config, pkgs, lib, ... }:
    let
      inherit (builtins) readFile;
      inherit (pkgs) callPackage;
      plugins = callPackage ./plugins.nix { };
      groups = callPackage ./groups.nix { };
      after = { };
      extraConfig = "${readFile ./vim/prelude.vim}";
      extraLuaConfig = ''
        dofile("${./lua/prelude.lua}")
        dofile("${./lua/keymap.lua}")
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
          inherit extraConfig extraLuaConfig after;
          # logLevel = "debug";
          package = pkgs.neovim-nightly;
          eagerPlugins = with plugins; [
            config-local
            direnv
            hydra
            kanagawa
            stickybuf
          ];
          lazyPlugins = with plugins; [ nfnl nap none-ls qfheight trouble ];
          lazyGroups = with groups; [ treesitter ];
        };
      };
    };
}
