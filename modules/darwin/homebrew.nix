{ inputs, ... }: {
  flake.nixosModules.darwin-homebrew = { pkgs, username, ... }:
    let
      inherit (inputs)
        homebrew-core homebrew-cask homebrew-cask-fonts homebrew-bundle;
    in rec {
      nix-homebrew = {
        enable = true;
        enableRosetta = true;
        user = username;
        taps = {
          "homebrew/homebrew-core" = homebrew-core;
          "homebrew/homebrew-cask" = homebrew-cask;
          "homebrew/homebrew-cask-fonts" = homebrew-cask-fonts;
          "homebrew/homebrew-bundle" = homebrew-bundle;
        };
        mutableTaps = false;
      };
      homebrew = {
        enable = true;
        taps = builtins.attrNames nix-homebrew.taps;
        brews = [ "lunchy" ];
        casks = [
          "alfred"
          "aquaskk"
          "cyberduck"
          "firefox"
          # "font-fira-code"
          # "font-hack-nerd-font"
          # "font-hackgen-nerd"
          # "font-jetbrains-mono-nerd-font"
          # "font-plemol-jp"
          # "font-plemol-jp-hs"
          # "font-plemol-jp-nf"
          # "font-roboto"
          # "font-roboto-mono"
          # "font-roboto-mono-nerd-font"
          "google-chrome"
          "keycastr"
          "neovide"
          "alacritty"
          "wezterm"
          "kitty"
        ];
        onActivation = { cleanup = "zap"; };
        global = { brewfile = true; };
      };
    };
}
