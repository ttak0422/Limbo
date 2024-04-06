{ pkgs, ... }:
let prefs = pkgs.dhallToNix (builtins.readFile ./tig.dhall);
in {
  home = {
    packages = with pkgs; [ tig ];
    file.".config/tig/config".text = prefs.config;
  };
}
