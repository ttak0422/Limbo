_: {
  flake.nixosModules.hm-shell = { ... }: {
    imports = [ ./zellij ./mcfly.nix ./zsh.nix ];
  };
}
