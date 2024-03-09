{ pkgs, ... }:
let inherit (builtins) readFile;
in {
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
