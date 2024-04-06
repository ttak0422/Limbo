{ pkgs, ... }:
let prefs = pkgs.dhallToNix (builtins.readFile ./yabai.dhall);
in {
  services.yabai = {
    enable = true;
    enableScriptingAddition = false;
    extraConfig = prefs.config;
  };
}
