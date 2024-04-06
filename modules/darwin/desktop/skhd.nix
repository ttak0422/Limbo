{ pkgs, ... }:
let prefs = pkgs.dhallToNix (builtins.readFile ./skhd.dhall);
in {
  services.skhd = {
    enable = true;
    skhdConfig = prefs.config;
  };
}
