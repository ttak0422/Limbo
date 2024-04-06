_: {
  flake.nixosModules.darwin-desktop = {
    imports = [ ./skhd.nix ./spacebar.nix ./yabai.nix ];
  };
}
