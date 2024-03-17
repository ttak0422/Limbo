{ pkgs, ... }:
let
  inherit (builtins) readFile;
  inherit (pkgs) callPackage;
  plugins = callPackage ./plugins.nix { };
  groups = callPackage ./groups.nix { };
  ftplugins = callPackage ./ftplugins.nix { };
in {
  test-v9 = {
    package = pkgs.neovim-v9;
    lazyGroups = with groups; [ treesitter ];
  };
  # test-lir = {
  #   package = pkgs.neovim-unwrapped;
  #   eagerPlugins = with pkgs.vimPluginsUnstable; [
  #     {
  #       plugin = lir-nvim;
  #       startupConfig = {
  #         language = "lua";
  #         code = readFile ./lua/lir.lua;
  #       };
  #     }
  #     plenary-nvim
  #     nvim-web-devicons
  #   ];
  # };
}
